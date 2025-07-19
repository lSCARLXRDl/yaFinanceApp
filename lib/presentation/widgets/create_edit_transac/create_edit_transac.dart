import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ya_finance_app/presentation/widgets/create_edit_transac/create_edit_provider.dart';
import 'package:ya_finance_app/presentation/widgets/state_picker/state_picker.dart';

import '../../../l10n/app_localizations.dart';
import '../account_picker/account_picker.dart';
import '../date_picker/date_picker.dart';
import '../time_picker/time_picker.dart';


class TransactionsCreateEdit extends StatelessWidget {
  final bool isIncome;
  final bool isCreate;

  const TransactionsCreateEdit({
    super.key,
    required this.isIncome,
    required this.isCreate,
  });

  @override
  Widget build(BuildContext context) {
    return  _TransactionsCreateEditState(
        isIncome: isIncome,
        isCreate: isCreate,
    );
  }
}

class _TransactionsCreateEditState extends StatelessWidget {
  _TransactionsCreateEditState({
    required this.isIncome,
    required this.isCreate,
  });

  final bool isIncome;
  final bool isCreate;

  final TextEditingController _controllerSum = TextEditingController();
  final TextEditingController _controllerComment = TextEditingController();

  void dispose() {
    _controllerSum.dispose();
    _controllerComment.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isCreate) {
      _controllerSum.text = Provider.of<CreateEditProvider>(context).sum;
      _controllerComment.text = Provider.of<CreateEditProvider>(context).comment;
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          (isIncome) ? AppLocalizations.of(context)!.expenses : AppLocalizations.of(context)!.income,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.check, color: Colors.black, size: 30),
              onPressed: () {
                if (isCreate) {
                  Provider.of<CreateEditProvider>(context, listen: false).sumCreate = _controllerSum.text;
                  Provider.of<CreateEditProvider>(context, listen: false).commentCreate = _controllerComment.text;
                  Provider.of<CreateEditProvider>(context, listen: false).createTransac(context, isIncome: isIncome);
                }
                else {
                  Provider.of<CreateEditProvider>(context, listen: false).sum = _controllerSum.text;
                  Provider.of<CreateEditProvider>(context, listen: false).comment = _controllerComment.text;
                  Provider.of<CreateEditProvider>(context, listen: false).editTransac(context);
                }
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(
                bottom: BorderSide(color: Color(0xFFCAC4D0), width: 1),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.bankAcc,
                    style: Theme.of(context).textTheme.titleSmall
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).cardColor,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        elevation: 0
                    ),
                    child: Row(
                      children: [
                        Text(
                          (isCreate)
                            ? Provider.of<CreateEditProvider>(context).accountCreate
                            : Provider.of<CreateEditProvider>(context).account,
                          style: Theme.of(context).textTheme.titleSmall
                        ),
                        SizedBox(width: 10,),
                        Icon(
                          Icons.navigate_next,
                          color: Color(0xFFCAC4D0),
                          size: 30,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      final accInfo = await showAccountPicker(context);
                      if (accInfo['accId'] != null) {
                        (isCreate)
                            ? Provider.of<CreateEditProvider>(context, listen: false).changeAccountInfo(accInfo, isCreate: true)
                            : Provider.of<CreateEditProvider>(context, listen: false).changeAccountInfo(accInfo, isCreate: false);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(
                bottom: BorderSide(color: Color(0xFFCAC4D0), width: 1),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      AppLocalizations.of(context)!.article,
                    style: Theme.of(context).textTheme.titleSmall
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).cardColor,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      elevation: 0
                    ),
                    child: Row(
                      children: [
                        Text(
                          (isCreate)
                              ? Provider.of<CreateEditProvider>(context).stateCreate
                              : Provider.of<CreateEditProvider>(context).state,
                          style: Theme.of(context).textTheme.titleSmall
                        ),
                        SizedBox(width: 10,),
                        Icon(
                          Icons.navigate_next,
                          color: Color(0xFFCAC4D0),
                          size: 30,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      final categInfo = await showStatePicker(context, isIncome: isIncome);
                      if (categInfo['categId'] != null) {
                        (isCreate)
                            ? Provider.of<CreateEditProvider>(context, listen: false).changeCategInfo(categInfo, isCreate: true)
                            : Provider.of<CreateEditProvider>(context, listen: false).changeCategInfo(categInfo, isCreate: false);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(
                bottom: BorderSide(color: Color(0xFFCAC4D0), width: 1),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      AppLocalizations.of(context)!.amount,
                    style: Theme.of(context).textTheme.titleSmall
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controllerSum,
                            textAlign: TextAlign.right,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9.,-]')),
                              _DecimalTextInputFormatter(),
                            ],
                            decoration: InputDecoration(
                              hintText: Provider.of<CreateEditProvider>(context).sumCreate,
                              border: InputBorder.none,
                            ),
                            style: Theme.of(context).textTheme.titleSmall
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '₽',
                    style: Theme.of(context).textTheme.titleSmall
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(
                bottom: BorderSide(color: Color(0xFFCAC4D0), width: 1),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      AppLocalizations.of(context)!.date,
                    style: Theme.of(context).textTheme.titleSmall
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final date = await showYaDatePicker(context: context);
                      if (date != null)
                        (isCreate)
                            ? Provider.of<CreateEditProvider>(context, listen: false).changeDate(date, isCreate: true)
                            : Provider.of<CreateEditProvider>(context, listen: false).changeDate(date, isCreate: false);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Theme.of(context).cardColor,
                      elevation: 0,
                    ),
                    child: Text(
                      (isCreate)
                          ? Provider.of<CreateEditProvider>(context).nowDateCreate
                          : Provider.of<CreateEditProvider>(context).nDate,
                      style: Theme.of(context).textTheme.titleSmall
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(
                bottom: BorderSide(color: Color(0xFFCAC4D0), width: 1),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      AppLocalizations.of(context)!.time,
                    style: Theme.of(context).textTheme.titleSmall
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final time = await showYaTimePicker(context);
                      if (time != null) {
                        (isCreate)
                            ? Provider.of<CreateEditProvider>(context, listen: false).changeTime(time, isCreate: true)
                            : Provider.of<CreateEditProvider>(context, listen: false).changeTime(time, isCreate: false);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Theme.of(context).cardColor,
                      elevation: 0,
                    ),
                    child: Text(
                      (isCreate)
                          ? Provider.of<CreateEditProvider>(context).nowTimeCreate
                          : Provider.of<CreateEditProvider>(context).nTime,
                      style: Theme.of(context).textTheme.titleSmall
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(
                bottom: BorderSide(color: Color(0xFFCAC4D0), width: 1),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controllerComment,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.comment,
                        border: InputBorder.none,
                      ),
                      style: Theme.of(context).textTheme.titleSmall
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 32),
          if (!isCreate)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFE46962),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Provider.of<CreateEditProvider>(context, listen: false).deleteTransac(context, isIncome: isIncome);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 110,
              ),
              child: Text(
                (isIncome) ?
                'Удалить доход' : 'Удалить расход',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final locale = WidgetsBinding.instance.window.locale;
    final decimalSeparator = locale.countryCode == 'RU' ? ',' : '.';
    final newText = newValue.text.replaceAll('.', decimalSeparator).replaceAll(',', decimalSeparator);
    if (decimalSeparator.allMatches(newText).length <= 1) {
      return TextEditingValue(
        text: newText,
        selection: newValue.selection,
      );
    }
    else {
      return TextEditingValue(
        text: oldValue.text,
        selection: oldValue.selection,
      );
    }
  }
}