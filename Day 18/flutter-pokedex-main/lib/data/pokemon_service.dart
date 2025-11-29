import 'package:flutter/foundation.dart';
import 'package:pokedex/data/http_client.dart';
import 'package:pokedex/data/pokemon_detail_response.dart';
import 'package:pokedex/data/pokemon_list_response.dart';

class PokemonService {
  final serviceName = 'pokemon';
  final http = HttpClient();

  Future<PokemonListResponse> fetchPokemons() async {
    try {
      if (kDebugMode) {
        print("$serviceName");
      }

      final response = await http.client.get(
        Uri.parse('${http.baseUrl}/$serviceName'),
      );

      if (response.statusCode == 200) {
        return pokemonListResponseFromJson(response.body);
      } else {
        throw Exception("Failed to load pokemons");
      }
    } catch (e) {
      throw Exception('Failed to load pokemons: ${e.toString()}');
    }
  }

  Future<PokemonDetailResponse> fetchPokemonDetail(int pokemonId) async {
    try {
      final response = await http.client.get(
        Uri.parse('${http.baseUrl}/$serviceName/$pokemonId'),
      );

      if (response.statusCode == 200) {
        return pokemonDetailResponseFromJson(response.body);
      } else {
        throw Exception('Failed to load pokemon details');
      }
    } catch (e) {
      throw Exception('Failed to laod pokemon details: $e');
    }
  }
}
