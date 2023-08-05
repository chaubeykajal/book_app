import 'dart:convert';
import 'package:http/http.dart'as http;

  var books=[];

  String search_Book="";
  
  Future<void> searchBook(String search_Book, books) async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$search_Book'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        books = data['items'];
      });
      print("I am working! :)");
    } else {
      setState(() {
        books = [];
      });
      print("I don't have data! :(");
    }
  }
  
  void setState(Null Function() param0) {
  }