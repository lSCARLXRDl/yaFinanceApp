import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:worker_manager/worker_manager.dart';
import 'package:ya_finance_app/presentation/pages/bank_account_page/account_provider.dart';
import 'package:ya_finance_app/presentation/pages/pin_code_page/pin_code_provider.dart';
import 'package:ya_finance_app/presentation/widgets/haptick/haptick_provider.dart';
import 'package:ya_finance_app/presentation/widgets/local_picker/local_provider.dart';
import 'package:ya_finance_app/utils/blur.dart';
import 'package:ya_finance_app/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:ya_finance_app/presentation/widgets/create_edit_transac/create_edit_provider.dart';
import 'package:ya_finance_app/router/home_router/home_router.dart';
import 'package:get_it/get_it.dart';
import 'package:ya_finance_app/service_locator.dart';
import 'package:ya_finance_app/utils/theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ya_finance_app/l10n/app_localizations.dart';

import 'load_categories.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;

  if (kIsWeb) {
    usePathUrlStrategy();
  }
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  await dotenv.load();

  await setupDependencies();

  await loadCategories();

  await workerManager.dispose();
  await workerManager.init();

  runApp(
    ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: ChangeNotifierProvider(
            create: (_) => LocaleProvider(),
            child: FinanceApp()
        )
    ),
  );
}

class FinanceApp extends StatefulWidget {
  const FinanceApp({super.key});

  @override
  State<FinanceApp> createState() => _FinanceAppState();
}

class _FinanceAppState extends State<FinanceApp> {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      BlurHandler.enableBlur();
    } else if (state == AppLifecycleState.resumed) {
      BlurHandler.disableBlur();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ChangeNotifierProvider(
        create: (_) => AuthProvider(),
        child: ChangeNotifierProvider(
          create: (_) => AccountProvider(),
          child: ChangeNotifierProvider(
            create: (_) => CreateEditProvider(),
            child: ChangeNotifierProvider(
              create: (_) => HaptickProvider(),
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Finance App',
                theme: themeProvider.getTheme(context),
                routerConfig: router,
                localizationsDelegates: [
                  GlobalWidgetsLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  AppLocalizations.delegate,
                ],
                locale: Provider.of<LocaleProvider>(context).locale,
                supportedLocales: [Locale('en'), Locale('ru')],
              ),
            ),
          ),
      ),
    );
  }
}
