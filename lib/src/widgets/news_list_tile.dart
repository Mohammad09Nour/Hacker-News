import 'package:flutter/material.dart';
import '../Models/Item_Model.dart';
import '../blocs/stories_provider.dart';
import 'dart:async';
import '../widgets/loading_box.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;
  NewsListTile({this.itemId});
  Widget build(context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) return LoadingBox();
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) return LoadingBox();

            return buildTile(itemSnapshot.data, context);
          },
        );
      },
    );
  }

  Widget buildTile(ItemModel item, BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, "/${item.id}");
          },
          title: Text("${item.title}"),
          subtitle: Text("${item.score} points"),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text("${item.descendants}"),
            ],
          ),
        ),
        Divider(
          height: 8.0,
          thickness: 2.0,
        ),
      ],
    );
  }
}
