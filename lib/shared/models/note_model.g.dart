part of 'note_model.dart';

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 0;

  @override
  Note read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Note(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      type: fields[3] as NoteType,
      priority: fields[4] as PriorityLevel,
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime?,
      progressPercent: fields[7] as int?,
      progressUnit: fields[8] as String?,
      isFavorite: (fields[9] as bool?) ?? false,
      isDisliked: (fields[10] as bool?) ?? false,
    );
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.priority)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.progressPercent)
      ..writeByte(8)
      ..write(obj.progressUnit)
      ..writeByte(9)
      ..write(obj.isFavorite)
      ..writeByte(10)
      ..write(obj.isDisliked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
