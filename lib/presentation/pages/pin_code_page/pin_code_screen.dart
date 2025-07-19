import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:ya_finance_app/presentation/pages/pin_code_page/pin_code_provider.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';

class PinCodeScreen extends StatefulWidget {
  final String type;
  const PinCodeScreen({required this.type, super.key});

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  final _pinController = TextEditingController();
  bool _isError = false;

  late final LocalAuthentication auth;
  bool _supportState = false;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then(
        (bool isSupported) => setState(() {
          _supportState = isSupported;
        }),
    );
  }

  void _validatePin(String pin) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final isValid = await authProvider.checkPin(pin);

    if (isValid) {
      context.go('/home/expenses');
    } else {
      setState(() => _isError = true);
      _pinController.clear();
    }
  }

  void _changePin(String pin) async {
    Provider.of<AuthProvider>(context, listen: false).changePin(pin);
    context.go('/home/settings');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isError ? AppLocalizations.of(context)!.wrongPin : ((widget.type == 'auth') ? AppLocalizations.of(context)!.typePass : AppLocalizations.of(context)!.typeNewPass),
              style: TextStyle(color: _isError ? Colors.red : (Theme.of(context).textTheme.titleMedium!.color)),
            ),
            const SizedBox(height: 20),
            (widget.type == 'auth') ? PinCodeTextField(
              textStyle: Theme.of(context).textTheme.titleMedium,
              length: 4,
              controller: _pinController,
              onCompleted: _validatePin,
              keyboardType: TextInputType.number, appContext: context,
            )
            : PinCodeTextField(
              textStyle: Theme.of(context).textTheme.titleMedium,
              length: 4,
              controller: _pinController,
              onCompleted: _changePin,
              keyboardType: TextInputType.number, appContext: context,
            ),
            SizedBox(height: 100,),
            if (widget.type == 'auth')
              ElevatedButton(
                  onPressed: _authenticate,
                  child: Text(AppLocalizations.of(context)!.biometry, style: Theme.of(context).textTheme.titleMedium,)
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Enter',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false
        )
      );
      Provider.of<AuthProvider>(context, listen: false).setIsAuthenticated(authenticated);
      context.go('/home/expenses');
    } on PlatformException catch (e) {
      print(e);
    }
  }

}