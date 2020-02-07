import 'book.dart';

class ListTres{
  final int totalItems;
  final List<Book> list;
  final String error;
  final bool isLoading;

  ListTres({
    this.totalItems,
    this.list,
    this.error,
    this.isLoading
  });

  ListTres.fromJSON(Map<String, dynamic> json)
    : totalItems = json['totalItems'],
      list = (json['items'] as List).map((i) => Book.fromJSON(i)).toList(),
      error = null,
      isLoading = false;

  ListTres.withError(String error)
    : totalItems = 0,
      list = null,
      error = error,
      isLoading = false;

  ListTres.loading()
    : totalItems = 0,
      list = null,
      error = null,
      isLoading = true;

  ListTres.initial()
    : totalItems = 0,
      list = null,
      error = null,
      isLoading = false;
}