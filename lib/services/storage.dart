import 'package:hive_flutter/hive_flutter.dart';

const String kBookmarksBox = "bookmarks";

Future<void> openBoxes() async {
  await Hive.initFlutter();
  await Hive.openBox(kBookmarksBox);
}

final hiveHandler = HiveHandler();

class HiveHandler {
  late final Box dataBox;

  HiveHandler() {
    dataBox = Hive.box(kBookmarksBox);
  }

  int getLength() {
    int? length = dataBox.get('length');
    if (length == null) dataBox.put('length', 0);
    return length ?? 0;
  }

  dynamic getBookmark(int index) => dataBox.get(index);

  Future<void> addBookmark(Map<String, dynamic>? bookmarkJson) {
    dataBox.put('length', getLength() + 1);
    return dataBox.put(getLength(), bookmarkJson);
  }

  Future<int> clear() => dataBox.clear();
}
