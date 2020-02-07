import 'package:books/model/auth.dart';
import 'package:books/model/book.dart';
import 'package:books/model/books_list_1.dart';
import 'package:books/model/books_list_2.dart';
import 'package:books/model/books_list_3.dart';
import 'package:books/model/books_list_4.dart';

class AuthLoading{
  AuthResp get authResp => AuthResp.loading();
}

class AuthSuccess{
  AuthResp get authResp => AuthResp.success();
}

class AuthFailed{
  AuthResp get authResp => AuthResp.failed();
}

class GetListUno{
  final ListUno _listUno;
  GetListUno(this._listUno);
  ListUno get listUno => _listUno;
}

class GetListUnoNext{
  final ListUno _listUno;
  GetListUnoNext(this._listUno);
  ListUno get listUno => _listUno;
}

class GetListUnoLoading{
  ListUno get listUno => ListUno.loading();
}

class GetListDois{
  final ListDois _listDois;
  GetListDois(this._listDois);
  ListDois get listDois => _listDois;
}

class GetListDoisNext{
  final ListDois _listDois;
  GetListDoisNext(this._listDois);
  ListDois get listDois => _listDois;
}

class GetListDoisLoading{
  ListDois get listDois => ListDois.loading();
}

class GetListTres{
  final ListTres _listTres;
  GetListTres(this._listTres);
  ListTres get listTres => _listTres;
}

class GetListTresNext{
  final ListTres _listTres;
  GetListTresNext(this._listTres);
  ListTres get listTres => _listTres;
}

class GetListTresLoading{
  ListTres get listTres => ListTres.loading();
}

class GetListQuatro{
  final ListQuatro _listQuatro;
  GetListQuatro(this._listQuatro);
  ListQuatro get listQuatro => _listQuatro;
}

class GetListQuatroNext{
  final ListQuatro _listQuatro;
  GetListQuatroNext(this._listQuatro);
  ListQuatro get listQuatro => _listQuatro;
}

class GetListQuatroLoading{
  ListQuatro get listQuatro => ListQuatro.loading();
}

class ToBuy{
  final Book _book;
  ToBuy(this._book);
  Book get book => _book;
}

class ToFav{
  final Book _book;
  ToFav(this._book);
  Book get book => _book;
}

class Search{
  final String _value;
  Search(this._value);
  String get value => _value;
}