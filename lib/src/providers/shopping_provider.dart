import 'package:flutter/foundation.dart';
import 'package:food_recipe_final/src/models/enums/importance_enum.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:food_recipe_final/src/models/shopping_item.dart';

class ShoppingProvider extends ChangeNotifier {
  //Hive
  final Box<ShoppingItem> _shoppingItems =
      Hive.box<ShoppingItem>('shoppingItems');
  Box<ShoppingItem> getShoppingItems() => _shoppingItems;

  // Acts like a Stream, used with Hive.
  ValueListenable<Box<ShoppingItem>> listenToShoppingItems() =>
      _shoppingItems.listenable();

  // Fields:
  int _selectedIndex = -1;
  bool _createNewItem = false;
  String _sortValue = '';
  String get getSortValue => _sortValue;
  void setSortValue(String newVal) {
    _sortValue = newVal;
    notifyListeners();
  }

  // Getters:
  int get selectedIndex => _selectedIndex;

  ShoppingItem? get selectedShoppingItem =>
      selectedIndex != -1 ? _shoppingItems.getAt(selectedIndex) : null;

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

  void deleteItem(int index, ShoppingItem item) {
    _shoppingItems.delete(item.key);
    notifyListeners();
  }

  void updateItem(ShoppingItem item, int index) {
    _shoppingItems.putAt(index, item);
    _selectedIndex = -1;
    _createNewItem = false;
    notifyListeners();
  }

  void completeItem(int index, bool change) {
    final item = _shoppingItems.getAt(index);
    _shoppingItems.putAt(index, item!.copyWith(isComplete: change));
    notifyListeners();
  }

  void shoppingItemTapped(int index) {
    _selectedIndex = index;
    _createNewItem = false;
    notifyListeners();
  }

  void setSelectedShoppingItem(String id) {
    final index = _shoppingItems.values
        .toList()
        .indexWhere((element) => element.id == id);
    _selectedIndex = index;
    _createNewItem = false;
    notifyListeners();
  }

  // Sorting methods:
  // 1) Quantity
  void sortByQuantityAscending() {
    var items = _shoppingItems.values.toList();
    items.sort((a, b) {
      return int.parse(a.quantity).compareTo(int.parse(b.quantity));
    });
    for (var element in items) {
      _shoppingItems.delete(element.key);
      _shoppingItems.add(element);
    }

    notifyListeners();
  }

  void sortByQuantityDescending() {
    var items = _shoppingItems.values.toList();
    items.sort((a, b) {
      return int.parse(b.quantity).compareTo(int.parse(a.quantity));
    });
    for (var element in items) {
      _shoppingItems.delete(element.key);
      _shoppingItems.add(element);
    }

    notifyListeners();
  }

  // 2) Date
  void sortByDateAscending() {
    var items = _shoppingItems.values.toList();
    items.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    for (var element in items) {
      _shoppingItems.delete(element.key);
      _shoppingItems.add(element);
    }
    notifyListeners();
  }

  void sortByDateDescending() {
    var items = _shoppingItems.values.toList();
    items.sort((a, b) {
      return b.date.compareTo(a.date);
    });
    for (var element in items) {
      _shoppingItems.delete(element.key);
      _shoppingItems.add(element);
    }
    notifyListeners();
  }

  // 3) Importance
  void sortByImportanceAscending() {
    var items = _shoppingItems.values.toList();
    items.sort((a, b) {
      return a.importance.toEnum().index.compareTo(b.importance.toEnum().index);
    });
    for (var element in items) {
      _shoppingItems.delete(element.key);
      _shoppingItems.add(element);
    }
    notifyListeners();
  }

  void sortByImportanceDescending() {
    var items = _shoppingItems.values.toList();
    items.sort((a, b) {
      return b.importance.toEnum().index.compareTo(a.importance.toEnum().index);
    });
    for (var element in items) {
      _shoppingItems.delete(element.key);
      _shoppingItems.add(element);
    }
    notifyListeners();
  }
}
