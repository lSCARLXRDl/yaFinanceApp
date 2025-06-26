import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ya_finance_app/presentation/pages/expenses_page.dart';
import 'package:ya_finance_app/presentation/pages/settings_page.dart';
import 'package:ya_finance_app/presentation/pages/articles_page.dart';
import 'package:ya_finance_app/presentation/pages/bank_account_page/bank_account_page.dart';
import 'package:ya_finance_app/presentation/pages/income_page.dart';
import 'package:ya_finance_app/presentation/widgets/bank_account_edit/bank_account_edit.dart';
import 'package:ya_finance_app/presentation/widgets/transac_history/transac_history.dart';
import 'package:ya_finance_app/presentation/widgets/analysis/analysis.dart';

import '../../presentation/widgets/nav_bar/nav_bar.dart';

final router = GoRouter(
  initialLocation: '/home/expenses',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) {
        final hideTabBarRoutes = {
          '/home/bank_account/edit'
        };
        final shouldHideTabBar = hideTabBarRoutes.any(
          (route) => state.uri.toString().startsWith(route),
        );
        return HomeTabsPage(
          tab: shouldHideTabBar ? null : HomeTab.byIndex(shell.currentIndex),
          child: shell,
          onTap: (value) => shell.goBranch(value.index),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'expenses',
              path: '/home/expenses',
              builder: (context, state) {
                return ExpensesPage(key: UniqueKey());
              },
              routes: [
                GoRoute(
                  name: 'expenses_history',
                  path: 'history',
                  builder: (context, state) {
                    return TransactionsHistory(isIncome: false);
                  },
                  routes: [
                    GoRoute(
                      name: 'expenses_analysis',
                      path: 'analysis',
                      builder: (context, state) {
                        return TransactionsAnalysis(isIncome: false);
                      },
                      routes: [],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'income',
              path: '/home/income',
              builder: (context, state) => IncomePage(key: UniqueKey()),
              routes: [
                GoRoute(
                  name: 'income_history',
                  path: 'history',
                  builder: (context, state) {
                    return TransactionsHistory(isIncome: true);
                  },
                  routes: [
                    GoRoute(
                      name: 'income_analysis',
                      path: 'analysis',
                      builder: (context, state) {
                        return TransactionsAnalysis(isIncome: true);
                      },
                      routes: [],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'bank_account',
              path: '/home/bank_account',
              builder: (context, state) => BankAccountPage(key: UniqueKey()),
              routes: [
                GoRoute(
                  name: 'bank_account_edit',
                  path: 'edit',
                  builder: (context, state) {
                    return BankAccountEdit(key: UniqueKey());
                  },
                  routes: [],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'articles',
              path: '/home/articles',
              builder: (context, state) => ArticlesPage(key: UniqueKey()),
              routes: [],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'settings',
              path: '/home/settings',
              builder: (context, state) => SettingsPage(key: UniqueKey()),
              routes: [],
            ),
          ],
        ),
      ],
    ),
  ],
);
