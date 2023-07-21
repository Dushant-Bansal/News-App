import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/providers.dart';
import 'package:news_app/screens/news_page.dart';
import 'package:news_app/style/loader.dart';
import 'package:news_app/style/snackbar.dart';
import 'package:news_app/widgets/news_widget.dart';

class NewsList extends ConsumerWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsProvider = ref.watch(asyncNewsProvider);
    return newsProvider.when(
      data: (news) => RefreshIndicator(
        onRefresh: () async => ref.read(asyncNewsProvider.notifier).refresh(),
        child: ListView.separated(
          itemCount: news.length,
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, int index) {
            return NewsWidget(
              news: news[index],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NewsPage(news: news[index])),
              ),
              onBookMarked: (news) {
                ref.read(bookmarkProvider.notifier).addBookmark(news);
                ref.read(asyncNewsProvider.notifier).addBookmark(index);
                showSnackBar('Added to Bookmarks');
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
      loading: () => const Loader(),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}

class SearchNewsList extends ConsumerStatefulWidget {
  const SearchNewsList({super.key, required this.query});

  final String query;

  @override
  ConsumerState<SearchNewsList> createState() => _SearchNewsListState();
}

class _SearchNewsListState extends ConsumerState<SearchNewsList> {
  @override
  void initState() {
    Future.microtask(
        () => ref.watch(asyncSearchNewsProvider.notifier).search(widget.query));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = ref.watch(asyncSearchNewsProvider);
    return newsProvider.when(
      data: (news) => ListView.separated(
        itemCount: news.length,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return NewsWidget(
            news: news[index],
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => NewsPage(news: news[index])),
            ),
            onBookMarked: (news) {
              ref.read(bookmarkProvider.notifier).addBookmark(news);
              ref.read(asyncSearchNewsProvider.notifier).addBookmark(index);
              showSnackBar('Added to Bookmarks');
            },
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
      loading: () => const Loader(),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}

class BookmarkList extends ConsumerWidget {
  const BookmarkList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final news = ref.watch(bookmarkProvider);
    if (news.isEmpty) return const Center(child: Text('No Bookmarks Yet!'));
    return ListView.separated(
      itemCount: news.length,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return NewsWidget(
          news: news[index],
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NewsPage(news: news[index])),
          ),
          onBookMarked: (news) =>
              ref.read(bookmarkProvider.notifier).addBookmark(news),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
