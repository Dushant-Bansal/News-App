import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/services/api.dart';

import '../services/storage.dart';

final asyncNewsProvider =
    AsyncNotifierProvider<NewsNotifier, List<News>>(() => NewsNotifier());

class NewsNotifier extends AsyncNotifier<List<News>> {
  Api api = Api();

  Future<List<News>> fetchTopHeadlines() async {
    return await api.getTopHeadlines().onError(
      (error, stackTrace) {
        state = AsyncValue.error(error!, stackTrace);
        return [];
      },
    );
  }

  @override
  FutureOr<List<News>> build() {
    return fetchTopHeadlines();
  }

  void addBookmark(int index) {
    final news = state.asData?.value;
    if (news == null) return;
    news[index] = news[index].copyWith(isBookmarked: true);
    state = AsyncData(news);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    final data = await fetchTopHeadlines();
    state = AsyncData(data);
  }
}

final asyncSearchNewsProvider =
    AsyncNotifierProvider<SearchNewsNotifier, List<News>>(
        () => SearchNewsNotifier());

class SearchNewsNotifier extends AsyncNotifier<List<News>> {
  Api api = Api();

  @override
  FutureOr<List<News>> build() {
    return [];
  }

  void addBookmark(int index) {
    final news = state.asData?.value;
    if (news == null) return;
    news[index] = news[index].copyWith(isBookmarked: true);
    state = AsyncData(news);
  }

  Future<void> search(String query) async {
    state = const AsyncLoading();
    final data = await api.search(query).onError(
      (error, stackTrace) {
        state = AsyncValue.error(error!, stackTrace);
        return [];
      },
    );
    state = AsyncData(data);
  }
}

final bookmarkProvider =
    StateNotifierProvider<BookMarkProvider, List<News>>((ref) {
  return BookMarkProvider(hiveHandler);
});

class BookMarkProvider extends StateNotifier<List<News>> {
  BookMarkProvider(this.hiveHandler) : super([]) {
    Future.microtask(() => loadData());
  }

  final HiveHandler hiveHandler;

  void loadData() {
    int length = hiveHandler.getLength();
    state = List.generate(
        length, (index) => News.fromJson(hiveHandler.getBookmark(index + 1)));
  }

  void clear() {
    hiveHandler.clear();
    state = [];
  }

  void addBookmark(News news) {
    news = news.copyWith(isBookmarked: true);
    hiveHandler.addBookmark(news.toJson());
    state = [...state, news];
  }
}
