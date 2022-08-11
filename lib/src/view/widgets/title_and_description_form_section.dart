import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/constants.dart';

class TitleAndDescriptionFormSection extends StatelessWidget {
  const TitleAndDescriptionFormSection({
    Key? key,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    required this.servesController,
    required this.cookTimeController,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController servesController;
  final TextEditingController cookTimeController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Title Required';
                }
                return null;
              },
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.w600, fontSize: 20, height: 1.6),
              controller: titleController,
              maxLines: 2,
              cursorHeight: 30,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.text,
              obscureText: false,
              decoration: InputDecoration(
                counterText: ' ',
                fillColor: kGreyColor,
                filled: true,
                isCollapsed: true,
                contentPadding: const EdgeInsets.all(18),
                hintText: "Title: Mother's vegetable soup",
                hintStyle: Theme.of(context).textTheme.headline4!.copyWith(
                    fontSize: 20,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                    height: 1.6),
                focusedErrorBorder: kFocusedErrorBorder,
                errorBorder: kErrorBorder,
                enabledBorder: kEnabledBorder,
                focusedBorder: kFocusedBorder,
                border: kBorder,
              ),
            ),
            TextFormField(
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Description Required';
                }
                return null;
              },
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.w400, fontSize: 18, height: 1.6),
              controller: descriptionController,
              maxLines: 6,
              cursorHeight: 30,
              autofocus: false,
              autocorrect: false,
              keyboardType: TextInputType.text,
              obscureText: false,
              decoration: InputDecoration(
                counterText: ' ',
                fillColor: kGreyColor,
                filled: true,
                isCollapsed: true,
                contentPadding: const EdgeInsets.all(18),
                hintText:
                    "Description: What's the origin of your recipe? What inspired it? what makes it special?",
                hintStyle: Theme.of(context).textTheme.headline4!.copyWith(
                    fontSize: 18,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                    height: 1.6),
                focusedErrorBorder: kFocusedErrorBorder,
                errorBorder: kErrorBorder,
                enabledBorder: kEnabledBorder,
                focusedBorder: kFocusedBorder,
                border: kBorder,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Serves',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: SizedBox(
                          width: 135,
                          child: Align(
                            child: TextFormField(
                              validator: (String? value) {
                                if (value!.length >= 10) {
                                  return 'Too much';
                                }
                              },
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      height: 1.6),
                              autofocus: false,
                              autocorrect: false,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              controller: servesController,
                              decoration: InputDecoration(
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                        fontSize: 17,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w400,
                                        height: 1.6),
                                hintText: '2 people',
                                fillColor: kGreyColor,
                                filled: true,
                                counterText: ' ',
                                contentPadding: const EdgeInsets.all(8),
                                focusedErrorBorder: kFocusedErrorBorder,
                                errorBorder: kErrorBorder,
                                enabledBorder: kEnabledBorder,
                                focusedBorder: kFocusedBorder,
                                border: kBorder,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cook time',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: SizedBox(
                          width: 135,
                          child: TextFormField(
                            validator: (String? value) {
                              if (value!.length >= 20) {
                                return 'Too much';
                              }
                            },
                            keyboardType: TextInputType.visiblePassword,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    height: 1.6),
                            autofocus: false,
                            autocorrect: false,
                            textInputAction: TextInputAction.done,
                            controller: cookTimeController,
                            decoration: InputDecoration(
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                      fontSize: 18,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w400,
                                      height: 1.6),
                              hintText: '1 hr 30 mins',
                              fillColor: kGreyColor,
                              filled: true,
                              counterText: ' ',
                              contentPadding: const EdgeInsets.all(8),
                              focusedErrorBorder: kFocusedErrorBorder,
                              errorBorder: kErrorBorder,
                              enabledBorder: kEnabledBorder,
                              focusedBorder: kFocusedBorder,
                              border: kBorder,
                            ),
                          ),
                        ),
                      ),
                    ],
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
