import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery/modules/home_page/widgets/bottom_nav_bar.dart';
import 'package:grocery/providers/home_provider.dart';

import '../cart/cart_screen.dart';
import '../favorites/favorites_screen.dart';
import '../grocery/grocery_screen.dart';
import '../news/news_screen.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(homeProvider);
    return Scaffold(
      body: IndexedStack(
        index: home.currentIndex,
        children: [
          GroceryScreen(),
          NewsScreen(),
          FavoritesScreen(),
          CartScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: home.currentIndex,
        onPress: (int value) => setState(
          () {
            home.currentIndex = value;
          },
        ),
      ),
    );
  }
}
