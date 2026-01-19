// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_movie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouriteMovieAdapter extends TypeAdapter<FavouriteMovie> {
  @override
  final int typeId = 1;

  @override
  FavouriteMovie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouriteMovie(
      id: fields[0]?? 0,
      title: fields[1]?? '',
      releaseDate: fields[2]?? '',
      posterPath: fields[3]?? '',
    );
  }

  @override
  void write(BinaryWriter writer, FavouriteMovie obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.releaseDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouriteMovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}