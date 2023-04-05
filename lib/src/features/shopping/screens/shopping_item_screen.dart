import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/models/enums/importance_enum.dart';
import 'package:food_recipe_final/src/models/shopping_item.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:food_recipe_final/src/providers/shopping_provider.dart';
import 'package:food_recipe_final/src/features/shopping/widgets/shopping_tile.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ShoppingItemScreen extends StatefulWidget {
  final ShoppingItem? originalItem;
  final int index;
  final bool isUpdating;

  const ShoppingItemScreen({
    Key? key,
    this.originalItem,
    this.index = -1,
  })  : isUpdating = (originalItem != null),
        super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ShoppingItemScreenState createState() => _ShoppingItemScreenState();
}

class _ShoppingItemScreenState extends State<ShoppingItemScreen> {
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = '';
  ImportanceEnum _importance = ImportanceEnum.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  int _currentColor = kOrangeColorTint2.value;
  @override
  void initState() {
    super.initState();
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _name = originalItem.name;
      _nameController.text = originalItem.name;
      _quantityController.text = originalItem.quantity.toString();
      _importance = originalItem.importance.toEnum();
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
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shoppingProvider =
        Provider.of<ShoppingProvider>(context, listen: false);
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Theme(
      data: Theme.of(context).copyWith(useMaterial3: false),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: const Key('shoppingItemScreen'),
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
                icon: Icon(
                  Icons.arrow_back,
                  color: settingsManager.darkMode ? Colors.white : Colors.black,
                )),
            title: Text(
              'Shopping Item',
              style:
                  Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 18),
            ),
            actions: [
              IconButton(
                key: const Key('shoppingItemScreen_saveButton'),
                splashRadius: 20,
                icon: Icon(
                  
                  Icons.check,
                  color: settingsManager.darkMode ? Colors.white : Colors.black,
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
                      importance: _importance.type,
                      color: _currentColor,
                      quantity: _quantityController.text.isEmpty
                          ? 1.toString()
                          : _quantityController.text,
                      date: DateTime(
                        _dueDate.year,
                        _dueDate.month,
                        _dueDate.day,
                        _timeOfDay.hour,
                        _timeOfDay.minute,
                      ),
                    );

                    if (widget.isUpdating) {
                      shoppingProvider.updateItem(shoppingItem, widget.index);
                      Navigator.of(context).pop();
                    } else {
                      shoppingProvider.addItem(shoppingItem);
                      Navigator.of(context).pop();
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
                        importance: _importance.type,
                        color: _currentColor,
                        quantity: _quantityController.text.isEmpty
                            ? 1.toString()
                            : _quantityController.text,
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
      ),
    );
  }

  Widget _buildNameField() {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Name',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        TextFormField(
          key: const Key('nameTextField'),
          validator: (String? value) {
            if (value!.isEmpty) {
              return 'Enter a name';
            }
            if (value.length > 55) {
              return 'Name is too long';
            }
            return null;
          },
          style: Theme.of(context).textTheme.displaySmall,
          autofocus: false,
          controller: _nameController,
          cursorColor: settingsManager.darkMode ? Colors.white : Colors.black,
          autocorrect: false,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            filled: true,
            fillColor: settingsManager.darkMode ? kGreyColor : kGreyColor4,
            counterText: ' ',
            contentPadding: const EdgeInsets.only(left: 8),
            hintText: 'E.g. 1kg of Apples, A bag of Bananas, 500g of salt',
            hintStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: settingsManager.darkMode
                      ? Colors.white70
                      : Colors.grey.shade800,
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
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Importance',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Wrap(
          spacing: 10.0,
          children: [
            ChoiceChip(
              backgroundColor:
                  settingsManager.darkMode ? Colors.grey : Colors.grey.shade300,
              selectedColor: settingsManager.darkMode
                  ? Colors.grey.shade700
                  : Colors.grey.shade500,
              selected: _importance == ImportanceEnum.low,
              label: Text(
                'low',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 14),
              ),
              onSelected: (selected) {
                setState(() => _importance = ImportanceEnum.low);
              },
            ),
            ChoiceChip(
              backgroundColor:
                  settingsManager.darkMode ? Colors.grey : Colors.grey.shade300,
              selectedColor: settingsManager.darkMode
                  ? Colors.grey.shade700
                  : Colors.grey.shade500,
              selected: _importance == ImportanceEnum.medium,
              label: Text(
                'medium',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 14),
              ),
              onSelected: (selected) {
                setState(() => _importance = ImportanceEnum.medium);
              },
            ),
            ChoiceChip(
              backgroundColor:
                  settingsManager.darkMode ? Colors.grey : Colors.grey.shade300,
              selectedColor: settingsManager.darkMode
                  ? Colors.grey.shade700
                  : Colors.grey.shade500,
              selected: _importance == ImportanceEnum.high,
              label: Text(
                'high',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 14),
              ),
              onSelected: (selected) {
                setState(() => _importance = ImportanceEnum.high);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextButton(
              child: Icon(
                Icons.adjust,
                size: 25,
                color: settingsManager.darkMode
                    ? Colors.grey.shade500
                    : Colors.grey.shade700,
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
          style: TextStyle(
            color: settingsManager.darkMode
                ? Colors.grey.shade500
                : Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildTimePicker(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time of Day',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextButton(
              child: Icon(
                Icons.adjust,
                size: 25,
                color: settingsManager.darkMode
                    ? Colors.grey.shade500
                    : Colors.grey.shade700,
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
          style: TextStyle(
            color: settingsManager.darkMode
                ? Colors.grey.shade500
                : Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildColorPicker(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 10,
              color: Color(_currentColor),
            ),
            const SizedBox(width: 8),
            Text(
              'Color',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        TextButton(
          child: Icon(
            Icons.adjust,
            size: 25,
            color: settingsManager.darkMode
                ? Colors.grey.shade500
                : Colors.grey.shade700,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: BlockPicker(
                    pickerColor: Colors.white,
                    onColorChanged: (color) {
                      setState(() => _currentColor = color.value);
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
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textBaseline: TextBaseline.ideographic,
      children: [
        Text(
          'Quantity',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: SizedBox(
            width: 85,
            child: TextFormField(
              key: const Key('quantityField'),
              validator: (String? value) {
                if (value!.length >= 5) {
                  return 'Too much';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.displaySmall,
              autofocus: false,
              autocorrect: false,
              textInputAction: TextInputAction.done,
              controller: _quantityController,
              cursorColor:
                  settingsManager.darkMode ? Colors.white : Colors.black,
              decoration: InputDecoration(
                fillColor: settingsManager.darkMode ? kGreyColor : kGreyColor4,
                filled: true,
                counterText: ' ',
                contentPadding: const EdgeInsets.all(8),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kOrangeColorTint2),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kOrangeColorTint),
                ),
                border: const OutlineInputBorder(
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
