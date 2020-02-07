import 'book.dart';

class ListDois{
  final int totalItems;
  final List<Book> list;
  final String error;
  final bool isLoading;

  ListDois({
    this.totalItems,
    this.list,
    this.error,
    this.isLoading
  });

  ListDois.fromJSON(Map<String, dynamic> json)
    : totalItems = json['totalItems'],
      list = (json['items'] as List).map((i) => Book.fromJSON(i)).toList(),
      error = null,
      isLoading = false;

  ListDois.withError(String error)
    : totalItems = 0,
      list = null,
      error = error,
      isLoading = false;

  ListDois.loading()
    : totalItems = 0,
      list = null,
      error = null,
      isLoading = true;

  ListDois.initial()
    : totalItems = 0,
      list = null,
      error = null,
      isLoading = false;
}