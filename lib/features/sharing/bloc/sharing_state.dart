part of 'sharing_bloc.dart';

@immutable
sealed class SharingState {}

final class SharingInitial extends SharingState {}

class ShareLoaded extends SharingState {
  ShareLoaded({required this.files});

  final List<File> files;
}
