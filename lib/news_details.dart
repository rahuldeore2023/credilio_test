import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatefulWidget {
  final String title;
  final String url;
  final String date;
  final String description;
  final String imageUrl;

  const NewsDetails(
      {super.key,
      required this.title,
      required this.url,
      required this.date,
      required this.description,
      required this.imageUrl});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  launchURL(String _url) async {
    String url = _url;
    print("object ${url}");
    Uri Oneurl = Uri.parse(url);
    if (!await launchUrl(Oneurl)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              '${widget.imageUrl}',
              height: 200.0,
              width: 200.0,
            ),
            const SizedBox(height: 10,),
            Text(
              "Title : ${widget.title}",
              style: const TextStyle(fontSize: 14.0, color: Colors.black),
            ),
            const SizedBox(height: 10,),
            Text(
              "Published Date : ${widget.date}",
              style: const TextStyle(fontSize: 15.0, color: Colors.black),
            ),
            const SizedBox(height: 10,),
            Text(
              "Description : ${widget.description}",
              style: const TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: () {
                launchURL(widget.url);
              },
              child: Text(
                " Url : ${widget.url}",
                style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
