class Book {
  String id;
  String title;
  String category;
  String authorId;

  Book({this.id, this.title ,this.category,this.authorId});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['_id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      authorId: json['authorId'] as String
    );
  }
}