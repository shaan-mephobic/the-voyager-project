import 'package:flutter/material.dart';
import 'package:the_voyager_project/routes/earthquake.dart';
import 'package:the_voyager_project/routes/mars.dart';
import 'package:the_voyager_project/routes/nasa_apod.dart';
import 'package:the_voyager_project/routes/news.dart';
import 'package:the_voyager_project/routes/weather.dart';
import 'package:the_voyager_project/widgets/custom_physics.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 5, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const CustomPhysics(),
      controller: _tabController,
      children: const [
        MarsPage(),
        MoonPage(),
        NewsScreen(),
        NasaApod(),
        QuakeScreen(),
      ],
    );
  }
}
