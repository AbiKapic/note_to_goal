import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../shared/models/note_model.dart';

class HiveService {
  static const String _notesBoxName = 'notes';

  static Future<void> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    Hive.registerAdapter(NoteAdapter());

    await Hive.openBox<Note>(_notesBoxName);
  }

  static Future<void> close() async {
    await Hive.close();
  }

  // Notes operations
  static Box<Note> get notesBox => Hive.box<Note>(_notesBoxName);

  static Future<void> addNote(Note note) async {
    await notesBox.put(note.id, note);
  }

  static Future<void> updateNote(Note note) async {
    await notesBox.put(note.id, note.copyWith(updatedAt: DateTime.now()));
  }

  static Future<void> deleteNote(String id) async {
    await notesBox.delete(id);
  }

  static List<Note> getAllNotes() {
    return notesBox.values.toList();
  }

  static List<Note> getNotesByType(NoteType type) {
    return notesBox.values.where((note) => note.type == type).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  static Note? getNoteById(String id) {
    return notesBox.get(id);
  }

  static int getNotesCountByType(NoteType type) {
    return notesBox.values.where((note) => note.type == type).length;
  }

  static Map<NoteType, int> getAllNotesCountByType() {
    final Map<NoteType, int> counts = {};
    for (final type in NoteType.values) {
      counts[type] = getNotesCountByType(type);
    }
    return counts;
  }
}
