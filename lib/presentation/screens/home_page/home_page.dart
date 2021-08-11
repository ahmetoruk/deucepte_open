import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:deucepte_open/presentation/screens/home_page/dashboard_page/dashboard_page.dart';
import 'package:deucepte_open/presentation/screens/home_page/semester_list_page.dart';

class MainPage extends HookWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final page = useState<int>(0);

    changePage(int index) {
      page.value = index;
      pageController.jumpToPage(index);
    }

    return WillPopScope(
      onWillPop: () {
        if (page.value != 0) {
          changePage(0);
          return Future<bool>.value(false);
        } else {
          return Future<bool>.value(true);
        }
      },
      child: Scaffold(
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const <Widget>[
            DashboardPage(),
            SemesterListPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: changePage,
          type: BottomNavigationBarType.fixed,
          currentIndex: page.value,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Anasayfa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: 'Derslerim',
            ),
          ],
        ),
      ),
    );
  }
}
