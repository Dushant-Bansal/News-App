import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/style/palette.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    super.key,
    required this.news,
    this.onTap,
    this.onBookMarked,
  });

  final News news;
  final VoidCallback? onTap;
  final void Function(News news)? onBookMarked;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: news.urlToImage == null
            ? Container(color: Palette.grey, height: 60, width: 60)
            : Image.network(news.urlToImage!,
                height: 60, width: 60, fit: BoxFit.fill),
      ),
      title: Text(
        news.title,
        style: TextStyle(
          color: Palette.black,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text.rich(
        TextSpan(
          text: news.publishedAt.split('T').first,
          children: [
            WidgetSpan(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: CircleAvatar(radius: 4, backgroundColor: Palette.grey),
              ),
              alignment: PlaceholderAlignment.middle,
            ),
            TextSpan(text: news.author),
          ],
        ),
      ),
      trailing: IconButton(
        icon: news.isBookmarked
            ? Icon(Icons.bookmark_rounded, color: Palette.primary)
            : const Icon(Icons.bookmark_outline_rounded),
        onPressed: () => onBookMarked?.call(news),
      ),
      onTap: onTap,
    );
  }
}
