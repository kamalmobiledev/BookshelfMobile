import 'package:candelabookshelf/widgets/ManageBook.dart';
import 'package:flutter/material.dart';
import '../model/Books.dart';
import '../service/Services.dart';

class BookList extends StatefulWidget {
  BookList() : super();

  final String title = "Candela Bookshelf";

  @override
  BookListState createState() => BookListState();
}

class BookListState extends State<BookList> {
  List<Book> _books;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _books = [];
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _getBooks();
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _addBook() {
    if (_firstNameController.text.trim().isEmpty ||
        _lastNameController.text.trim().isEmpty) {
      {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ManageCourse(new Book(), 'ADD'),
          ),
        ).then((value) => _getBooks());
      }
      _getBooks();
      return;
    }
    Services.addBook(_firstNameController.text, _lastNameController.text, '123')
        .then((result) {
      if ('success' == result) {
        _getBooks();
      }
      _clearValues();
    });
  }

  _getBooks() {
    Services.getBooks().then((books) {
      setState(() {
        _books = books;
      });
      _showProgress(widget.title);
      print("Length: ${books.length}");
    });
  }

  _deleteBook(Book book) {
    Services.deleteBook(book.id).then((result) {
      if ('Successfully deleted book' == result) {
        setState(() {
          _books.remove(book);
        });
        _getBooks();
      }
    });
  }

  _clearValues() {
    _firstNameController.text = '';
    _lastNameController.text = '';
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 15,
          columns: [
            DataColumn(
              label: Text(""),
              numeric: false,
            ),
            DataColumn(
              label: Text(
                "TITLE",
              ),
              numeric: false,
            ),
            DataColumn(
              label: Text("AUTHORID"),
              numeric: false,
            ),
            DataColumn(
              label: Text("CATEGORY"),
              numeric: false,
            ),
          ],
          rows: _books
              .map(
                (book) => DataRow(
                  cells: [
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline_rounded,
                            color: Colors.red),
                        onPressed: () {
                          _deleteBook(book);
                        },
                      ),
                      /*onTap: () {
                        print("Tapped " + book.title);
                      },*/
                    ),
                    DataCell(
                      Container(child: Text(book.title)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ManageCourse(book, 'UPDATE')),
                        ).then((value) => _getBooks());
                      },
                    ),
                    DataCell(
                      Container(
                        alignment: Alignment.center,
                        child: Text(book.authorId.toUpperCase()),
                      ),
                      /*onTap: () {
                        print("Tapped " + book.title);
                        _setValues(book);
                        _selectedEmployee = book;
                      },*/
                    ),
                    DataCell(
                      Container(
                          child: Text(
                        book.category.toUpperCase(),
                      )),
                      /*onTap: () {
                        print("Tapped " + book.title);
                        _setValues(book);
                        _selectedEmployee = book;
                      },*/
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Courses',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2.0),
              child: FlatButton(
                  child: Text(
                    'Add course',
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    _addBook();
                    //_getBooks();
                  }),
            ),
            Expanded(
              child: _dataBody(),
            )
          ],
        ),
      ),
    );
  }
}
