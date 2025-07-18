import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum HomeTab {
  expenses,
  income,
  bank_account,
  articles,
  settings;

  factory HomeTab.byIndex(int index) => values[index];
}

class HomeTabsPage extends StatelessWidget {
  final HomeTab? tab;
  final Widget child;
  final ValueChanged<HomeTab> onTap;

  const HomeTabsPage({
    super.key,
    required this.tab,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (tab != null) {
      return Scaffold(
        body: child,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: tab!.index,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          selectedItemColor: Theme.of(context).hintColor,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          onTap: (index) => onTap(HomeTab.byIndex(index)),
          items: [
            AppBarItem(
              label: 'Расходы',
              icon: 'lib/assets/icons/expenses.svg',
              backColor:
                  tab!.index == 0
                      ? Theme.of(context).secondaryHeaderColor
                      : Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              iconColor:
                  tab!.index == 0 ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            ).toBottomNavigationBarItem(),
            AppBarItem(
              label: 'Доходы',
              icon: 'lib/assets/icons/income.svg',
              backColor:
                  tab!.index == 1
                      ? Theme.of(context).secondaryHeaderColor
                      : Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              iconColor:
                  tab!.index == 1 ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            ).toBottomNavigationBarItem(),
            AppBarItem(
              label: 'Счёт',
              icon: 'lib/assets/icons/bank_account.svg',
              backColor:
                  tab!.index == 2
                      ? Theme.of(context).secondaryHeaderColor
                      : Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              iconColor:
                  tab!.index == 2 ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            ).toBottomNavigationBarItem(),
            AppBarItem(
              label: 'Статьи',
              icon: 'lib/assets/icons/articles.svg',
              backColor:
                  tab!.index == 3
                      ? Theme.of(context).secondaryHeaderColor
                      : Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              iconColor:
                  tab!.index == 3 ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            ).toBottomNavigationBarItem(),
            AppBarItem(
              label: 'Настройки',
              icon: 'lib/assets/icons/settings.svg',
              backColor:
                  tab!.index == 4
                      ? Theme.of(context).secondaryHeaderColor
                      : Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              iconColor:
                  tab!.index == 4 ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            ).toBottomNavigationBarItem(),
          ],
        ),
      );
    }
    return child;
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
    required this.iconColor,
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
            padding: EdgeInsets.only(
              top: 8.57,
              bottom: 8.57,
              left: 23.14,
              right: 23.14,
            ),
            child: SvgPicture.asset(icon, height: 25, color: iconColor),
          ),
        ),
      ),
      label: label,
    );
  }
}
