import 'package:flutter/cupertino.dart';
import 'package:food_recipe_final/src/models/shopping_item.dart';

class ShoppingProvider extends ChangeNotifier {
  // Fields:
  final _shoppingItems = <ShoppingItem>[];
  int _selectedIndex = -1;
  bool _createNewItem = false;
  String _sortValue = '';
  String get getSortValue => _sortValue;
  void setSortValue(String newVal) {
    _sortValue = newVal;
    notifyListeners();
  }

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

  // Sorting methods:
  // 1)
  void sortByQuantityAscending() {
    _shoppingItems.sort((a, b) {
      return int.parse(a.quantity).compareTo(int.parse(b.quantity));
    });
    notifyListeners();
  }

  void sortByQuantityDescending() {
    _shoppingItems.sort((a, b) {
      return int.parse(b.quantity).compareTo(int.parse(a.quantity));
    });
    notifyListeners();
  }

  // 2)
  void sortByDateAscending() {
    _shoppingItems.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    notifyListeners();
  }

  void sortByDateDescending() {
    _shoppingItems.sort((a, b) {
      return b.date.compareTo(a.date);
    });
    notifyListeners();
  }

  // 3)
  void sortByImportanceAscending() {
    _shoppingItems.sort((a, b) {
      return a.importance.index.compareTo(b.importance.index);
    });
    notifyListeners();
  }

  void sortByImportanceDescending() {
    _shoppingItems.sort((a, b) {
      return b.importance.index.compareTo(a.importance.index);
    });
    notifyListeners();
  }
}
