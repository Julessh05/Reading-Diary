// GENERATED CODE - DO NOT MODIFY BY HAND

part of models;

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingAdapter extends TypeAdapter<Setting> {
  @override
  final int typeId = 3;

  @override
  Setting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Setting(
      name: fields[2] as String,
      boolValue: fields[4] as bool?,
      numberValue: fields[5] as num?,
      stringValue: fields[6] as String?,
      objectValue: fields[7] as Object?,
    )
      .._valueType = fields[0] as Type
      .._isInternal = fields[1] as bool
      .._description = fields[3] as String
      .._icon = fields[8] as Icon;
  }

  @override
  void write(BinaryWriter writer, Setting obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj._valueType)
      ..writeByte(1)
      ..write(obj._isInternal)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj._description)
      ..writeByte(4)
      ..write(obj.boolValue)
      ..writeByte(5)
      ..write(obj.numberValue)
      ..writeByte(6)
      ..write(obj.stringValue)
      ..writeByte(7)
      ..write(obj.objectValue)
      ..writeByte(8)
      ..write(obj._icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
