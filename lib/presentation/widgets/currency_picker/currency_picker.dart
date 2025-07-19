import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

Future<String?> showCurrencyPicker(BuildContext context) async {
  String? cur = null;
  final dialog = await showModalBottomSheet<String?>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.40,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Color(0xFF79747E),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFCAC4D0), width: 1),
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).cardColor,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  onPressed: () {
                    cur = '₽';
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        '₽',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.titleMedium!.color,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        '${AppLocalizations.of(context)!.rub} ₽',
                        style: Theme.of(context).textTheme.titleMedium
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFCAC4D0), width: 1),
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).cardColor,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  onPressed: () {
                    cur = '\$';
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        '\$',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.titleMedium!.color,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        '${AppLocalizations.of(context)!.dol} \$',
                        style: Theme.of(context).textTheme.titleMedium
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).cardColor,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {
                  cur = '€';
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Text(
                      '€',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).textTheme.titleMedium!.color
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      AppLocalizations.of(context)!.euro,
                      style: Theme.of(context).textTheme.titleMedium
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE46962),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {
                  cur = null;
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.cancel_outlined, color: Colors.white, size: 30),
                    SizedBox(width: 10),
                    Text(
                      AppLocalizations.of(context)!.cancel,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
  return cur;
}