// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiaryEntryAdapter extends TypeAdapter<DiaryEntry> {
  @override
  final int typeId = 1;

  @override
  DiaryEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiaryEntry(
      title: fields[0] as String?,
      content: fields[1] as String,
      image: fields[3] as Image?,
      date: fields[4] as DateTime?,
      book: fields[7] as Book,
      startPage: (fields[5] as num).toInt(),
      endPage: (fields[6] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, DiaryEntry obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.startPage)
      ..writeByte(6)
      ..write(obj.endPage)
      ..writeByte(7)
      ..write(obj.book);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiaryEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
