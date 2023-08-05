import 'dart:convert';

import 'package:book_app/screens/b_description.dart';
import 'package:book_app/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class MenuPage extends StatefulWidget {
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<dynamic> books = [];
  String search_Book = "harrypotter";

  var DataTime;

  @override
  void initState() {
    super.initState();
    searchBook(search_Book);
  }

  Future<void> searchBook(String search_Book) async {
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

  // dynamic  getrandomItems(){
  //   if (books.isNotEmpty){
  //     final randomIndex= DataTime.microsecondsSinceEpoch % books.length;
  //   } else{
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    // final randomItem= getrandomItems();

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu, color: Colors.black),
        title: Text(
          "Bookipedia",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>BookScreen()));},
            child: Icon(Icons.search)),
            SizedBox(width:5,),
          Padding(
            padding: const EdgeInsets.only(right:10.0),
            child: CircleAvatar(
              child: Image.network(
                  "https://i.pinimg.com/564x/32/99/c2/3299c22d2e9148ef3a897cc98686edf6.jpg"),
            ),
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Container(
            height: mq.height,
            width: mq.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/favbg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    const Text(
                      "What are you",
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "reading",
                          style: TextStyle(color: Colors.black, fontSize: 25),
                        ),
                        Text(
                          " today ?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 280,
                      width: mq.width,
                      // decoration: BoxDecoration(color: Colors.amberAccent),

                      child: Expanded(
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisExtent: 280,
                          ),
                          itemCount: books.length,
                          
                          itemBuilder: (context, index) {
                            final book = books[index]['volumeInfo'];
                            return InkWell(
                              // onTap: (){Navigator.push()},
                              child: InkWell(
                                onTap:(){Navigator.push(context, MaterialPageRoute(builder: ((context) => descriptionPage(descri_data: book))));},
                                child: Container(
                                  margin: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.black,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        book['imageLinks'] != null &&
                                                book['imageLinks']
                                                        ['smallThumbnail'] !=
                                                    null
                                            ? book['imageLinks']['smallThumbnail']
                                            : 'http://books.google.com/books/content?id=GmTtDwAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Best of the day",
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                    SizedBox(height: 20),
                    Stack(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Container(
                          height:mq.height*.200,
                          width: mq.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 218, 230, 236)),
                        ),
                      ),
                      Positioned(
                          bottom:40,
                          right: 15,
                          child: Container(
                              height: mq.height * 0.190,
                              width: mq.width * .300,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: Image.network(
                                  "http://books.google.com/books/content?id=2grADAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
                                  fit: BoxFit.fill,
                                ),
                              ))),
                      Positioned(
                        top: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "A classic collection of 365 fairy tales about \n princesses and fairies, castles and knights,\n talking animals and mischievous elves",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black54)),
                              SizedBox(height: 15),
                              Text("365 Fairy Tales",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 15),
                              Text("Authors:Om Books Editorial Team",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 8),
                              Container(
                                height: 40,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white),
                                child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("⭐",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500)),
                                        Text("4.0",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    )),
                              ),
                              
                            ],
                          ),
                        ),
                      )
                    ]),

                    SizedBox(height: 5),
                      const Row(children: [
                        Text("Continue",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500)),
                        SizedBox(width: 2),
                        Text("Reading....",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ]),
                      SizedBox(height:10),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                            height: mq.height * 0.06,
                            width: mq.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color.fromARGB(255, 218, 230, 236)),
                                                  ),
                          ),
                       

                        Positioned(
                           bottom:40,
                          right:20,
                          child: Container(
                                height: mq.height * 0.06,
                                width: mq.width * .100,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  child: Image.network(
                                    "http://books.google.com/books/content?id=J8K_DAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
                                    fit: BoxFit.fill,
                                  ),
                                )),
                        ),

                         SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:80.0,vertical:20.0),
                            child: Text("365 Panchatantra Stories",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:80,vertical:40),
                            child: Text("Authors:Om Books Editorial Team",
                                style: TextStyle(
                                    fontSize:12,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500)),
                          )
                        
                      ]),
                  ])),
            ),
          ),
        ),
      ),
    );
  }
}

  

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart'as http;


// class MenuPage extends StatefulWidget {
  

//   @override
//   State<MenuPage> createState() => _MenuPageState();
// }

// class _MenuPageState extends State<MenuPage> {

//   List <dynamic> books=[];
//   TextEditingController search_ctrl= TextEditingController();
//   String search_book="";
  

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   searchbook(search_book);
//   // }
  

//   Future <void> searchbook(String search_book)async{
    

//     final response=await http.get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$search_book'));
//     if (response.statusCode == 200){
//       final data=json.decode(response.body);
//       setState(() {
//         books=data['items'];
//       });
//       print("I am working !:)");
//     }
//     else{
//       setState((){
//         books=[];
//       });
//       print("I don't have data! :(");
//     }
    
 
//   }


//   @override
//   Widget build(BuildContext context) {
//     var mq= MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         leading: Icon(Icons.menu,color: Colors.black,),
//         title: Text("Bookipedia",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//         actions: [CircleAvatar(child:Image.network("https://i.pinimg.com/564x/32/99/c2/3299c22d2e9148ef3a897cc98686edf6.jpg"))],
//         backgroundColor: Colors.white,
//       ),
//       body:

//           // bg container
//           Container(
//             height:double.infinity,
//             width: double.infinity,
//             decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/favbg.png"),fit: BoxFit.cover)),
          


//             child:Padding(
//             padding:const  EdgeInsets.all(10.0),
//             child:  Container(
//               child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("What are  you",style: TextStyle(color: Colors.black, fontSize: 25),),
              
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//               Text("reading",style: TextStyle(color: Colors.black, fontSize: 25),),
//                Text(" today ?",style: TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold),),
//             ],),
             
