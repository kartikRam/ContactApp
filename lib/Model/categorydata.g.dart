// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categorydata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryDataAdapter extends TypeAdapter<CategoryData> {
  @override
  final int typeId = 4;

  @override
  CategoryData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryData(
      category: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
