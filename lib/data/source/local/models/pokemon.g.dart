// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonHiveModelAdapter extends TypeAdapter<PokemonHiveModel> {
  @override
  PokemonHiveModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonHiveModel()
      ..number = fields[0] as String
      ..name = fields[1] as String
      ..description = fields[2] as String
      ..types = (fields[3] as List)?.cast<PokemonsTypeHiveModel>()
      ..image = fields[4] as String
      ..height = fields[5] as String
      ..weight = fields[6] as String
      ..genera = fields[7] as String
      ..eggGroups = (fields[8] as List)?.cast<PokemonsTypeHiveModel>()
      ..gender = fields[9] as PokemonGenderHiveModel
      ..stats = fields[10] as PokemonStatsHiveModel;
  }

  @override
  void write(BinaryWriter writer, PokemonHiveModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.types)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.height)
      ..writeByte(6)
      ..write(obj.weight)
      ..writeByte(7)
      ..write(obj.genera)
      ..writeByte(8)
      ..write(obj.eggGroups)
      ..writeByte(9)
      ..write(obj.gender)
      ..writeByte(10)
      ..write(obj.stats);
  }
}
