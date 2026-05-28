import 'package:flutter/material.dart';

import '../../gallery/pages/gallery_page.dart';
import '../../history/pages/history_page.dart';
import '../../home/pages/home_page.dart';
import '../../spaces/pages/spaces_page.dart';

import '../widgets/custom_bottom_nav.dart';

class NavigationPage
    extends StatefulWidget {

  const NavigationPage({
    super.key,
  });

  @override
  State<NavigationPage>
      createState() =>
          _NavigationPageState();
}

class _NavigationPageState
    extends State<NavigationPage> {

  int currentIndex = 0;

  final pages = const [

    HomePage(),

    SpacesPage(),

    HistoryPage(),

    GalleryPage(),
  ];

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      extendBody: true,

      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      bottomNavigationBar:
          CustomBottomNav(

        currentIndex:
            currentIndex,

        onTap: (index) {

          setState(() {

            currentIndex =
                index;
          });
        },
      ),
    );
  }
}