import 'package:credilio_test/news_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  void initState() {
    // TODO: implement initState
    callAPI();
    super.initState();
  }

  var data;
  bool isLoading = true;

  void callAPI() async {
    Uri url = Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2024-10-09&sortBy=publishedAt&apiKey=30c232a14ab9419ea3a65b2c9354217a');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
        print(data);
        isLoading = false;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? CircularProgressIndicator() : Scaffold(
      body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            final data_list = data['articles'][index];
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    NewsDetails(title: '${data_list['title']}',
                        url: '${data_list['url']}',
                        date: '${data_list['publishedAt']}',
                        description: '${data_list['description']}',
                        imageUrl:'${data_list['urlToImage']}' )));
              },
              child: Card(
                elevation: 2.0,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                    '${data_list['urlToImage']}',
                    height: 200.0,
                    width: 200.0,
                  ),
                    Text(
                      "Title : ${data_list['title']}",
                      style: TextStyle(fontSize: 14.0),
                    ),


                    Text(
                      "Published Date : ${data_list['publishedAt']}",
                      style: TextStyle(fontSize: 12.0, color: Colors.black),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
