// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonsTypeHiveModelAdapter extends TypeAdapter<PokemonsTypeHiveModel> {
  @override
  PokemonsTypeHiveModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PokemonsTypeHiveModel.grass;
      case 1:
        return PokemonsTypeHiveModel.poison;
      case 2:
        return PokemonsTypeHiveModel.fire;
      case 3:
        return PokemonsTypeHiveModel.flying;
      case 4:
        return PokemonsTypeHiveModel.water;
      case 5:
        return PokemonsTypeHiveModel.bug;
      case 6:
        return PokemonsTypeHiveModel.normal;
      case 7:
        return PokemonsTypeHiveModel.electric;
      case 8:
        return PokemonsTypeHiveModel.ground;
      case 9:
        return PokemonsTypeHiveModel.fairy;
      case 10:
        return PokemonsTypeHiveModel.fighting;
      case 11:
        return PokemonsTypeHiveModel.psychic;
      case 12:
        return PokemonsTypeHiveModel.rock;
      case 13:
        return PokemonsTypeHiveModel.steel;
      case 14:
        return PokemonsTypeHiveModel.ice;
      case 15:
        return PokemonsTypeHiveModel.ghost;
      case 16:
        return PokemonsTypeHiveModel.dragon;
      case 17:
        return PokemonsTypeHiveModel.dark;
      case 18:
        return PokemonsTypeHiveModel.unknown;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, PokemonsTypeHiveModel obj) {
    switch (obj) {
      case PokemonsTypeHiveModel.grass:
        writer.writeByte(0);
        break;
      case PokemonsTypeHiveModel.poison:
        writer.writeByte(1);
        break;
      case PokemonsTypeHiveModel.fire:
        writer.writeByte(2);
        break;
      case PokemonsTypeHiveModel.flying:
        writer.writeByte(3);
        break;
      case PokemonsTypeHiveModel.water:
        writer.writeByte(4);
        break;
      case PokemonsTypeHiveModel.bug:
        writer.writeByte(5);
        break;
      case PokemonsTypeHiveModel.normal:
        writer.writeByte(6);
        break;
      case PokemonsTypeHiveModel.electric:
        writer.writeByte(7);
        break;
      case PokemonsTypeHiveModel.ground:
        writer.writeByte(8);
        break;
      case PokemonsTypeHiveModel.fairy:
        writer.writeByte(9);
        break;
      case PokemonsTypeHiveModel.fighting:
        writer.writeByte(10);
        break;
      case PokemonsTypeHiveModel.psychic:
        writer.writeByte(11);
        break;
      case PokemonsTypeHiveModel.rock:
        writer.writeByte(12);
        break;
      case PokemonsTypeHiveModel.steel:
        writer.writeByte(13);
        break;
      case PokemonsTypeHiveModel.ice:
        writer.writeByte(14);
        break;
      case PokemonsTypeHiveModel.ghost:
        writer.writeByte(15);
        break;
      case PokemonsTypeHiveModel.dragon:
        writer.writeByte(16);
        break;
      case PokemonsTypeHiveModel.dark:
        writer.writeByte(17);
        break;
      case PokemonsTypeHiveModel.unknown:
        writer.writeByte(18);
        break;
    }
  }
}
