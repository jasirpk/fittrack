// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemsModalAdapter extends TypeAdapter<ItemsModal> {
  @override
  final int typeId = 0;

  @override
  ItemsModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemsModal(
      fitnessItemImage: fields[0] as String,
      fitnessItemDemoImage: fields[1] as String,
      itemName: fields[2] as String,
      SelectedWorkoutLevel: fields[3] as String,
      SelectedCategory: fields[4] as String,
      SelctedWorkoutPlan: fields[5] as String,
      Description: fields[6] as String,
      isFavorite: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ItemsModal obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.fitnessItemImage)
      ..writeByte(1)
      ..write(obj.fitnessItemDemoImage)
      ..writeByte(2)
      ..write(obj.itemName)
      ..writeByte(3)
      ..write(obj.SelectedWorkoutLevel)
      ..writeByte(4)
      ..write(obj.SelectedCategory)
      ..writeByte(5)
      ..write(obj.SelctedWorkoutPlan)
      ..writeByte(6)
      ..write(obj.Description)
      ..writeByte(7)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemsModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
