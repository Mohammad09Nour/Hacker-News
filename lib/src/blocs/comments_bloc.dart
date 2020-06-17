import 'package:rxdart/rxdart.dart';
import '../Models/Item_Model.dart';
import '../resources/repository.dart';

class CommentsBloc {
  final _itemFetcher = PublishSubject<int>();
  final _itemOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _repository = Repository();

  Function(int) get fetchItemWithComments => _itemFetcher.sink.add;
  Stream<Map<int, Future<ItemModel>>> get itemComments => _itemOutput.stream;
  CommentsBloc() {
    _itemFetcher.stream.transform(_itemTransformer()).pipe(_itemOutput);
  }
  _itemTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<ItemModel>> cache, int id, _) {
      cache[id] = _repository.fetchItem(id);
      cache[id].then(
        (ItemModel item) {
          item.kids.forEach((kidId) => fetchItemWithComments(kidId));
        },
      );
      return cache;
    }, <int, Future<ItemModel>>{});
  }

  dispose() {
    _itemFetcher.close();
    _itemOutput.close();
  }
}
