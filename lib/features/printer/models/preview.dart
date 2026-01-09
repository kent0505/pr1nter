import 'dart:io';

final class Preview {
  Preview({
    required this.files,
    this.docs = false,
    this.font = '',
  });

  final List<File> files;
  final bool docs;
  final String font;
}
