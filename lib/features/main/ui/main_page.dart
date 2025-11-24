import 'package:prueba_jun/library.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes.of(context);
    final mainProvider = Provider.of<MainProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actionsPadding: const EdgeInsets.only(right: 10),
        automaticallyImplyLeading: false,
        title: Text(
          GeneralConstants.appTitle,
          style: theme.bold23.copyWith(color: theme.textAppBar),
        ),
        actions: [
          IconButton(
            onPressed: () {
              mainProvider.setDarkTheme();
            },
            icon: Icon(
              mainProvider.isDarkTheme ? Icons.sunny : Icons.nightlight,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              mainProvider.currentView == ViewsType.main
                  ? MainView()
                  : FavoriteView(),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ItemBottomAppBar(
              isActive: mainProvider.currentView == ViewsType.main,
              icon: Icons.home,
              onPressed: () => mainProvider.changeCurrentView(ViewsType.main),
            ),
            ItemBottomAppBar(
              icon: Icons.favorite,
              isActive: mainProvider.currentView == ViewsType.favorite,
              onPressed: () =>
                  mainProvider.changeCurrentView(ViewsType.favorite),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemBottomAppBar extends StatelessWidget {
  const ItemBottomAppBar({
    super.key,
    required this.icon,
    this.onPressed,
    required this.isActive,
  });
  final IconData icon;
  final Function()? onPressed;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    final theme = UIThemes.of(context);
    return IconButton(
      icon: Icon(
        icon,
        size: 30,
        color: isActive
            ? theme.textAppBar
            : theme.textAppBar.withValues(alpha: 0.3),
      ),
      onPressed: () => onPressed != null ? onPressed!() : null,
    );
  }
}
