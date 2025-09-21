import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../shared/models/note_model.dart';

class NoteTypeAdapter extends TypeAdapter<NoteType> {
  @override
  final int typeId = 1;

  @override
  NoteType read(BinaryReader reader) {
    return NoteType.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, NoteType obj) {
    writer.writeByte(obj.index);
  }
}

class PriorityLevelAdapter extends TypeAdapter<PriorityLevel> {
  @override
  final int typeId = 2;

  @override
  PriorityLevel read(BinaryReader reader) {
    return PriorityLevel.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, PriorityLevel obj) {
    writer.writeByte(obj.index);
  }
}

class HiveService {
  static const String _notesBoxName = 'notes';

  static Future<void> init() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);

      Hive.registerAdapter(NoteTypeAdapter());
      Hive.registerAdapter(PriorityLevelAdapter());

      Hive.registerAdapter(NoteAdapter());

      await Hive.openBox<Note>(_notesBoxName);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> close() async {
    await Hive.close();
  }

  // Notes operations
  static Box<Note> get notesBox => Hive.box<Note>(_notesBoxName);

  static ValueListenable<Box<Note>> notesListenable() {
    return notesBox.listenable();
  }

  static Future<void> addNote(Note note) async {
    try {
      await notesBox.put(note.id, note);
    } catch (e) {
      throw Exception('Failed to save note to Hive: ${e.toString()}');
    }
  }

  static Future<void> updateNote(Note note) async {
    try {
      await notesBox.put(note.id, note.copyWith(updatedAt: DateTime.now()));
    } catch (e) {
      throw Exception('Failed to update note in Hive: ${e.toString()}');
    }
  }

  static Future<void> deleteNote(String id) async {
    try {
      await notesBox.delete(id);
    } catch (e) {
      throw Exception('Failed to delete note from Hive: ${e.toString()}');
    }
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
