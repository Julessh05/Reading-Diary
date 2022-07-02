// GENERATED CODE - DO NOT MODIFY BY HAND

part of models;

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookAdapter extends TypeAdapter<Book> {
  @override
  final int typeId = 0;

  @override
  Book read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Book(
      name: fields[0] as String,
      author: fields[1] as String?,
      image: fields[2] as Image?,
      pages: fields[3] as int,
      currentPage: fields[4] as int,
      notes: fields[5] as String,
      price: fields[6] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.pages)
      ..writeByte(4)
      ..write(obj.currentPage)
      ..writeByte(5)
      ..write(obj.notes)
      ..writeByte(6)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
