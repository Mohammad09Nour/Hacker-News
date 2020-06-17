import 'api_provider.dart';
import 'news_db_provider.dart';
import '../Models/Item_Model.dart';

class Repository {
  List<Source> source = [
    newsdbprovider,
    NewsApiProvider(),
  ];
  List<Caches> caches = [
    newsdbprovider,
  ];
  Future<List<int>> fetchTopIds() {
    return source[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    Source src;
    for (src in source) {
      item = await src.fetchItem(id);
      if (item != null) break;
    }

    for (var ch in caches) {
      ch.addItem(item);
    }

    return item;
  }

  clearCache() async {
    for (var cach in caches) {
      await cach.clear();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Caches {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}
