import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
      // Initialize Hive with Flutter
      await Hive.initFlutter();
      
      // Register adapters only if not already registered
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(NoteTypeAdapter());
      }
      if (!Hive.isAdapterRegistered(2)) {
        Hive.registerAdapter(PriorityLevelAdapter());
      }
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(NoteAdapter());
      }

      // Open the box if not already open
      if (!Hive.isBoxOpen(_notesBoxName)) {
        await Hive.openBox<Note>(_notesBoxName);
      }
    } catch (e) {
      print('Hive initialization error: $e');
      rethrow;
    }
  }

  static Future<void> close() async {
    await Hive.close();
  }
  static Box<Note> get notesBox => Hive.box<Note>(_notesBoxName);

  static ValueListenable<Box<Note>> notesListenable() {
    return notesBox.listenable();
  }

  static Future<void> addNote(Note note) async {
    try {
      // Ensure the box is open
      if (!Hive.isBoxOpen(_notesBoxName)) {
        await Hive.openBox<Note>(_notesBoxName);
      }
      
      final box = notesBox;
      await box.put(note.id, note);
      await box.flush(); // Force write to disk
      
      print('Note saved successfully: ${note.id} - ${note.title}');
    } catch (e) {
      print('Failed to save note to Hive: $e');
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
    return notesBox.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
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

  static Future<void> toggleNoteFavorite(String noteId) async {
    final note = getNoteById(noteId);
    if (note == null) return;
    await updateNote(note.copyWith(isFavorite: !note.isFavorite));
  }

  static Future<void> toggleNoteDisliked(String noteId) async {
    final note = getNoteById(noteId);
    if (note == null) return;
    await updateNote(note.copyWith(isDisliked: !note.isDisliked));
  }

  static List<Note> getFavoriteNotes() {
    return notesBox.values.where((n) => n.isFavorite).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  static List<Note> getDislikedNotes() {
    return notesBox.values.where((n) => n.isDisliked).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  static List<Note> getCompletedNotes() {
    return notesBox.values
        .where((n) => (n.progressPercent ?? 0) >= 100)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
}
