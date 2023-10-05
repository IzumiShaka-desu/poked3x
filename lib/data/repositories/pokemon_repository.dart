import 'package:poked3x/common/utils/exception.dart';
import 'package:poked3x/common/utils/type_definition.dart';

import '../datasources/pokemon_datasources.dart';

class PokemonRepository {
  PokemonRepository._internal();
  static final _singleton = PokemonRepository._internal();
  factory PokemonRepository() => _singleton;
  final _datasources = PokemonDatasources();
  Future<PokemonsOrFailure> fetchPokemonList({int? offset = 0}) =>
      tryCatch(() async {
        final response = await _datasources.fetchPokemonList(offset: offset);
        return response.results;
      });
  Future<DetailPokemonOrFailure> fetchDetailPokemon({required int id}) =>
      tryCatch(() async {
        final response = await _datasources.fetchDetailPokemon(id: id);
        return response;
      });
}
