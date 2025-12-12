import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';
import '../data/test_repository.dart';
import '../models/album.dart';
import '../models/test.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final TestRepository _testRepository;

  TestBloc({required TestRepository repository})
      : _testRepository = repository,
        super(TestState()) {
    on<TestEvent>(
      (event, emit) => switch (event) {
        LoadTests() => _loadTests(event, emit),
      },
    );
  }

  void _loadTests(
    LoadTests event,
    Emitter<TestState> emit,
  ) async {
    emit(state.copyWith(loading: true));

    try {
      final tests = await _testRepository.loadTests();

      emit(state.copyWith(
        tests: tests,
        loading: false,
      ));
    } catch (e) {
      logger('Error loading tests: $e');

      emit(state.copyWith(loading: false));
    }
  }
}
