import 'package:prueba_jun/library.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    final mainProvider = context.read<MainProvider>();
    mainProvider.fetchListHeroes("", "", mainProvider.currentPage);
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final mainProvider = context.read<MainProvider>();
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 300 &&
        !mainProvider.isLoading &&
        mainProvider.hasMore) {
      fetchHeroes();
    }
  }

  Future<void> fetchHeroes() async {
    final mainProvider = context.read<MainProvider>();
    await mainProvider.fetchListHeroes("", "", mainProvider.currentPage++);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes.of(context);
    final mainProvider = Provider.of<MainProvider>(context);
    if (mainProvider.isLoading) {
      return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height - 172,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return mainProvider.isLoading
        ? Center(child: Text("Список героев пуст", style: theme.medium18))
        : Container(
            margin: const EdgeInsets.symmetric(
              horizontal: GeneralConstants.padding20,
            ),
            width: MediaQuery.sizeOf(context).width,
            height:
                MediaQuery.sizeOf(context).height -
                172, //98 appbar +74 bottombar

            child: SingleChildScrollView(
              controller: _scrollController,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(mainProvider.heroes.length, (index) {
                  return ItemHeroeWidget(
                    isFavorite: mainProvider.isFavorite(
                      mainProvider.heroes[index].id,
                    ),
                    heroe: mainProvider.heroes[index],
                    onTapStar: () =>
                        mainProvider.addOrDeleteToFavoritesMainView(
                          mainProvider.heroes[index].id,
                        ),
                  );
                }),
              ),
            ),
          );
  }
}
