import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Shows.dart' hide Image;

class MainScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: TvShows(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class TvShows extends StatefulWidget{

  @override
  TvShowsState createState() {
    return new TvShowsState();
  }
}

class TvShowsState extends State<TvShows> {
  String url = "https://api.tvmaze.com/search/shows?q=pokemon";
  List<Shows> showList;
  @override
  void initState() {
    super.initState();
    getTvShows();
  }

  void getTvShows() async {
    var response = await http.get(url);
    List<dynamic> decode = jsonDecode(response.body);
    setState(() {
      showList = decode.map((s) => Shows.fromJson(s)).toList();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TV SHOWS"),
        backgroundColor: Colors.red,
      ),
      body: showList == null? Center(
        child: CircularProgressIndicator(),
      )
          :GridView.count(crossAxisCount: 2,
      childAspectRatio: 1.386,
      scrollDirection: Axis.horizontal,
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 15.0,
      padding: EdgeInsets.all(15.0),
      children: showList.map((s) => Container(
        child: Container(
            child: Container(

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                image: DecorationImage(image: NetworkImage(s.show.image.medium))
              ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Color(0x33000000),
                  ),
                  padding: EdgeInsets.all(15.0),
              child: Center(
                child: Text(s.show.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,),)
              )
    )
        ),
      )).toList(),)
    );
  }
}