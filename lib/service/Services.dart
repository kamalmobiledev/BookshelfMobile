import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/Books.dart';

class Services {
  static const ROOT = 'http://localhost:3004/bookshelf';
  static const String _GET_ACTION = 'GET_ALL';
  static const String _CREATE_TABLE = 'CREATE_TABLE';
  static const String _ADD_BOOK_ACTION = 'ADD_EMP';
  static const String _UPDATE_BOOK_ACTION = 'UPDATE_EMP';
  static const String _DELETE_BOOK_ACTION = 'DELETE_EMP';

  static Future<List<Book>> getBooks() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _GET_ACTION;
      final response = await http.get(ROOT);
      print("getEmployees >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Book> list = parsePhotos(response.body);
        return list;
      } else {
        throw List<Book>();
      }
    } catch (e) {
      return List<Book>();
    }
  }

  static List<Book> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Book>((json) => Book.fromJson(json)).toList();
  }

  static Future<String> createTable() async {
    try {
      var map = new Map<String, dynamic>();
      map["action"] = _CREATE_TABLE;
      final response = await http.post(ROOT, body: map);
      print("createTable >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> addBook(
      String title, String category, String authorId) async {
    try {
      var map = new Map<String, dynamic>();
      map["title"] = title;
      map["category"] = category;
      map["authorId"] = authorId;
      print(map);
      final response = await http.post(ROOT + '/book/add', body: map);
      print("addBook>> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> updateBook(
      String id, String title, String category, String authorId) async {
    try {
      var map = new Map<String, dynamic>();
      map["_id"] = id;
      map["title"] = title;
      map["category"] = category;
      map["authorId"] = authorId;
      final response = await http.put(ROOT + '/book/update', body: map);
      print(map);
      print("updateBook >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> deleteBook(String id) async {
    try {
      final response = await http.delete(ROOT + '/book/delete/' + id);
      print("deleteEmployee >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }
}
