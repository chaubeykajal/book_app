
import 'package:flutter/material.dart';

class descriptionPage extends StatelessWidget{
  final descri_data;

   descriptionPage({required this.descri_data});


  @override
  Widget build(BuildContext context){

    var mq=MediaQuery.of(context).size;

  
  return Scaffold(
    

      body: SingleChildScrollView(
        child: Column(
      
              children: [
                
                Container(
                  height: MediaQuery.of(context).size.height*0.50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(),
                  child:ClipRRect(borderRadius:BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight:Radius.circular(20),),

                     child: Image.network(descri_data['imageLinks'] != null &&
                          descri_data['imageLinks']['smallThumbnail'] != null
                      ? descri_data['imageLinks']['smallThumbnail']
                      : 'http://books.google.com/books/content?id=GmTtDwAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api',fit:BoxFit.fill),
                  ),
      
                ),
                SizedBox(height: 20,),
                Container(
                height:mq.height,
                width:mq.width,
                decoration:BoxDecoration(borderRadius:BorderRadius.only(topLeft:Radius.circular(10),topRight:Radius.circular(10)),
                image: DecorationImage(image: AssetImage("images/favbg.png"),fit:BoxFit.fill)),
                child:Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children:[
                  Text(descri_data['title']!=null? descri_data['title'] : '',style: TextStyle(fontSize:30, fontWeight: FontWeight.bold,color:Colors.black),),

                  // Padding(
                  //   padding: const EdgeInsets.only(left:20.0),
                  //   child: Text(descri_data['authors']!=null? descri_data['authors'] : '',style: TextStyle(fontSize:20, fontWeight: FontWeight.bold,color:Colors.black),),
                  // ),
                  SizedBox(height: 15,),   

                  Text(descri_data['description'],style: TextStyle(fontSize:15, fontWeight: FontWeight.w500,color:Colors.black),)
                              ],
                            ),
                ),
        ),
        
           ] ),
      )
  );


}
}