import 'package:flutter/foundation.dart';
import 'package:pokedex/data/network/dio_api_client.dart';
import 'package:pokedex/data/pokemon_detail_response.dart';
import 'package:pokedex/data/pokemon_list_response.dart';
import 'package:pokedex/data/state/remote_state.dart';

class PokemonService {
  final serviceName = '/pokemon';
  final http = DioApiClient();

  Future<RemoteState>fetchPokemons() async {
    try {
      if (kDebugMode) {
        print(serviceName);
      }

      final response = await http.dio.get(
        serviceName,
      );

      if (response.statusCode == 200) {
        return RemoteStateSuccess<PokemonListResponse>(
          PokemonListResponse.fromJson(response.data));
      } else {
        throw Exception("Failed to load pokemons");
      }
    } catch (e) {
      throw Exception('Failed to load pokemons: ${e.toString()}');
    }
  }

  Future<RemoteState> fetchPokemonDetail(int pokemonId) async {
    try {
      final response = await http.dio.get(
        '$serviceName/$pokemonId',
      );

      if (response.statusCode == 200) {
        return RemoteStateSuccess<PokemonDetailResponse>(
          PokemonDetailResponse.fromJson(response.data));
      } else {
        throw Exception('Failed to load pokemon details');
      }
    } catch (e) {
      throw Exception('Failed to laod pokemon details: $e');
    }
  }
}
