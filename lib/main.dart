import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ya_finance_app/presentation/pages/bank_account_page/account_provider.dart';
import 'package:ya_finance_app/presentation/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:ya_finance_app/presentation/widgets/create_edit_transac/create_edit_provider.dart';
import 'package:ya_finance_app/router/home_router/home_router.dart';
import 'package:get_it/get_it.dart';
import 'package:ya_finance_app/service_locator.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;

  if (kIsWeb) {
    usePathUrlStrategy();
  }
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: Color(0xFF2AE881),
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  await dotenv.load();

  await setupDependencies();

  runApp(const FinanceApp());
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AccountProvider(),
      child: ChangeNotifierProvider(
        create: (_) => CreateEditProvider(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Finance App',
          theme: lightTheme,
          darkTheme: darkTheme,
          routerConfig: router,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ru', 'RU'), Locale('en', 'US')],
        ),
      ),
    );
  }
}
