import 'package:prueba_jun/features/main/use_cases/main_repository_impl.dart';
import 'package:prueba_jun/library.dart';

class MainProvider extends ChangeNotifier {
  final MainRepositoryImpl mainRepository;

  TextEditingController nameController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;

  //change Views
  ViewsType currentView = ViewsType.main;
  changeCurrentView(ViewsType newView) {
    currentView = newView;
    heroesWithFiltres = [];
    nameController.clear();
    statusController.clear();
    notifyListeners();
  }

  //darkTheme
  bool isDarkTheme = false;
  setDarkTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  List<Heroe> heroes = [];
  List<Heroe> heroesFavoritos = [];
  List<Heroe> heroesWithFiltres = [];
  late HeroeModel heroesModel;

  MainProvider({required this.mainRepository});

  //fetch List Heroes
  Future<void> fetchListHeroes(String name, String status, int page) async {
    isLoading = true;
    try {
      heroesModel = await mainRepository.fetchHeroes(
        name: name,
        status: status,
        page: currentPage,
      );
      //если без фильтров - сохраняем в список героев и показываем на главном экране
      if (name.isEmpty && status.isEmpty) {
        heroes = [...heroes, ...heroesModel.results.map((e) => e)];
        hasMore = heroesModel.info.next != null;
        await mainRepository.saveHeroesLocalCache(heroes);
      } else {
        // если с фильтрами - сохраняем , только исключаем показ героев, которые добавленны в избранное
        heroesWithFiltres = heroesModel.results
            .where((hero) => !heroesFavoritos.any((fav) => fav.id == hero.id))
            .toList();
      }
    } catch (e) {
      final cachedHeroes = await mainRepository.fetchHeroesLocalCache();
      if (cachedHeroes.isNotEmpty) {
        heroes = cachedHeroes;
        isLoading = false;
        notifyListeners();
      }
    }
    isLoading = false;
    notifyListeners();
  }

  addOrDeleteToFavoritesMainView(int id) async {
    isLoading = true;
    try {
      final heroeById = await mainRepository.fetchHeroeById(id);

      if (heroesFavoritos.isEmpty) {
        heroesFavoritos.add(heroeById);
      } else {
        if (heroesFavoritos.any((e) => e.id == id)) {
          heroesFavoritos = heroesFavoritos.map((heroe) {
            heroe.isFavorite = false;
            return heroe;
          }).toList();
          heroesFavoritos.removeWhere((heroe) => heroe.id == id);
          isLoading = false;
          notifyListeners();
          return;
        } else {
          heroesFavoritos.add(heroeById);
        }
      }
      heroesFavoritos = heroesFavoritos.map((heroe) {
        heroe.isFavorite = true;
        return heroe;
      }).toList();
      await mainRepository.saveHeroesFavoritesLocalCache(heroesFavoritos);
    } catch (e) {
      final cachedHeroesFavorites = await mainRepository
          .fetchHeroesFavoritesLocalCache();
      if (cachedHeroesFavorites.isNotEmpty) {
        heroesFavoritos = cachedHeroesFavorites;
        isLoading = false;
        notifyListeners();
      }
      isLoading = false;
      notifyListeners();
    }
  }

  bool isFavorite(int id) {
    if (heroesFavoritos.any((heroe) => heroe.id == id)) {
      return true;
    } else {
      return false;
    }
  }

  //add to favoriteList o delete from it in favorite view
  addOrDeleteToFavoritesFavoriteView(int idHeroe) async {
    if (heroesFavoritos.any((e) => e.id == idHeroe && e.isFavorite == true)) {
      heroesFavoritos.removeWhere((heroe) {
        heroe.id == idHeroe ? heroe.isFavorite = false : null;
        return heroe.id == idHeroe;
      });
      notifyListeners();
    } else {
      isLoading = true;
      final heroeById = await mainRepository.fetchHeroeById(idHeroe);
      heroeById.isFavorite = true;
      heroesWithFiltres.removeWhere((heroe) {
        heroe.id == idHeroe;
        return heroe.id == idHeroe;
      });
      heroesFavoritos.add(heroeById);
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }

  //add to favoriteList o delete from it in favorite view
  addToFavoritesFromWithFilters(int idHeroe) async {
    if (heroesFavoritos.any((e) => e.id == idHeroe && e.isFavorite == true)) {
      heroesFavoritos.removeWhere((heroe) {
        heroe.id == idHeroe ? heroe.isFavorite = false : null;
        return heroe.id == idHeroe;
      });
      notifyListeners();
    } else {
      isLoading = true;
      final heroeById = await mainRepository.fetchHeroeById(idHeroe);
      heroeById.isFavorite = true;
      heroesWithFiltres.removeWhere((heroe) {
        heroe.id == idHeroe;
        return heroe.id == idHeroe;
      });
      heroesFavoritos.add(heroeById);
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }
}
