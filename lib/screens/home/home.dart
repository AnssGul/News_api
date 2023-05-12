import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../detail_news/detail_news.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiKey = '6c34f4dfd2bd41378d905181e83b74ed';
  List<dynamic> newsArticles = [];

  Future<void> fetchNewsArticles() async {
    final String url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));
    final responseBody = json.decode(response.body);
    setState(() {
      newsArticles = responseBody['articles'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchNewsArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Headlines'),
      ),
      body: newsArticles.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: newsArticles.length,
        itemBuilder: (context, index) {
          final article = newsArticles[index];
          return ListTile(
            title: Text(article['title']),
            subtitle: Text(
                'By ${article['author'] ?? 'Unknown'} - ${DateTime.parse(article['publishedAt']).toString()}'),
            leading: article['urlToImage'] != null
                ? Image.network(article['urlToImage'])
                : null,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(article: article),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
