import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';

class DetailPage extends StatefulWidget {
  final dynamic article;

  const DetailPage({Key? key, required this.article}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final String apiKey = '6c34f4dfd2bd41378d905181e83b74ed';
  dynamic articleContent;

  Future<void> fetchArticleContent() async {
    final String url =
        'https://newsapi.org/v2/top-headlines/${widget.article['title']}?apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));
    final responseBody = json.decode(response.body);
    setState(() {
      articleContent = responseBody['content'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchArticleContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article['title']),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: articleContent == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.article['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'By ${widget.article['author'] ?? 'Unknown'} - ${DateTime.parse(widget.article['publishedAt']).toString()}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 16.0),
              Html(data: articleContent),
            ],
          ),
        ),
      ),
    );
  }
}
