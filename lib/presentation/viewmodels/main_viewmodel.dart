import 'package:flutter/material.dart';
import 'package:poked3x/common/enum/screen_status.dart';
import 'package:poked3x/common/utils/app_state.dart';
import 'package:poked3x/data/models/detail_pokemon.dart';
import 'package:poked3x/data/models/pokemon.dart';
import 'package:poked3x/data/repositories/pokemon_repository.dart';

class MainViewmodel extends ChangeNotifier {
  MainViewmodel._internal();
  static final _singleton = MainViewmodel._internal();
  factory MainViewmodel() => _singleton;
  final _repository = PokemonRepository();
  AppState<List<Pokemon>> _listState = AppState();
  AppState<List<Pokemon>> get listState => _listState;
  Future<void> fetchPokemonList({int? offset = 0}) async {
    _listState = _listState.copyWith(screenState: ScreenStatus.loading);
    notifyListeners();
    final response = await _repository.fetchPokemonList(offset: offset);
    response.fold((failure) {
      _listState = _listState.copyWith(
        screenState: ScreenStatus.error,
        errorMessage: failure.message,
      );
      notifyListeners();
    }, (data) {
      _listState = _listState.copyWith(
          screenState: ScreenStatus.success,
          data: (_listState.data ?? [])..addAll(data),
          errorMessage: null);
      notifyListeners();
    });
  }

  AppState<DetailPokemon> _appState = AppState();
  AppState<DetailPokemon> get appState => _appState;

  Future<void> fetchDetailPokemon({required int id}) async {
    _appState = _appState.copyWith(screenState: ScreenStatus.loading);
    notifyListeners();
    final response = await _repository.fetchDetailPokemon(id: id);
    response.fold(
      (failure) {
        _appState = _appState.copyWith(
          screenState: ScreenStatus.error,
          errorMessage: failure.message,
        );
        notifyListeners();
      },
      (data) {
        _appState = _appState.copyWith(
            screenState: ScreenStatus.success, data: data, errorMessage: null);
        notifyListeners();
      },
    );
  }
}
