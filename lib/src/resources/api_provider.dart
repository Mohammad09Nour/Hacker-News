import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../Models/Item_Model.dart';
import 'repository.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();
  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_root/topstories.json');
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_root/item/$id.json');
    final fromJson = json.decode(response.body);
    ItemModel item = ItemModel.fromJson(fromJson);
    return item;
  }
}
