part of 'test_bloc.dart';

final class TestState {
  TestState({
    this.tests = const [],
    this.albums = const [],
    this.loading = false,
  });

  final List<Test> tests;
  final List<Album> albums;
  final bool loading;

  TestState copyWith({
    List<Test>? tests,
    List<Album>? albums,
    bool? loading,
  }) {
    return TestState(
      tests: tests ?? this.tests,
      albums: albums ?? this.albums,
      loading: loading ?? this.loading,
    );
  }
}
