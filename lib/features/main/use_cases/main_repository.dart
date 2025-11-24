import 'package:prueba_jun/features/main/entity/heroe_model.dart';

abstract class MainRepository {
  Future<HeroeModel> fetchHeroes({String? name, String? status, int? page});
  Future<Heroe> fetchHeroeById(int id);

  Future<List<Heroe>> fetchHeroesLocalCache();
  Future<void> saveHeroesLocalCache(List<Heroe> heroes);
  Future<void> saveHeroesFavoritesLocalCache(List<Heroe> heroes);
  Future<void> cleanHeroesLocalCache();
  Future<void> cleanHeroesFavoritesLocalCache();
  Future<void> fetchHeroesFavoritesLocalCache();
}
