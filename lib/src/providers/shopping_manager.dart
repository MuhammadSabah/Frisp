import 'package:flutter/cupertino.dart';
import 'package:food_recipe_final/src/models/shopping_item.dart';

class ShoppingManager extends ChangeNotifier {
  // Fields:
  final _shoppingItems = <ShoppingItem>[];
  int _selectedIndex = -1;
  bool _createNewItem = false;

  // Getters:
  List<ShoppingItem> get shoppingItems => List.unmodifiable(_shoppingItems);

  int get selectedIndex => _selectedIndex;

  ShoppingItem? get selectedShoppingItem =>
      selectedIndex != -1 ? shoppingItems[selectedIndex] : null;

  bool get isCreatingNewItem => _createNewItem;

  // Methods:
  void createNewItem() {
    _createNewItem = true;
    notifyListeners();
  }

  void addItem(ShoppingItem item) {
    _shoppingItems.add(item);
    _createNewItem = false;
    notifyListeners();
  }

  void deleteItem(int index) {
    _shoppingItems.removeAt(index);
    notifyListeners();
  }

  void updateItem(ShoppingItem item, int index) {
    _shoppingItems[index] = item;
    _selectedIndex = -1;
    _createNewItem = false;
    notifyListeners();
  }

  void completeItem(int index, bool change) {
    final item = _shoppingItems[index];
    _shoppingItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }

  void shoppingItemTapped(int index) {
    _selectedIndex = index;
    _createNewItem = false;
    notifyListeners();
  }

  void setSelectedShoppingItem(String id) {
    final index = _shoppingItems.indexWhere((element) => element.id == id);
    _selectedIndex = index;
    _createNewItem = false;
    notifyListeners();
  }
}
