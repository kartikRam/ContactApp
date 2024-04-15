// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contactdata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactDataAdapter extends TypeAdapter<ContactData> {
  @override
  final int typeId = 5;

  @override
  ContactData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactData(
      first_name: fields[0] as String,
      last_name: fields[1] as String,
      mobile_no: fields[2] as String,
      email: fields[3] as String,
      category: fields[4] as String,
      image: fields[5] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, ContactData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.first_name)
      ..writeByte(1)
      ..write(obj.last_name)
      ..writeByte(2)
      ..write(obj.mobile_no)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
