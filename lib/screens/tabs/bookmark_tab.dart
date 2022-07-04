import 'package:flutter/material.dart';
import 'package:food_recipe_final/components/bookmark_card.dart';

class BookmarkTab extends StatefulWidget {
  const BookmarkTab({Key? key}) : super(key: key);

  @override
  State<BookmarkTab> createState() => _BookmarkTabState();
}

class _BookmarkTabState extends State<BookmarkTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return BookmarkCard();
  }

  @override
  bool get wantKeepAlive => true;
}
