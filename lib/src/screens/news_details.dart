import 'package:flutter/material.dart';
import '../Models/Item_Model.dart';
import '../blocs/comments_provider.dart';
import '../widgets/comments.dart';

class NewsDetails extends StatelessWidget {
  final itemId;
  NewsDetails(this.itemId);
  Widget build(context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: StreamBuilder(
        stream: bloc.itemComments,
        builder:
            (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
          if (!snapshot.hasData) return Text("Fetching Comments .. ");
          return FutureBuilder(
            future: snapshot.data[itemId],
            builder: (context, AsyncSnapshot<ItemModel> commentSnapshot) {
              if (commentSnapshot.hasData == false) return Text("Loading");
              return buildList(commentSnapshot.data, snapshot.data);
            },
          );
        },
      ),
    );
  }

  buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    children.add(buildTitle(item));
    final commentsList = item.kids.map(
      (kidId) {
        return Comment(kidId, itemMap, 1);
      },
    ).toList();
    children.addAll(commentsList);
    return ListView(
      children: children,
    );
  }

  buildTitle(ItemModel item) {
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
