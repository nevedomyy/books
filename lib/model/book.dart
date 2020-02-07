class Book{
  final String title;
  final String author;
  final String description;
  final double price;
  final String currencyCode;
  final String thumbnail;

  Book({
    this.title,
    this.author,
    this.description,
    this.price,
    this.currencyCode,
    this.thumbnail,
  });

  Book.fromJSON(Map<String, dynamic> json)
    : title = json['volumeInfo']['title'],
      author = json['volumeInfo']['authors'][0],
      description = json['volumeInfo']['description'],
      price = 199.99,
      currencyCode = 'юаней',
      thumbnail = json['volumeInfo']['imageLinks']['thumbnail'];
}