import 'package:flutter/material.dart';
import 'Books.dart';
import 'Services.dart';
import 'dart:math';

class ManageCourse extends StatefulWidget {
  ManageCourse(this.book, this.type) : super();

  final Book book;
  final String type;

  @override
  _ManageCourse createState() => _ManageCourse();
}

class _ManageCourse extends State<ManageCourse> {
  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  _updateBook() {
    //_showProgress('Updating Employee...');
    Services.updateBook(widget.book.id, _firstNameController.text,
            _lastNameController.text, widget.book.authorId)
        .then((result) {
      goBack(context);
    });
  }

  _addBook() {
    var random = new Random();
    Services.addBook(_firstNameController.text, _lastNameController.text,
            (random.nextInt(4) + 1).toString())
        .then((result) {
      goBack(context);
    });
  }

  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _firstNameController.text = widget.book.title;
    _lastNameController.text = widget.book.category;
  }

  DropdownButton drpBtn() {
    String dropdownValue = 'Author A';
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_circle_down_sharp),
      iconSize: 16,
      elevation: 16,
      underline: Container(
        height: 2,
        width: 300,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Author A', 'Author B', 'Author C', 'Author D']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Course'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(2.0),
                child:
                    Align(alignment: Alignment.topLeft, child: Text('Title'))),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _firstNameController,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(2.0),
                child:
                    Align(alignment: Alignment.topLeft, child: Text('Author'))),
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Align(alignment: Alignment.topLeft, child: drpBtn())),
            Padding(
                padding: EdgeInsets.all(2.0),
                child: Align(
                    alignment: Alignment.topLeft, child: Text('Category'))),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _lastNameController,
              ),
            ),
            RaisedButton(
              child: Text("Save"),
              onPressed: () {
                //goBack(context);
                if (widget.type == 'ADD') {
                  _addBook();
                  print("ADDDDDDDDDDD");
                } else {
                  _updateBook();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

// Functions
