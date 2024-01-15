class ItemListManager {
  static final ItemListManager _instance = ItemListManager._internal();

  factory ItemListManager() {
    return _instance;
  }

  ItemListManager._internal();

  List<Map<String, dynamic>> items = [];
}
