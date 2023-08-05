// ignore: file_names
import 'package:flutter/material.dart';

import 'package:book_app/screens/Menu.dart';


class MyHomePage extends StatefulWidget {
  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image:DecorationImage(image: AssetImage("images/bg6.png",),fit:BoxFit.fill )
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Text(
              "E",style: TextStyle(fontSize:30, color: Colors.black87,fontWeight:FontWeight.bold)),
               SizedBox(width:2,),
              Text('-Pustak',style: TextStyle(fontSize: 30, color: Colors.black,fontWeight:FontWeight.bold))
              ]),
            InkWell(
              onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context){return MenuPage();}));},
              child: Text("Start Reading",style: TextStyle(fontSize:18,color: Colors.black),))
          
          
          ],
            
 

        )

          )
      


      
   );
  }
}