import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ya_finance_app/presentation/pages/expenses_page.dart';
import 'package:ya_finance_app/presentation/pages/settings_page.dart';
import 'package:ya_finance_app/presentation/pages/articles_page/articles_page.dart';
import 'package:ya_finance_app/presentation/pages/bank_account_page/bank_account_page.dart';
import 'package:ya_finance_app/presentation/pages/income_page.dart';
import 'package:ya_finance_app/presentation/widgets/bank_account_edit/bank_account_edit.dart';
import 'package:ya_finance_app/presentation/widgets/transac_history/transac_history.dart';
import 'package:ya_finance_app/presentation/widgets/analysis/analysis.dart';

import '../../presentation/widgets/create_edit_transac/create_edit_provider.dart';
import '../../presentation/widgets/create_edit_transac/create_edit_transac.dart';
import '../../presentation/widgets/nav_bar/nav_bar.dart';

final router = GoRouter(
  initialLocation: '/home/expenses',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) {
        final hideTabBarRoutes = {'/home/bank_account/edit'};
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
                Provider.of<CreateEditProvider>(context, listen: false).setnewTransacId(isIncome: false);
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
                    GoRoute(
                      name: 'expenses_history_edit',
                      path: 'edit',
                      builder: (context, state) {
                        return TransactionsCreateEdit(isIncome: false, isCreate: false,);
                      },
                      routes: [],
                    ),
                  ],
                ),
                GoRoute(
                  name: 'expenses_create',
                  path: 'create',
                  builder: (context, state) {
                    return TransactionsCreateEdit(isIncome: false, isCreate: true,);
                  },
                  routes: [],
                ),
                GoRoute(
                  name: 'expenses_edit',
                  path: 'edit',
                  builder: (context, state) {
                    return TransactionsCreateEdit(isIncome: false, isCreate: false,);
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
              name: 'income',
              path: '/home/income',
              builder: (context, state) {
                Provider.of<CreateEditProvider>(context, listen: false).setnewTransacId(isIncome: true);
                return IncomePage(key: UniqueKey());
                },
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
                    GoRoute(
                      name: 'income_history_edit',
                      path: 'edit',
                      builder: (context, state) {
                        return TransactionsCreateEdit(isIncome: true, isCreate: false,);
                      },
                      routes: [],
                    ),
                  ],
                ),
                GoRoute(
                  name: 'income_create',
                  path: 'create',
                  builder: (context, state) {
                    return TransactionsCreateEdit(isIncome: true, isCreate: true,);
                  },
                  routes: [],
                ),
                GoRoute(
                  name: 'income_edit',
                  path: 'edit',
                  builder: (context, state) {
                    return TransactionsCreateEdit(isIncome: true, isCreate: false,);
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
