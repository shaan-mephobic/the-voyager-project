import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_voyager_project/logic/hive_db.dart';
import 'package:the_voyager_project/logic/init.dart';
import 'package:the_voyager_project/routes/earthquake.dart';
import 'package:the_voyager_project/routes/home.dart';
import 'package:the_voyager_project/routes/mars.dart';
import 'package:the_voyager_project/routes/news.dart';
import 'package:the_voyager_project/routes/nasa_apod.dart';
import 'package:the_voyager_project/routes/moon.dart';

void main() async {
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  await Init().cacheImages();
  await HiveDB().hiveInit();
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voyager',
      initialRoute: '/home',
      routes: {
        '/apod': (context) => const NasaApod(),
        '/earthquake': (context) => const QuakeScreen(),
        '/news': (context) => const NewsScreen(),
        '/home': (context) => const Home(),
        '/moon': (context) => const MoonPage(),
        '/mars': (context) => const MarsPage(),
      },
      /* light theme settings */
      theme: ThemeData(
        fontFamily: "Futura",
        primaryColor: Colors.white,
        primaryColorBrightness: Brightness.light,
        brightness: Brightness.light,
        dividerColor: Colors.white54,
        scaffoldBackgroundColor: Colors.white,
        scrollbarTheme: ScrollbarThemeData(
          interactive: true,
          isAlwaysShown: false,
          radius: const Radius.circular(50),
          thickness: MaterialStateProperty.all(4),
          crossAxisMargin: 2,
          thumbColor: MaterialStateProperty.all(Colors.white30),
        ),
      ),

      /* Dark theme settings */
      darkTheme: ThemeData(
        fontFamily: "Futura",
        primaryColor: Colors.black,
        brightness: Brightness.dark,
        dividerColor: Colors.black12,
        primaryColorBrightness: Brightness.dark,
        primaryColorLight: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        scrollbarTheme: ScrollbarThemeData(
          interactive: true,
          isAlwaysShown: false,
          radius: const Radius.circular(50),
          thickness: MaterialStateProperty.all(4),
          crossAxisMargin: 2,
          thumbColor: MaterialStateProperty.all(Colors.white30),
        ),
      ),
      themeMode: ThemeMode.system,
    );
  }
}
