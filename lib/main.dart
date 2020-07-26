import 'package:flutter/material.dart';
import 'widgets/Bookshelftable.dart';

void main() {
  runApp(
    BookShelfApp(),
  );
}

class BookShelfApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookList(),
    );
  }
}