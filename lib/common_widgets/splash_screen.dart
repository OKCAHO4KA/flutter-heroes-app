import 'dart:async';
import 'package:prueba_jun/features/main/use_cases/main_repository_impl.dart';
import 'package:prueba_jun/library.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    loadMain();
    super.initState();
  }

  Future<void> loadMain() async {
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        context.pushReplacement("/main");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MainProvider(mainRepository: MainRepositoryImpl()),
        ),
      ],
      child: Scaffold(
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
