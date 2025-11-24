import 'package:prueba_jun/features/main/use_cases/main_repository_impl.dart';
import 'package:prueba_jun/library.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MainProvider(mainRepository: MainRepositoryImpl()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, mainProvider, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Junior Demo',
          theme: mainProvider.isDarkTheme
              ? UIThemes.darkTheme()
              : UIThemes.lightTheme(),
          routerConfig: appRoute,
        );
      },
    );
  }
}
