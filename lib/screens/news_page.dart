import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/style/palette.dart';
import 'package:news_app/widgets/custom_icon_button.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        title: const Text(
          'Happy Reading',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: -1,
          ),
        ),
        centerTitle: true,
        leading: CustomIconButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          children: [
            news.urlToImage == null
                ? Container(color: Palette.grey, height: 250)
                : Image.network(news.urlToImage!, fit: BoxFit.fill),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: -1.5,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: news.author,
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: CircleAvatar(
                                radius: 4, backgroundColor: Palette.grey),
                          ),
                          alignment: PlaceholderAlignment.middle,
                        ),
                        TextSpan(text: news.publishedAt.split('T').first),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  const Text('Description',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4.0),
                  Text(news.description ?? ''),
                  const SizedBox(height: 12.0),
                  const Text('Content',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4.0),
                  Text(news.content ?? ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
