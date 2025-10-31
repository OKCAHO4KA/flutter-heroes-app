import 'package:prueba_jun/library.dart';

class MainProvider extends ChangeNotifier {
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

  //fetch List Heroes
  Future<void> fetchListHeroes(String name, String status, {int? page}) async {
    isLoading = true;

    final cachedHeroes = await LocalCache.loadHeroes();
    if (cachedHeroes.isNotEmpty) {
      heroes = cachedHeroes;
      isLoading = false;
      notifyListeners();
      return;
    }

    heroesModel = await ApiService.fetchListHeroes(
      name: name,
      status: status,
      currentPage: page ?? currentPage,
    );
    //если без фильтров - сохраняем в список героев и показываем на главном экране
    if (name.isEmpty && status.isEmpty) {
      heroes = [...heroes, ...heroesModel.results.map((e) => e)];
      hasMore = heroesModel.info.next != null;
      await LocalCache.saveHeroes(heroes);
    } else {
      // если с фильтрами - сохраняем , только исключаем показ героев, которые добавленны в избранное
      heroesWithFiltres = heroesModel.results
          .where((hero) => !heroesFavoritos.any((fav) => fav.id == hero.id))
          .toList();
    }
    isLoading = false;
    notifyListeners();
  }

  addOrDeleteToFavoritesMainView(int id) async {
    isLoading = true;

    final heroeById = await ApiService.fetchHeroeById(id);

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
    await LocalCache.saveHeroesFavorites(heroesFavoritos);
    isLoading = false;
    notifyListeners();
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
      final heroeById = await ApiService.fetchHeroeById(idHeroe);
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
      final heroeById = await ApiService.fetchHeroeById(idHeroe);
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
