import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:food_recipe_final/src/features/search_recipe/widgets/custom_drop_down.dart';
import 'package:provider/provider.dart';

class AddFieldsSection extends StatefulWidget {
  const AddFieldsSection({
    Key? key,
    required this.formKey,
    required this.formFieldsList,
    required this.controllersList,
    required this.popUpItemsList,
    required this.sectionText,
    required this.buttonText,
    required this.leadingTextFieldColor,
    required this.addButtonColor,
    required this.validatorText,
    required this.hintText,
    required this.buttonTextColor,
    required this.maxLines,
    required this.leadingTextFieldTextColor,
    required this.cursorColor,
  }) : super(key: key);
  final formKey;
  final String sectionText;
  final String buttonText;
  final Color buttonTextColor;
  final String hintText;
  final String validatorText;
  final Color leadingTextFieldColor;
  final Color leadingTextFieldTextColor;
  final Color addButtonColor;
  final Color cursorColor;
  final int maxLines;
  final List formFieldsList;
  final List controllersList;
  final List<String> popUpItemsList;
  @override
  State<AddFieldsSection> createState() => _AddFieldsSectionState();
}

class _AddFieldsSectionState extends State<AddFieldsSection> {
  @override
  Widget build(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(14.0).copyWith(right: 0),
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      widget.sectionText,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ),
              ],
              // !: TextFields list:
            ),
            ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8);
                },
                primary: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.formFieldsList.length,
                itemBuilder: (context, int index) {
                  int num = index + 1;
                  if (index >= 20) {
                    return const SizedBox();
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Container(
                          width: 40,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: widget.leadingTextFieldColor,
                          ),
                          child: Center(
                            child: Text(
                              '$num',
                              style: TextStyle(
                                  color: widget.leadingTextFieldTextColor),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return widget.validatorText;
                              }
                              return null;
                            },
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.center,
                            style:
                                Theme.of(context).textTheme.displaySmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      height: 1.4,
                                    ),
                            controller: widget.controllersList[index],
                            autofocus: false,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            maxLines: widget.maxLines,
                            cursorColor: widget.cursorColor,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              counterText: ' ',
                              fillColor: settingsManager.darkMode
                                  ? kGreyColor
                                  : kGreyColor4,
                              filled: true,
                              isCollapsed: true,
                              contentPadding: const EdgeInsets.all(18),
                              hintText: widget.hintText,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontSize: 15,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold,
                                    height: 1.4,
                                  ),
                              focusedErrorBorder: kFocusedErrorBorder,
                              errorBorder: kErrorBorder,
                              enabledBorder: kEnabledBorder,
                              focusedBorder: kFocusedBorder,
                              border: kBorder,
                            ),
                          ),
                        ),
                        PopupMenuButton(
                          splashRadius: 20,
                          icon: FaIcon(
                            FontAwesomeIcons.ellipsisVertical,
                            color: settingsManager.darkMode
                                ? Colors.white
                                : Colors.black,
                            size: 22,
                          ),
                          onSelected: (String? value) {
                            if (value == 'Delete item') {
                              widget.formFieldsList.removeAt(index);
                              widget.controllersList.removeAt(index);
                              FocusManager.instance.primaryFocus?.unfocus();
                              setState(() {});
                            }
                            if (value == 'Add item') {
                              widget.controllersList
                                  .add(TextEditingController());
                              widget.formFieldsList.add(3);
                              setState(() {});
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return widget.popUpItemsList
                                .map<CustomDropDownMenu<String>>(
                                  (String value) => CustomDropDownMenu(
                                    value: value,
                                    text: value,
                                    isRemovable: false,
                                  ),
                                )
                                .toList();
                          },
                        ),
                      ],
                    );
                  }
                }),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 46.0, top: 14, right: 65, left: 65),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Material(
                        color: widget.addButtonColor,
                        elevation: 4,
                        child: InkWell(
                          onTap: () {
                            int val = 0;
                            widget.formFieldsList.add(val);
                            val += val++;
                            widget.controllersList.add(TextEditingController());
                            setState(() {});
                          },
                          child: Ink(
                            height: 40,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            )),
                            child: Center(
                              child: Text(
                                widget.buttonText,
                                style: TextStyle(
                                  color: widget.buttonTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
