import 'package:flutter/material.dart';
import '../data/repositories_impl/categories_mock.dart';
import 'pages/settings_page.dart';
import 'pages/articles_page.dart';
import 'pages/bank_account_page.dart';
import 'pages/expenses_page.dart';
import 'pages/income_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _selectedPageIndex = 0;
  final _pageController = PageController();
  var oldIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (value) {
            setState(() => _selectedPageIndex = value);
          },
          children: [
            ExpensesPage(),
            IncomePage(),
            BankAccountPage(),
            ArticlesPage(),
            SettingsPage()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _openPage,
        type: theme.bottomNavigationBarTheme.type,
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        selectedItemColor: theme.hintColor,
        showUnselectedLabels: theme.bottomNavigationBarTheme.showUnselectedLabels,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        items: [
          AppBarItem(
              label: 'Расходы',
              icon: 'lib/assets/icons/expenses.svg',
              backColor: _selectedPageIndex == 0 ? Color(0xFFD4FAE6) : theme.bottomNavigationBarTheme.backgroundColor,
              iconColor: _selectedPageIndex == 0 ? theme.primaryColor : Color(0xFF49454F)
          ).toBottomNavigationBarItem(),
          AppBarItem(
              label: 'Доходы',
              icon: 'lib/assets/icons/income.svg',
              backColor: _selectedPageIndex == 1 ? Color(0xFFD4FAE6) : theme.bottomNavigationBarTheme.backgroundColor,
              iconColor: _selectedPageIndex == 1 ? theme.primaryColor : Color(0xFF49454F)
          ).toBottomNavigationBarItem(),
          AppBarItem(
              label: 'Счёт',
              icon: 'lib/assets/icons/bank_account.svg',
              backColor: _selectedPageIndex == 2 ? Color(0xFFD4FAE6) : theme.bottomNavigationBarTheme.backgroundColor,
              iconColor: _selectedPageIndex == 2 ? theme.primaryColor : Color(0xFF49454F)
          ).toBottomNavigationBarItem(),
          AppBarItem(
              label: 'Статьи',
              icon: 'lib/assets/icons/articles.svg',
              backColor: _selectedPageIndex == 3 ? Color(0xFFD4FAE6) : theme.bottomNavigationBarTheme.backgroundColor,
              iconColor: _selectedPageIndex == 3 ? theme.primaryColor : Color(0xFF49454F)
          ).toBottomNavigationBarItem(),
          AppBarItem(
              label: 'Настройки',
              icon: 'lib/assets/icons/settings.svg',
              backColor: _selectedPageIndex == 4 ? Color(0xFFD4FAE6) : theme.bottomNavigationBarTheme.backgroundColor,
              iconColor: _selectedPageIndex == 4 ? theme.primaryColor : Color(0xFF49454F)
          ).toBottomNavigationBarItem(),
        ]
      ),
    );
  }

  void _openPage(int index){
    if ((oldIndex - index).abs() != 1) {
      _pageController.jumpToPage(index);
    }
    else {
      _pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.ease);
    }
    setState(() => _selectedPageIndex = index);
    oldIndex = index;
  }
}


class AppBarItem {
  final String label;
  final String icon;
  final Color? backColor;
  final Color? iconColor;

  const AppBarItem({
    required this.label,
    required this.icon,
    required this.backColor,
    required this.iconColor
  });

  BottomNavigationBarItem toBottomNavigationBarItem() {
    return BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(top: 12, bottom: 4, left: 4.4, right: 4.4),
          child: Container(
            decoration: BoxDecoration(
              color: backColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
                padding: EdgeInsets.only(top: 8.57, bottom: 8.57, left: 23.14, right: 23.14),
                child: SvgPicture.asset(
                  icon,
                  height: 25,
                  color: iconColor,
                )
            ),
          ),
        ),
        label: label,
    );
  }
}