import 'package:flutter/material.dart';
import '../Models/Item_Model.dart';
import 'dart:async';
import 'loading_box.dart';

class Comment extends StatelessWidget {
  final int commentId;
  final Map<int, Future<ItemModel>> commentMap;
  final int depth;
  Comment(this.commentId, this.commentMap, this.depth);

  Widget build(context) {
    return FutureBuilder(
      future: commentMap[commentId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (snapshot.hasData == false) return LoadingBox();
        final item = snapshot.data;
        final children = <Widget>[
          ListTile(
            title: buildText(item, depth),
            subtitle: item.by == ""
                ? Text("This comment has been deleted ")
                : Text(item.by),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: depth * 16.0,
            ),
          ),
          Divider(
            height: 10.0,
            thickness: 3.0,
          ),
        ];
        snapshot.data.kids.forEach(
          (kidId) {
            children.add(Comment(kidId, commentMap, depth + 1));
          },
        );
        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(ItemModel item, int depth) {
    String text = item.text
        .replaceAll('&#x27', "'")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '');
    if (depth != 1) text = ">  " + text;
    return Text(text);
  }
}
