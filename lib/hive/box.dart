import 'package:fittrack/hive/modal.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  static Box<ItemsModal> getData() => Hive.box<ItemsModal>('items');
}
