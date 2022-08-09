import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:food_recipe_final/core/app_pages.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/shopping_item.dart';
import 'package:food_recipe_final/src/view/widgets/shopping_tile.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ShoppingItemScreen extends StatefulWidget {
  final Function(ShoppingItem) onCreate;
  final Function(ShoppingItem, int) onUpdate;
  final ShoppingItem? originalItem;
  final int index;
  final bool isUpdating;

  static MaterialPage page({
    ShoppingItem? item,
    int index = -1,
    required Function(ShoppingItem) onCreate,
    required Function(ShoppingItem, int) onUpdate,
  }) {
    return MaterialPage(
      name: AppPages.shoppingItemDetails,
      key: ValueKey(AppPages.shoppingItemDetails),
      child: ShoppingItemScreen(
        originalItem: item,
        index: index,
        onCreate: onCreate,
        onUpdate: onUpdate,
      ),
    );
  }

  const ShoppingItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
    this.index = -1,
  })  : isUpdating = (originalItem != null),
        super(key: key);

  @override
  _ShoppingItemScreenState createState() => _ShoppingItemScreenState();
}

class _ShoppingItemScreenState extends State<ShoppingItemScreen> {
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = kOrangeColorTint2;
  @override
  void initState() {
    super.initState();
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _name = originalItem.name;
      _nameController.text = originalItem.name;
      _quantityController.text = originalItem.quantity.toString();
      _importance = originalItem.importance;
      _currentColor = originalItem.color;
      final date = originalItem.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dueDate = date;
    }

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        useMaterial3: false
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: kOrangeColorTint,
          ),
          centerTitle: true,
          elevation: 0.0,
          bottomOpacity: 0.0,
          leading: IconButton(
              splashRadius: 20,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            'Shopping Item',
            style: Theme.of(context).textTheme.headline2,
          ),
          actions: [
            IconButton(
              splashRadius: 20,
              icon: const Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: () {
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                final isValidForm = _formKey.currentState!.validate();
                if (isValidForm) {
                  final shoppingItem = ShoppingItem(
                    id: widget.originalItem?.id ?? const Uuid().v1(),
                    name: _nameController.text,
                    importance: _importance,
                    color: _currentColor,
                    quantity: _quantityController.text,
                    date: DateTime(
                      _dueDate.year,
                      _dueDate.month,
                      _dueDate.day,
                      _timeOfDay.hour,
                      _timeOfDay.minute,
                    ),
                  );
    
                  if (widget.isUpdating) {
                    widget.onUpdate(shoppingItem, widget.index);
                  } else {
                    widget.onCreate(shoppingItem);
                  }
                }
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNameField(),
                  const SizedBox(height: 8),
                  _buildQuantityField(),
                  const SizedBox(height: 8),
                  _buildImportanceField(),
                  const SizedBox(height: 14),
                  _buildDatePicker(context),
                  const SizedBox(height: 14),
                  _buildTimePicker(context),
                  const SizedBox(height: 14),
                  _buildColorPicker(context),
                  const SizedBox(height: 22),
                  ShoppingTile(
                    item: ShoppingItem(
                      id: 'PreviewMode',
                      name: _name,
                      importance: _importance,
                      color: _currentColor,
                      quantity: _quantityController.text,
                      date: DateTime(
                        _dueDate.year,
                        _dueDate.month,
                        _dueDate.day,
                        _timeOfDay.hour,
                        _timeOfDay.minute,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Name',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        TextFormField(
          validator: (String? value) {
            if (value!.isEmpty) {
              return 'Enter a name';
            }
            if (value.length > 55) {
              return 'Name is too long';
            }
          },
          style: Theme.of(context).textTheme.headline3,
          autofocus: false,
          controller: _nameController,
          cursorColor: Colors.white,
          autocorrect: false,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            filled: true,
            fillColor: kGreyColor,
            counterText: ' ',
            contentPadding: const EdgeInsets.only(left: 8),
            hintText: 'E.g. 1kg of Apples, A bag of Bananas, 500g of salt',
            hintStyle: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.white70,
                ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kOrangeColorTint2),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kOrangeColorTint),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: kOrangeColorTint),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImportanceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Importance',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Wrap(
          spacing: 10.0,
          children: [
            ChoiceChip(
              backgroundColor: Colors.grey,
              selectedColor: Colors.grey.shade700,
              selected: _importance == Importance.low,
              label: Text(
                'low',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 14),
              ),
              onSelected: (selected) {
                setState(() => _importance = Importance.low);
              },
            ),
            ChoiceChip(
              backgroundColor: Colors.grey,
              selectedColor: Colors.grey.shade700,
              selected: _importance == Importance.medium,
              label: Text(
                'medium',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 14),
              ),
              onSelected: (selected) {
                setState(() => _importance = Importance.medium);
              },
            ),
            ChoiceChip(
              backgroundColor: Colors.grey,
              selectedColor: Colors.grey.shade700,
              selected: _importance == Importance.high,
              label: Text(
                'high',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 14),
              ),
              onSelected: (selected) {
                setState(() => _importance = Importance.high);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            TextButton(
              child: Icon(
                Icons.adjust,
                size: 25,
                color: Colors.grey.shade500,
              ),
              onPressed: () async {
                final currentDate = DateTime.now();
                final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: currentDate,
                    firstDate: currentDate,
                    lastDate: DateTime(currentDate.year + 5),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: kOrangeColorTint2,
                            onPrimary: kGreyColor,
                            onSurface: kBlackColor,
                          ),
                        ),
                        child: child!,
                      );
                    });

                setState(() {
                  if (selectedDate != null) {
                    _dueDate = selectedDate;
                  }
                });
              },
            ),
          ],
        ),
        Text(
          DateFormat('yyyy-MM-dd').format(_dueDate),
          style: TextStyle(color: Colors.grey.shade500),
        ),
      ],
    );
  }

  Widget _buildTimePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time of Day',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            TextButton(
              child: Icon(
                Icons.adjust,
                size: 25,
                color: Colors.grey.shade500,
              ),
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: kOrangeColorTint2,
                            onPrimary: kGreyColor,
                            onSurface: kBlackColor,
                          ),
                        ),
                        child: child!,
                      );
                    });

                setState(() {
                  if (timeOfDay != null) {
                    _timeOfDay = timeOfDay;
                  }
                });
              },
            ),
          ],
        ),
        Text(
          _timeOfDay.format(context),
          style: TextStyle(color: Colors.grey.shade500),
        ),
      ],
    );
  }

  Widget _buildColorPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 10,
              color: _currentColor,
            ),
            const SizedBox(width: 8),
            Text(
              'Color',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        TextButton(
          child: Icon(
            Icons.adjust,
            size: 25,
            color: Colors.grey.shade500,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: BlockPicker(
                    pickerColor: Colors.white,
                    onColorChanged: (color) {
                      setState(() => _currentColor = color);
                    },
                  ),
                  actions: [
                    TextButton(
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          color: kGreyColor,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuantityField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Quantity',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: SizedBox(
            width: 85,
            child: TextFormField(
              validator: (String? value) {
                if (value!.length >= 5) {
                  return 'Too much';
                }
              },
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.headline3,
              autofocus: false,
              autocorrect: false,
              textInputAction: TextInputAction.done,
              controller: _quantityController,
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                fillColor: kGreyColor,
                filled: true,
                counterText: ' ',
                contentPadding: EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kOrangeColorTint2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kOrangeColorTint),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: kOrangeColorTint),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}