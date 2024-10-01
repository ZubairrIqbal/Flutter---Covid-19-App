import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_restapis/Modals/post_model.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postList = [];
  Future<List<PostsModel>> getApi() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200){
      for(Map i in data){
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    }else{
      return postList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Api Course',style: TextStyle(
            color: Colors.white
          ),),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getApi(), 
                builder: (context,snapshot){
                  if(!snapshot.hasData){
                    return Text('Loading');
                  }else{
                    return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context,index){
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Text('Title\n'+postList[index].title.toString(),style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                             ),),
                              Text('Description\n'+postList[index].body.toString())
                            ],
                          ),
                        );
                    });
                  }
                }),
            )
          ],
        ),
      ),
    );
  }
}