import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'note_model.g.dart';

enum NoteType { quickNotes, successes, goals, journal, habits, inspiration }

enum PriorityLevel { high, medium, low }

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final NoteType type;

  @HiveField(4)
  final PriorityLevel priority;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  final DateTime? updatedAt;

  @HiveField(7)
  final int? progressPercent;

  @HiveField(8)
  final String? progressUnit;

  @HiveField(9)
  final bool isFavorite;

  @HiveField(10)
  final bool isDisliked;

  const Note({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.priority,
    required this.createdAt,
    this.updatedAt,
    this.progressPercent,
    this.progressUnit,
    this.isFavorite = false,
    this.isDisliked = false,
  });

  factory Note.create({
    required String title,
    required String description,
    required NoteType type,
    required PriorityLevel priority,
    int? progressPercent,
    String? progressUnit,
    bool isFavorite = false,
    bool isDisliked = false,
  }) {
    if (title.trim().isEmpty) {
      throw ArgumentError('Title cannot be empty');
    }
    if (description.trim().isEmpty) {
      throw ArgumentError('Description cannot be empty');
    }
    if (progressPercent != null &&
        (progressPercent < 0 || progressPercent > 100)) {
      throw ArgumentError('Progress percentage must be between 0 and 100');
    }

    return Note(
      id: const Uuid().v4(),
      title: title.trim(),
      description: description.trim(),
      type: type,
      priority: priority,
      createdAt: DateTime.now(),
      progressPercent: progressPercent,
      progressUnit: progressUnit,
      isFavorite: isFavorite,
      isDisliked: isDisliked,
    );
  }

  Note copyWith({
    String? id,
    String? title,
    String? description,
    NoteType? type,
    PriorityLevel? priority,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? progressPercent,
    String? progressUnit,
    bool? isFavorite,
    bool? isDisliked,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      progressPercent: progressPercent ?? this.progressPercent,
      progressUnit: progressUnit ?? this.progressUnit,
      isFavorite: isFavorite ?? this.isFavorite,
      isDisliked: isDisliked ?? this.isDisliked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.name,
      'priority': priority.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'progressPercent': progressPercent,
      'progressUnit': progressUnit,
      'isFavorite': isFavorite,
      'isDisliked': isDisliked,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      type: NoteType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => NoteType.quickNotes,
      ),
      priority: PriorityLevel.values.firstWhere(
        (e) => e.name == map['priority'],
        orElse: () => PriorityLevel.medium,
      ),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : null,
      progressPercent: map['progressPercent'],
      progressUnit: map['progressUnit'],
      isFavorite: (map['isFavorite'] as bool?) ?? false,
      isDisliked: (map['isDisliked'] as bool?) ?? false,
    );
  }

  @override
  String toString() {
    return 'Note(id: $id, title: $title, type: $type, priority: $priority)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Note && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
