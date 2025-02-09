// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

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
      name: fields[1] as String,
      boolValue: fields[3] as bool?,
      numberValue: fields[4] as num?,
      stringValue: fields[5] as String?,
      objectValue: fields[6] as Object?,
    )
      .._isInternal = fields[0] as bool
      .._description = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, Setting obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj._isInternal)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj._description)
      ..writeByte(3)
      ..write(obj.boolValue)
      ..writeByte(4)
      ..write(obj.numberValue)
      ..writeByte(5)
      ..write(obj.stringValue)
      ..writeByte(6)
      ..write(obj.objectValue);
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
