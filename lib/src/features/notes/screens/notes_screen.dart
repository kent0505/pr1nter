import 'package:flutter/material.dart';

import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/field.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  static const routePath = '/NotesScreen';

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final noteController = TextEditingController();

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: 'Notes'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Field(
            controller: noteController,
            hintText: 'Enter or paste any text here',
            fieldType: FieldType.multiline,
          ),
        ],
      ),
    );
  }
}
