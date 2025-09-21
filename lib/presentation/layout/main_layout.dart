import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:harry_potter_adilet/gen/assets.gen.dart';
import '../pages/characters/characters_page.dart';
import '../pages/spells/spells_page.dart';
import '../pages/houses/houses_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: Colors.amber[100],
              selectedHoverColor: Colors.amber[200],
              selectedColor: Colors.amber[600],
              selectedTitleTextStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              unselectedTitleTextStyle: const TextStyle(
                color: Colors.amber,
                fontSize: 16,

              ),
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              backgroundColor: Colors.black,
            ),
            title: Center(
              child: Assets.images.harryPotterLogoBlack.image(height: 120),
            ),
            items: [
              SideMenuItem(
                title: 'Characters',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: Icon(Icons.people, color: Colors.amber[600]),
                tooltipContent: "View all Harry Potter characters",
              ),
              SideMenuItem(
                title: 'Spells',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: Icon(Icons.auto_fix_high, color: Colors.amber[600]),
                tooltipContent: "Explore magical spells",
              ),
              SideMenuItem(
                title: 'Houses',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: Icon(Icons.home, color: Colors.amber[600]),
                tooltipContent: "Discover Hogwarts houses",
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: const [
                CharactersPage(),
                SpellsPage(),
                HousesPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
