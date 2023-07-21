import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/providers/providers.dart';

import 'package:news_app/style/style.dart';
import 'package:news_app/widgets/custom_icon_button.dart';
import 'news_list.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void _onItemTapped(WidgetRef ref, int? index) {
    if (index == null) return;
    ref.read(indexStateProvider.notifier).update((state) => index);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barIndex = ref.watch(indexStateProvider);
    final barIcons = ref.watch(iconProvider);
    return Scaffold(
      backgroundColor: Palette.white,
      body: Responsive(
        appBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Logo(fontSize: 36),
            barIndex == 0
                ? CustomIconButton(
                    icon: Icons.search_rounded,
                    onPressed: () {
                      showSearch(
                          context: context, delegate: NewsSearchDelegate());
                    },
                  )
                : CustomIconButton(
                    icon: Icons.clear,
                    onPressed: () {
                      ref.read(bookmarkProvider.notifier).clear();
                      showSnackBar('Removed all bookmarks');
                    },
                  ),
          ],
        ),
        body: IndexedStack(
          index: barIndex,
          children: const [
            NewsList(),
            BookmarkList(),
          ],
        ),
        sideOrBottom: kIsMobile
            ? BottomNavigationBar(
                currentIndex: barIndex,
                selectedItemColor: Palette.primary,
                unselectedItemColor: Palette.grey,
                backgroundColor: Palette.white,
                selectedLabelStyle: TextStyle(
                  color: Palette.primary,
                  fontSize: 12,
                ),
                unselectedLabelStyle: TextStyle(
                  color: Palette.grey,
                  fontSize: 12,
                ),
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                items: List.generate(
                  barIcons.length,
                  (index) => BottomNavigationBarItem(
                    icon: barIcons[index].icon,
                    activeIcon: barIcons[index].selectedIcon,
                    label: barIcons[index].label,
                    backgroundColor: Palette.white,
                  ),
                ),
                onTap: (index) {
                  _onItemTapped(ref, index);
                },
              )
            : Row(
                children: <Widget>[
                  NavigationRail(
                    selectedIndex: barIndex,
                    groupAlignment: -1.0,
                    onDestinationSelected: (index) {
                      _onItemTapped(ref, index);
                    },
                    labelType: NavigationRailLabelType.all,
                    selectedIconTheme: IconThemeData(color: Palette.primary),
                    leading: SizedBox(height: kIsMacOS ? 24.0 : 8.0),
                    destinations: List.generate(
                      barIcons.length,
                      (index) => NavigationRailDestination(
                        icon: barIcons[index].icon,
                        selectedIcon: barIcons[index].selectedIcon,
                        label: Text(barIcons[index].label),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    thickness: 1,
                    width: 1,
                    color: Palette.grey,
                  ),
                ],
              ),
      ),
    );
  }
}

class NewsSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [CustomIconButton(icon: Icons.clear, onPressed: () => query = '')];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return CustomIconButton(
      icon: Icons.arrow_back,
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchNewsList(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
