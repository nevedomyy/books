import 'package:books/model/auth.dart';
import 'package:books/model/book.dart';
import 'package:books/model/books_list_1.dart';
import 'package:books/model/books_list_2.dart';
import 'package:books/model/books_list_3.dart';
import 'package:books/model/books_list_4.dart';
import 'package:flutter/material.dart';

@immutable
class AppState{
  final AuthResp authResp;
  final ListUno listUno;
  final ListDois listDois;
  final ListTres listTres;
  final ListQuatro listQuatro;
  final List<Book> favList;
  final List<Book> toBuyList;
  final List<Book> searchList;

  const AppState({
    this.authResp,
    this.listUno,
    this.listDois,
    this.listTres,
    this.listQuatro,
    this.favList,
    this.toBuyList,
    this.searchList
  });

  AppState copyWith({
    AuthResp authResp,
    ListUno listUno,
    ListDois listDois,
    ListTres listTres,
    ListQuatro listQuatro,
    List<Book> favList,
    List<Book> toBuyList,
    List<Book> searchList,
  }) {
    return AppState(
      authResp: authResp ?? this.authResp,
      listUno: listUno ?? this.listUno,
      listDois: listDois ?? this.listDois,
      listTres: listTres ?? this.listTres,
      listQuatro: listQuatro ?? this.listQuatro,
      favList: favList ?? this.favList,
      toBuyList: toBuyList ?? this.toBuyList,
      searchList: searchList ?? this.searchList
    );
  }

  AppState.initial()
    : authResp = AuthResp.initial(),
      listUno = ListUno.initial(),
      listDois = ListDois.initial(),
      listTres = ListTres.initial(),
      listQuatro = ListQuatro.initial(),
      favList = List(),
      toBuyList = List(),
      searchList = List();
}