// Feedback side...
class ItemModal {
  final int? itemId;
  final String? itemImage;
  final String? itemDemo;
  final String itemName;
  final String workoutLevel;
  final String category;
  final String workoutPlan;
  final String description;
  ItemModal(
      {this.itemId,
      required this.itemImage,
      required this.itemDemo,
      required this.itemName,
      required this.workoutLevel,
      required this.category,
      required this.workoutPlan,
      required this.description});

  factory ItemModal.fromMap(Map<String, dynamic> json) => ItemModal(
        itemId: json["itemId"],
        itemImage: json["itemImage"],
        itemDemo: json["itemDemo"],
        itemName: json["itemName"],
        workoutLevel: json["workoutLevel"],
        category: json['category'],
        workoutPlan: json['workoutPlan'],
        description: json['description'],
      );

  Map<String, dynamic> toMap() => {
        "itemId": itemId,
        "itemImage": itemImage,
        "itemDemo": itemDemo,
        "itemName": itemName,
        "workoutLevel": workoutLevel,
        "category": category,
        "workoutPlan": workoutPlan,
        "description": description,
      };
}
