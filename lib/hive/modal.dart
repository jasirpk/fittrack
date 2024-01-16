import 'package:hive/hive.dart';
part 'items_modal.g.dart';

@HiveType(typeId: 0)
class ItemsModal extends HiveObject {
  @HiveField(0)
  String fitnessItemImage;
  @HiveField(1)
  String fitnessItemDemoImage;
  @HiveField(2)
  String itemName;
  @HiveField(3)
  String SelectedWorkoutLevel;
  @HiveField(4)
  String SelectedCategory;
  @HiveField(5)
  String SelctedWorkoutPlan;
  @HiveField(6)
  String Description;
  ItemsModal(
      {required this.fitnessItemImage,
      required this.fitnessItemDemoImage,
      required this.itemName,
      required this.SelectedWorkoutLevel,
      required this.SelectedCategory,
      required this.SelctedWorkoutPlan,
      required this.Description});
}
