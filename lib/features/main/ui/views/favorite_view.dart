import 'package:prueba_jun/library.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final mainProvider = context.watch<MainProvider>();
    List<Heroe> list = [
      ...mainProvider.heroesFavoritos,
      ...mainProvider.heroesWithFiltres,
    ];
    final theme = UIThemes.of(context);
    if (mainProvider.isLoading) {
      return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height - 172,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GeneralConstants.paddingHorizontal,
            vertical: GeneralConstants.padding10,
          ),
          child: FilterRowWidget(
            hintStatus: "Поиск по статусу",
            hintName: "Поиск по любимым героям",
            onSelected: (String label) =>
                mainProvider.fetchListHeroes("", label),
            onEdittingComplete: () {
              try {
                mainProvider.fetchListHeroes(
                  mainProvider.nameController.text,
                  "",
                );
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            nameController: mainProvider.nameController,
            statusController: mainProvider.statusController,
          ),
        ),
        mainProvider.heroesFavoritos.isEmpty
            ? Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                  horizontal: GeneralConstants.padding20,
                ),
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height - 172 - 50 - 20,
                child: Center(
                  child: Text(
                    "Вы пока не добавили любимых героев",
                    style: theme.medium18,
                  ),
                ),
              )
            : Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: GeneralConstants.padding20,
                    ),
                    width: MediaQuery.sizeOf(context).width,
                    height:
                        MediaQuery.sizeOf(context).height -
                        172 -
                        50 -
                        20, //172(98 appbar + 74 bottombar) - 50 fields(24+26) - 20 padding(2*10)
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      itemCount: list.length,
                      // mainProvider.heroesFavoritos.length +
                      // mainProvider.heroesWithFiltres.length,
                      itemBuilder: (context, index) {
                        if (list[index].isFavorite == true) {
                          return FadeHeroeWidget(
                            key: ValueKey(list[index].id),
                            heroe: list[index],
                            isFavorite: list[index].isFavorite ?? false,
                            onFavoriteToggle: () {
                              mainProvider.addOrDeleteToFavoritesFavoriteView(
                                list[index].id,
                              );
                            },
                          );
                        } else {
                          return ItemHeroeWidget(
                            heroe: list[index],
                            isFavorite: list[index].isFavorite ?? false,
                            onTapStar: () {
                              mainProvider.addOrDeleteToFavoritesFavoriteView(
                                list[index].id,
                              );
                            },
                          );
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 10);
                      },
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}

class FadeHeroeWidget extends StatefulWidget {
  final Heroe heroe;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const FadeHeroeWidget({
    super.key,
    required this.heroe,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  State<FadeHeroeWidget> createState() => _FadeHeroeWidgetState();
}

class _FadeHeroeWidgetState extends State<FadeHeroeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  Future<void> fade() async {
    await _controller.forward();
    widget.onFavoriteToggle();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ItemHeroeWidget(
        key: ValueKey(widget.heroe.id),
        heroe: widget.heroe,
        isFavorite: widget.isFavorite,
        onTapStar: () {
          fade();
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
