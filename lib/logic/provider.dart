import 'package:books/model/books_list_1.dart';
import 'package:books/model/books_list_2.dart';
import 'package:books/model/books_list_3.dart';
import 'package:books/model/books_list_4.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListUnoProvider {
  Future<ListUno> getList(int startIndex) async{
    try {
      final response = await http.get('https://www.googleapis.com/books/v1/volumes?q=inauthor:акунин&startIndex=$startIndex');
      final responseBody = json.decode(response.body);
      return ListUno.fromJSON(responseBody);
    } catch (e){
      return ListUno.withError(e.toString());
    }
  }
}

class ListDoisProvider {
  Future<ListDois> getList(int startIndex) async{
    try {
      final response = await http.get('https://www.googleapis.com/books/v1/volumes?q=inauthor:азимов&startIndex=$startIndex');
      final responseBody = json.decode(response.body);
      return ListDois.fromJSON(responseBody);
    } catch (e){
      return ListDois.withError(e.toString());
    }
  }
}

class ListTresProvider {
  Future<ListTres> getList(int startIndex) async{
    try {
      final response = await http.get('https://www.googleapis.com/books/v1/volumes?q=inauthor:коллинз&startIndex=$startIndex');
      final responseBody = json.decode(response.body);
      return ListTres.fromJSON(responseBody);
    } catch (e){
      return ListTres.withError(e.toString());
    }
  }
}

class ListQuatroProvider {
  Future<ListQuatro> getList(int startIndex) async{
    try {
      final response = await http.get('https://www.googleapis.com/books/v1/volumes?q=inauthor:дюма&startIndex=$startIndex');
      final responseBody = json.decode(response.body);
      return ListQuatro.fromJSON(responseBody);
    } catch (e){
      return ListQuatro.withError(e.toString());
    }
  }
}