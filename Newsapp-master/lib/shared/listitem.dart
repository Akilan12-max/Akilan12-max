import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// class listItem{
//  String  imgUrl;
//  String newsTitle;
//  String author;
//  String date;
//
//  listItem(this.author,this.date,this.imgUrl,this.newsTitle);
//
//
// }

class ListOfNewsItems extends StatefulWidget {
  const ListOfNewsItems({super.key, required this.category});
  final String category;

  @override
  State<ListOfNewsItems> createState() => _ListOfNewsItemsState();
}

class _ListOfNewsItemsState extends State<ListOfNewsItems> {

 @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
     future: http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=in&category=${widget.category}&apiKey=5fd24bc328e640b196833aa0c8698e11')),
     builder:(Context, newsData) =>newsData.connectionState== ConnectionState.waiting
         ? Center(
      child: CircularProgressIndicator(),
     )
         : ListView.builder(
      itemCount: json.decode( newsData.data!.body)['articles'].length,
      itemBuilder: (context,index)=>Card(
          child : Padding(
           padding:const EdgeInsets.all(10.0),
           child: Column(
            children:< Widget>[
             Image.network(
              json.decode(newsData.data!.body)['articles'][index]
              ['urlToImage']??"https://www.thejungleadventure.com/assets/images/noimage/noimage.png",

             ),

             SizedBox(
              height: 15,
             ),
             Text(json.decode(newsData.data!.body)['articles'][index]['title'],
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),
             ),
            ],
           ),
          )
      ),
     ),
    );
  }
}



//Widget newsCardTile(BuildContext context) {

 //return Column(
  //children: [
   //Row(
    //children: <Widget>[
     //Padding(
      //padding: const EdgeInsets.only(
        //  left: 8, right: 8, top: 6, bottom: 6),
      //child: CachedNetworkImage(
       //width: 100,
       //imageUrl: 'https://media.istockphoto.com/id/1322277517/photo/wild-grass-in-the-mountains-at-sunset.jpg',
       //placeholder: (context, url) => Container(
        //width: 50,
        //child: const Center(
          //  child: CircularProgressIndicator()),
      // ),
       //errorWidget: (context, url, error) =>
       //const Icon(Icons.error),
      //),
     //),
     //Container(
     // width: 250,

      //color: Colors.amberAccent ,
      //padding: const EdgeInsets.only(
        //  left: 1, right: 2, top: 15, bottom: 4),
      //child: Column(
       //crossAxisAlignment: CrossAxisAlignment.start,
       //mainAxisSize: MainAxisSize.max,
       //children: <Widget>[
        //Text(
        // "eventsDetails.ename",
        // maxLines: 2,
         //style: const TextStyle(
          //fontSize: 18,
          //fontWeight: FontWeight.w700,
         //),
        //),
        //const SizedBox(
         //height: 8,
        //),

       //],
     // ),
     //)
    //],
  // )
  //],
 //);
//}