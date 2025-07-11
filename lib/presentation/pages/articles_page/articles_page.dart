import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_mock.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_repository_impl.dart';

import '../../../data/api/api_client.dart';
import 'bloc/ap_page_bloc.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  final _apPageBloc = ApPageBloc(CategoriesRepositoryImpl());
  final TextEditingController _controllerArticle = TextEditingController();

  @override
  void dispose() {
    _controllerArticle.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _apPageBloc.add(LoadStatesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color(0xFF2AE881),
        title: Text(
          'Мои статьи',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _apPageBloc.add(LoadStatesEvent(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<ApPageBloc, ApPageState>(
          bloc: _apPageBloc,
          builder: (context, state) {
            var list_categ;
            if (state is ApPageLoaded) {
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
                      horizontal: BorderSide(
                        color: Color(0xFFCAC4D0),
                        width: 1,
                      ),
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
                                _apPageBloc.add(LoadStatesEvent());
                              } else {
                                _apPageBloc.add(SearchStatesEvent(searchStr: _controllerArticle.text));
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 22,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      list_categ[index].emoji,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Container(width: 15),
                                    Text(
                                      list_categ[index].name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
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
      ),
    );
  }
}
