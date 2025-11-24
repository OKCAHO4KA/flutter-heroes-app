import 'package:prueba_jun/config/helpers/api_service.dart';
import 'package:prueba_jun/data/local_cache/local_cache.dart';
import 'package:prueba_jun/features/main/entity/heroe_model.dart';
import 'package:prueba_jun/features/main/use_cases/main_repository.dart';

class MainRepositoryImpl extends MainRepository {
  MainRepositoryImpl();

  @override
  Future<Heroe> fetchHeroeById(int id) async {
    try {
      final response = await ApiService.fetchHeroeById(id);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<HeroeModel> fetchHeroes({
    String? name,
    String? status,
    int? page,
  }) async {
    try {
      final response = await ApiService.fetchListHeroes(
        name: name ?? "",
        status: status ?? "",
        currentPage: page ?? 1,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Heroe>> fetchHeroesLocalCache() async {
    try {
      final response = await LocalCache.loadHeroes();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Heroe>> fetchHeroesFavoritesLocalCache() async {
    try {
      final response = await LocalCache.loadHeroesFavorites();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveHeroesLocalCache(List<Heroe> heroes) async {
    try {
      await LocalCache.saveHeroes(heroes);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveHeroesFavoritesLocalCache(List<Heroe> heroes) async {
    try {
      await LocalCache.saveHeroesFavorites(heroes);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> cleanHeroesLocalCache() async {
    try {
      await LocalCache.clearCache();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> cleanHeroesFavoritesLocalCache() async {
    try {
      await LocalCache.clearFavoritesCache();
    } catch (e) {
      rethrow;
    }
  }
}
