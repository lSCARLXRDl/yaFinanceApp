import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../pages/bank_account_page/account_provider.dart';

class BankAccountEdit extends StatefulWidget {
  const BankAccountEdit({super.key});

  @override
  State<BankAccountEdit> createState() => _BankAccountEditState();
}

class _BankAccountEditState extends State<BankAccountEdit> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerBalance = TextEditingController();

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerBalance.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color(0xFF2AE881),
        title: Text(
          'Мой счет',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.check, size: 30),
              onPressed: () {
                print(_controllerName.text);
                Provider.of<AccountProvider>(context, listen: false).changeAccountName(_controllerName.text);
                Provider.of<AccountProvider>(context, listen: false).changeBalance(_controllerBalance.text);
                context.pop();
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 9,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFCAC4D0), width: 1),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("💰", style: TextStyle(fontSize: 20)),
                        SizedBox(width: 5,),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 12,
                                child: TextField(
                                  controller: _controllerName,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    hintText: Provider.of<AccountProvider>(context, listen: false).account_name,
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Expanded(flex: 1, child: Container()),
                              Expanded(
                                flex: 8,
                                child: TextField(
                                  controller: _controllerBalance,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    hintText: Provider.of<AccountProvider>(context, listen: false).balance,
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          ' ${Provider.of<AccountProvider>(context).currency}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
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
                    color: Color(0xFFE46962),
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFCAC4D0), width: 1),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 19),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFE46962),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 120,
              ),
              child: Text(
                'Удалить счет',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
