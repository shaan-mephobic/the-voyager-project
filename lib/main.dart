import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_voyager_project/logic/hive_db.dart';
import 'package:the_voyager_project/routes/earthquake.dart';
import 'package:the_voyager_project/routes/home.dart';
import 'package:the_voyager_project/routes/news.dart';
// import 'package:the_voyager_project/routes/iss_tracker.dart';
import 'package:the_voyager_project/routes/nasa_apod.dart';

void main() async {
  Paint.enableDithering = true;
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
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
      },
      theme: ThemeData(
        fontFamily: "Futura",
        primarySwatch: Colors.red,
        splashColor: Colors.white,
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
    );
  }
}
