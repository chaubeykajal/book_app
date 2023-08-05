import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'b_description.dart';
// void main() {
//   runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Book API Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BookScreen(),
//     );
//   }
// }
class BookScreen extends StatefulWidget {
  @override
  _BookScreenState createState() => _BookScreenState();
}
class _BookScreenState extends State<BookScreen> {
  List<dynamic> books = [];
  String search_Book = "english";
  
  Future<void> searchBook(String search_Book) async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$search_Book'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        books = data['items']!= null ? data['items'] : [];

      });
      print("I am working! :)");
    } else {
      setState(() {
        books = [];
      });
      print("I don't have data! :(");
    }
  }
  @override
  Widget build(BuildContext context) {
    var mq= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Books',style: TextStyle(fontWeight:FontWeight.w400),),
      ),
      body: SingleChildScrollView(
        child: Container(
              height:mq.height,
                  width:mq.width,
                  decoration: BoxDecoration(
                    // color: Color.fromARGB(255, 204, 249, 244),),
                   image: DecorationImage(image: AssetImage("images/favbg.png"),fit:BoxFit.fill)),
                  child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                          
                    children: [
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            height:40,
                            width: MediaQuery.of(context).size.width*0.670,
                            decoration: BoxDecoration(color: Colors.black12,borderRadius: BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5),)),
                            child:Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0),
                              child: TextField(
                                
                                onChanged: (value) {
                                  search_Book=value;
            
                                },
                                decoration:const  InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search Books",
                                  hintStyle: TextStyle(color: Color.fromARGB(255, 14, 14, 14)),
                                  contentPadding: EdgeInsetsDirectional.only(top:5),
                                  // prefixIcon: Icon(Icons.search, color: Colors.black,)
                                                  
                                ),
                              ),
                            )
                          ),
            
                          InkWell(
                            onTap:(){searchBook(search_Book);},
                            child: Container(
                               height:40,
                              width: MediaQuery.of(context).size.width*0.150,
                              decoration: BoxDecoration(color: Color.fromARGB(227, 54, 155, 180),borderRadius: BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5),)),
                              child: Icon(Icons.search,color: Colors.black,),
                          
                            ),
                          )
                        ],
                      ),

                                        Expanded(
                      child:GridView.builder(
                        gridDelegate: const 
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 250,),
                          itemCount: books.length,
                          itemBuilder: (context,index){
                            final mybook=books[index]['volumeInfo'];
                            return InkWell(
                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: ((context) => descriptionPage(descri_data: mybook))));},
                              child: Container(
                                 margin: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.black,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        mybook['imageLinks'] != null &&
                                                mybook['imageLinks']
                                                        ['smallThumbnail'] !=null
                                            ? mybook['imageLinks']['smallThumbnail']
                                            : 'http://books.google.com/books/content?id=GmTtDwAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                      
                              ),
                            );
      
            
              
   } ))],
        ))),
      ),
    );
  }
}

