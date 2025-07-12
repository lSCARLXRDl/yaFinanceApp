import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_mock.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_repository_impl.dart';
import '../create_edit_transac/create_edit_provider.dart';
import 'bloc/sp_bloc.dart';

Future<Map<String, dynamic>> showStatePicker(BuildContext context, {required bool isIncome}) async {
  String? _categName = null;
  int? _categId = null;
  final _spPageBloc = SpPageBloc(CategoriesRepositoryImpl());
  final TextEditingController _controllerArticle = TextEditingController();
  _spPageBloc.add(LoadStatesEvent(isIncome: isIncome));

  final dialog = await showModalBottomSheet<String?>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.45,
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
              child: BlocBuilder<SpPageBloc, SpPageState>(
                bloc: _spPageBloc,
                builder: (context, state) {
                  var list_categ;
                  if (state is SpPageLoaded) {
                    list_categ = state.categList;
                  } else if (state is SearchLoaded) {
                    list_categ = state.categList;
                  }
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFECE6F0),
                          border: Border.symmetric(
                            horizontal: BorderSide(color: Color(0xFFCAC4D0), width: 1),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 9,
                                child: TextField(
                                  onChanged: (_) {
                                    if (_controllerArticle.text == '') {
                                      _spPageBloc.add(LoadStatesEvent(isIncome: isIncome));
                                    } else {
                                      _spPageBloc.add(
                                        SearchStatesEvent(
                                          isIncome: isIncome,
                                          searchStr: _controllerArticle.text,
                                        ),
                                      );
                                    }
                                  },
                                  controller: _controllerArticle,
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    hintText: 'Найти статью',
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    color: Color(0xFF49454F),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.search,
                                  size: 30,
                                  color: Color(0xFF49454F),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (list_categ != null)
                        Expanded(
                          child: ListView.builder(
                            itemCount: list_categ.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.symmetric(
                                    horizontal: BorderSide(
                                      color: Color(0xFFCAC4D0),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 22,
                                    ),
                                    elevation: 0,
                                    backgroundColor: Colors.white
                                  ),
                                  onPressed: () {
                                    _categName = list_categ[index].name;
                                    _categId = list_categ[index].id;
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        list_categ[index].emoji,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Container(width: 15),
                                      Text(
                                        list_categ[index].name,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      );
    },
  );
  return {
    'categName': _categName,
    'categId': _categId
  };
}