import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ya_finance_app/data/repositories_impl/bank_account_mock.dart';
import 'package:ya_finance_app/presentation/widgets/create_edit_transac/create_edit_provider.dart';

Future<Map<String, dynamic>> showAccountPicker(BuildContext context) async {
  String? _accName = null;
  int? _accId = null;
  final list_acc = await MockBankAccountRepository().getBankAccounts();
  // По условию у нас один счёт, поэтому просто беру первый элемент
  //Provider.of<CreateEditProvider>(context, listen: false).accIdCreate = list_acc[0].id;
  final dialog = await showModalBottomSheet<String?>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.18 * list_acc.length,
        decoration: BoxDecoration(
          color: Color(0xFFF7F2FA),
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
              child: ListView.builder(
                itemCount: list_acc.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF7F2FA),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 25,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () {
                      _accName = list_acc[index].name;
                      _accId = list_acc[index].id;
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Text(
                          '💰',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          list_acc[index].name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
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
                  _accName = null;
                  _accId = null;
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.cancel_outlined, color: Colors.white, size: 30),
                    SizedBox(width: 10),
                    Text(
                      'Отмена',
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
  return {
    'accName': _accName,
    'accId': _accId
  };
}
