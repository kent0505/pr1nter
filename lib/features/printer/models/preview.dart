import 'dart:io';

final class Preview {
  Preview({
    required this.files,
    this.font = '',
  });

  final List<File> files;
  final String font;
}
