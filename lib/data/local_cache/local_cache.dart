import 'dart:convert';
import 'package:prueba_jun/features/main/entity/heroe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalCache {
  static const _heroesKey = 'cachedHeroes';
  static const _heroesFavoritesKey = 'cachedHeroesFavorites';

  static Future<void> saveHeroes(List<Heroe> heroes) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = heroes.map((h) => h.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await prefs.setString(_heroesKey, jsonString);
  }

  static Future<List<Heroe>> loadHeroes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_heroesKey);
    if (jsonString == null) return [];

    final decoded = json.decode(jsonString) as List;
    return decoded.map((e) => Heroe.fromJson(e)).toList();
  }

  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_heroesKey);
  }

  //filters
  static Future<void> saveHeroesFavorites(List<Heroe> heroesWithFiltres) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = heroesWithFiltres.map((h) => h.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await prefs.setString(_heroesFavoritesKey, jsonString);
  }

  static Future<List<Heroe>> loadHeroesFilters() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_heroesFavoritesKey);
    if (jsonString == null) return [];

    final decoded = json.decode(jsonString) as List;
    return decoded.map((e) => Heroe.fromJson(e)).toList();
  }

  static Future<void> clearCacheFilters() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_heroesFavoritesKey);
  }
}
