import 'package:flutter/material.dart';
import 'package:the_voyager_project/routes/earthquake.dart';
import 'package:the_voyager_project/routes/nasa_apod.dart';
import 'package:the_voyager_project/routes/news.dart';
import 'package:the_voyager_project/widgets/custom_physics.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  // late final AnimationController _controller;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3, initialIndex: 0);
    // ..addListener(() {
    //   if (_tabController.indexIsChanging) {
    //     setState(() => _controller.forward(from: 0.5));
    //   }
    // }
    // );

    // _controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 400),
    //   value: 1,
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return FadeTransition(
    //   opacity: _controller,
    //   child: const [
    //     NewsScreen(),
    //     QuakeScreen(),
    //     NasaApod(),
    //   ][_tabController.index],
    // );
    return TabBarView(
      physics: const CustomPhysics(),
      controller: _tabController,
      children: const [
        NewsScreen(),
        QuakeScreen(),
        NasaApod(),
      ],
    );
  }
}
