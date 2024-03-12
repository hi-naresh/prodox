// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoutineModelAdapterAdapter extends TypeAdapter<RoutineModelAdapter> {
  @override
  final int typeId = 1;

  @override
  RoutineModelAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoutineModelAdapter(
      id: fields[0] as String,
      userId: fields[1] as String,
      tasks: (fields[2] as List).cast<TaskModelAdapter>(),
    );
  }

  @override
  void write(BinaryWriter writer, RoutineModelAdapter obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.tasks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutineModelAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
