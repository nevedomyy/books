import 'book.dart';

class ListQuatro{
  final int totalItems;
  final List<Book> list;
  final String error;
  final bool isLoading;

  ListQuatro({
    this.totalItems,
    this.list,
    this.error,
    this.isLoading
  });

  ListQuatro.fromJSON(Map<String, dynamic> json)
    : totalItems = json['totalItems'],
      list = (json['items'] as List).map((i) => Book.fromJSON(i)).toList(),
      error = null,
      isLoading = false;

  ListQuatro.withError(String error)
    : totalItems = 0,
      list = null,
      error = error,
      isLoading = false;

  ListQuatro.loading()
    : totalItems = 0,
      list = null,
      error = null,
      isLoading = true;

  ListQuatro.initial()
    : totalItems = 0,
      list = null,
      error = null,
      isLoading = false;
}