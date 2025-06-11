import 'package:flutter/material.dart';
import 'pages/settings_page.dart';
import 'pages/articles_page.dart';
import 'pages/bank_account_page.dart';
import 'pages/expenses_page.dart';
import 'pages/income_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _selectedPageIndex = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: PageView(
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _openPage,
        type: theme.bottomNavigationBarTheme.type,
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        selectedItemColor: theme.hintColor,
        showUnselectedLabels: theme.bottomNavigationBarTheme.showSelectedLabels,
        selectedLabelStyle: theme.bottomNavigationBarTheme.selectedLabelStyle,
        unselectedLabelStyle: theme.bottomNavigationBarTheme.selectedLabelStyle,
        items: [
          AppBarItem(
              label: 'Расходы',
              icon: 'lib/assets/icons/expenses.png',
              backColor: _selectedPageIndex == 0 ? Color(0xFFD4FAE6) : theme.bottomNavigationBarTheme.backgroundColor,
              iconColor: _selectedPageIndex == 0 ? theme.primaryColor : Color(0xFF49454F)
          ).toBottomNavigationBarItem(),
          AppBarItem(
              label: 'Доходы',
              icon: 'lib/assets/icons/income.png',
              backColor: _selectedPageIndex == 1 ? Color(0xFFD4FAE6) : theme.bottomNavigationBarTheme.backgroundColor,
              iconColor: _selectedPageIndex == 1 ? theme.primaryColor : Color(0xFF49454F)
          ).toBottomNavigationBarItem(),
          AppBarItem(
              label: 'Счёт',
              icon: 'lib/assets/icons/bank_account.png',
              backColor: _selectedPageIndex == 2 ? Color(0xFFD4FAE6) : theme.bottomNavigationBarTheme.backgroundColor,
              iconColor: _selectedPageIndex == 2 ? theme.primaryColor : Color(0xFF49454F)
          ).toBottomNavigationBarItem(),
          AppBarItem(
              label: 'Статьи',
              icon: 'lib/assets/icons/articles.png',
              backColor: _selectedPageIndex == 3 ? Color(0xFFD4FAE6) : theme.bottomNavigationBarTheme.backgroundColor,
              iconColor: _selectedPageIndex == 3 ? theme.primaryColor : Color(0xFF49454F)
          ).toBottomNavigationBarItem(),
          AppBarItem(
              label: 'Настройки',
              icon: 'lib/assets/icons/settings.png',
              backColor: _selectedPageIndex == 4 ? Color(0xFFD4FAE6) : theme.bottomNavigationBarTheme.backgroundColor,
              iconColor: _selectedPageIndex == 4 ? theme.primaryColor : Color(0xFF49454F)
          ).toBottomNavigationBarItem(),
        ]
      ),
    );
  }

  void _openPage(int index){
    setState(() => _selectedPageIndex = index);
    _pageController.jumpToPage(index);
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
        icon: Container(
          decoration: BoxDecoration(
            color: backColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
              child: Image.asset(
                icon,
                scale: 0.6,
                color: iconColor,
              )
          ),
        ),
        label: label
    );
  }
}