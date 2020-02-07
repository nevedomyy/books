import 'book.dart';

class ListUno{
  final int totalItems;
  final List<Book> list;
  final String error;
  final bool isLoading;

  ListUno({
    this.totalItems,
    this.list,
    this.error,
    this.isLoading
  });

  ListUno.fromJSON(Map<String, dynamic> json)
    : totalItems = json['totalItems'],
      list = (json['items'] as List).map((i) => Book.fromJSON(i)).toList(),
      error = null,
      isLoading = false;

  ListUno.withError(String error)
    : totalItems = 0,
      list = null,
      error = error,
      isLoading = false;

  ListUno.loading()
    : totalItems = 0,
      list = null,
      error = null,
      isLoading = true;

  ListUno.initial()
    : totalItems = 0,
      list = null,
      error = null,
      isLoading = false;
}