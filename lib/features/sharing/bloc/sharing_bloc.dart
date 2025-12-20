import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../../../core/utils.dart';

part 'sharing_event.dart';
part 'sharing_state.dart';

class SharingBloc extends Bloc<SharingEvent, SharingState> {
  late final StreamSubscription<List<SharedMediaFile>> _intentSub;

  SharingBloc() : super(SharingInitial()) {
    on<SharingEvent>(
      (event, emit) => switch (event) {
        ListenToShare() => _onListenToShare(event, emit),
        ShareReceived() => _onShareReceived(event, emit),
      },
    );
  }

  void _onListenToShare(
    ListenToShare event,
    Emitter<SharingState> emit,
  ) async {
    _intentSub = ReceiveSharingIntent.instance.getMediaStream().listen(
      (files) {
        add(ShareReceived(files: files));
      },
      onError: (e) {
        logger(e);
      },
    );

    final initial = await ReceiveSharingIntent.instance.getInitialMedia();
    if (initial.isNotEmpty) {
      add(ShareReceived(files: initial));
      ReceiveSharingIntent.instance.reset();
    }
  }

  void _onShareReceived(
    ShareReceived event,
    Emitter<SharingState> emit,
  ) {
    emit(
      ShareLoaded(
        files: event.files.map((file) => File(file.path)).toList(),
      ),
    );
  }

  @override
  Future<void> close() {
    _intentSub.cancel();
    return super.close();
  }
}
