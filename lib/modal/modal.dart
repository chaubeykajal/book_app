class Books{
  final String title;
  final String subtitle;
  final String authors;
  final String description;
  final String smallThumbnail;


  Books({required this.title,required this.subtitle,required this.description,required this.authors,required this.smallThumbnail});

  factory  Books.fromJson(Map<String, dynamic> json){
   return Books(
    title: json['volumeInfo']["title"]?? "", 
    subtitle: json['volumeInfo']["subtitle"]?? "", 
    description:json['volumeInfo']["description"]??"", 
    authors:json['volumeInfo']["authors"]??" ",
    smallThumbnail:json['volumeInfo']["imageLinks"]['smallThumnail']??"",);
  }
    
}

// class ImageLinks {
//   String thumbnail;

//   ImageLinks({this.thumbnail});

//   ImageLinks.fromJson(Map<String, dynamic> json) {
//     thumbnail = json['thumbnail'];
//   }
// }








