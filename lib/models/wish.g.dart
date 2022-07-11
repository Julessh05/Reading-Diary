// GENERATED CODE - DO NOT MODIFY BY HAND

part of models;

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishAdapter extends TypeAdapter<Wish> {
  @override
  final int typeId = 2;

  @override
  Wish read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Wish(
      book: fields[0] as Book?,
      description: fields[2] as String?,
    )..title = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, Wish obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.book)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
