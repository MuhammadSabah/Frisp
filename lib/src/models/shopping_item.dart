import 'package:food_recipe_final/src/models/enums/importance_enum.dart';
import 'package:hive/hive.dart';

part 'shopping_item.g.dart';

@HiveType(typeId: 0)
class ShoppingItem extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String importance;

  @HiveField(3)
  final int color;

  @HiveField(4)
  final String quantity;

  @HiveField(5)
  final DateTime date;

  @HiveField(6)
  final bool isComplete;

  ShoppingItem({
    required this.id,
    required this.name,
    required this.importance,
    required this.color,
    required this.quantity,
    required this.date,
    this.isComplete = false,
  });

  ShoppingItem copyWith({
    String? id,
    String? name,
    ImportanceEnum? importance,
    int? color,
    String? quantity,
    DateTime? date,
    bool? isComplete,
  }) {
    return ShoppingItem(
      id: id ?? this.id,
      name: name ?? this.name,
      importance: importance?.type ?? this.importance.toString(),
      color: color ?? this.color,
      quantity: quantity ?? this.quantity,
      date: date ?? this.date,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