//             Expanded(
//               child: GridView.builder(
//                 physics: ScrollPhysics(),
//                 shrinkWrap: true,
                
//                 gridDelegate: 
//                 SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount:2,),
            
//                 itemCount: books.length,
//                 itemBuilder:(context, index){
//                 final book=books[index]['volumeInfo'];
//                 return

//                     Container(
//                       height:70,
//                       width:50,
//                       decoration: BoxDecoration(image:DecorationImage(image: NetworkImage(
//                              book['imageLinks']['smallThumbnail'],
//                           ), fit: BoxFit.fill)),
//                       child:Column(
//                         children: [
                          
                        
      
//                     Padding(
//                       padding: const EdgeInsets.only(top:40.0),
//                       child: Text(book['title'],style: TextStyle(color: Colors.white, fontSize:17),),
//                     ),

//                     Padding(
//                       padding: const EdgeInsets.only(top:40.0),child:Text(book['authors']!=null
//                               ? book['authors'][0]
//                               : 'Author not available',style: TextStyle(color: Colors.white, fontSize:17),),),
                  
//                   ],
//                       ),);
            
            
            
                
//                 }
//                 ),
//             )
        
//          ])
    

        

            





            
            
//         )
    



        




//             ))
//     );
    
    
//     }}
























































// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart'as http;


// class MenuPage extends StatefulWidget {
  

//   @override
//   State<MenuPage> createState() => _MenuPageState();
// }

// class _MenuPageState extends State<MenuPage> {

//   List <dynamic> books=[];
//   TextEditingController search_ctrl= TextEditingController();
//   String search_book="";
  

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   searchbook(search_book);
//   // }

//   Future <void> searchbook(String search_book)async{
    

//     final response=await http.get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$search_book'));
//     if (response.statusCode == 200){
//       final data=json.decode(response.body);
//       setState(() {
//         books=data['items'];
//       });
//       print("I am working !:)");
//     }
//     else{
//       setState(){
//         books=[];
//       }
//       print("I don't have data! :(");
//     }
    
 
//   }


//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
      
//       body:
        // Container(
        //   height:double.infinity,
        //       width:double.infinity,
        //       decoration: BoxDecoration(
        //         color: Color.fromARGB(255, 204, 249, 244),),
        //         // image: DecorationImage(image: AssetImage("images/bg3.png"),fit:BoxFit.fill)),
        //       child: Padding(
        //       padding: const EdgeInsets.all(12.0),
        //       child: Column(
                      
        //         children: [
        //           SizedBox(height: 16),
        //           Row(
        //             children: [
        //               Container(
        //                 height:40,
        //                 width: MediaQuery.of(context).size.width*0.670,
        //                 decoration: BoxDecoration(color: Colors.black12,borderRadius: BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5),)),
        //                 child:Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal:8.0),
        //                   child: TextField(
        //                     controller: search_ctrl,
        //                     onChanged: (value) {
        //                       search_book=value;

        //                     },
        //                     decoration:const  InputDecoration(
        //                       border: InputBorder.none,
        //                       hintText: "Search Books",
        //                       hintStyle: TextStyle(color: Color.fromARGB(255, 14, 14, 14)),
        //                       contentPadding: EdgeInsetsDirectional.only(top:5),
        //                       prefixIcon: Icon(Icons.search, color: Colors.black,)
                                              
        //                     ),
        //                   ),
        //                 )
        //               ),

        //               InkWell(
        //                 onTap:(){searchbook(search_book);},
        //                 child: Container(
        //                    height:40,
        //                   width: MediaQuery.of(context).size.width*0.150,
        //                   decoration: BoxDecoration(color: Color.fromARGB(227, 54, 155, 180),borderRadius: BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5),)),
        //                   child: Icon(Icons.search,color: Colors.black,),
                      
        //                 ),
        //               )
        //             ],
        //           ),
                  
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: books.length,
//                       itemBuilder: (context, index) {
//                         final book = books[index]["volumeInfo"];
//                         return ListTile(
//                           leading: Image.network(
//                             book['imageLinks'] != null && book['imageLinks']['smallThumbnail'] != null
//                             ? book['imageLinks']['smallThumbnail']
//                             : 'http://books.google.com/books/content?id=GmTtDwAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api',

//                           ),
//                           title: Text(book['title']),
//                           subtitle: Text(book['authors'] != null
//                               ? book['authors'][0]
//                               : 'Author not available'),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
        
//         )
// );}}

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;


// class BookScreen extends StatefulWidget {
//   @override
//   _BookScreenState createState() => _BookScreenState();
// }
// class _BookScreenState extends State<BookScreen> {
//   List<dynamic> books = [];
//   Future<void> fetchBooks() async {
//     // String text3 = "";
//     final response = await http.get(
//         Uri.parse('https://www.googleapis.com/books/v1/volumes?q=history'));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       setState(() {
//         books = data['items'];
//       });
//     } else {
//       setState(() {
//         books = [];
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Book API Demo'),
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: fetchBooks,
//             child: Text('Fetch Books'),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: books.length,
//               itemBuilder: (context, index) {
//                 final book = books[index]['volumeInfo'];
//                 return ListTile(
//                   leading: Image.network(
//                     book['imageLinks']['thumbnail'],
//                     width: 60,
//                     height: 80,
//                   ),
//                   title: Text(book['title']),
//                   subtitle: Text(book['authors'] != null
//                       ? book['authors'][0]
//                       : 'Author not available'),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }