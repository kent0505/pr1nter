part of 'sharing_bloc.dart';

@immutable
sealed class SharingEvent {}

class ListenToShare extends SharingEvent {}

class ShareReceived extends SharingEvent {
  ShareReceived({required this.files});

  final List<SharedMediaFile> files;
}
