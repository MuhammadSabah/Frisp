import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsTitleSection extends StatefulWidget {
  const DetailsTitleSection({
    Key? key,
    required this.sourceUrl,
    required this.title,
    required this.sourceName,
    required this.dishTypes,
    required this.diets,
    required this.keysList,
  }) : super(key: key);
  final String sourceUrl;
  final String title;
  final String sourceName;
  final List<String> dishTypes;
  final List<String> diets;
  final List<String> keysList;
  @override
  State<DetailsTitleSection> createState() => _DetailsTitleSectionState();
}

class _DetailsTitleSectionState extends State<DetailsTitleSection> {
  @override
  Widget build(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'By ${widget.sourceName}',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                  maxLines: 2,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          final Uri link = Uri.parse(widget.sourceUrl);
                          try {
                            await launchUrl(link,
                                mode: LaunchMode.externalApplication);
                          } catch (e) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Could not be launched!'),
                              duration: Duration(
                                milliseconds: 2300,
                              ),
                              backgroundColor: kOrangeColorTint2,
                            ));
                          }
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(
                              color: settingsManager.darkMode
                                  ? Colors.white60
                                  : Colors.grey,
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'More Info',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 24,
                  ),
              maxLines: 4,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: widget.dishTypes.isEmpty ? 0 : 26,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  'Dish Types: ',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 14,
                        color: settingsManager.darkMode
                            ? Colors.grey.shade300
                            : Colors.grey.shade700,
                      ),
                ),
                Expanded(
                  child: ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.dishTypes.length,
                    itemBuilder: (context, index) {
                      return Text(
                        widget.dishTypes[index],
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                      );
                    },
                    separatorBuilder: (_, index) {
                      return const SizedBox(width: 6);
                    },
                  ),
                ),
              ],
            ),
          ),
          //!:
          SizedBox(
            height: widget.diets.isEmpty ? 0 : 26,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  'Diets: ',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 14,
                        color: settingsManager.darkMode
                            ? Colors.grey.shade300
                            : Colors.grey.shade700,
                      ),
                ),
                Expanded(
                  child: ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.diets.length,
                    itemBuilder: (context, index) {
                      return Text(
                        widget.diets[index],
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                      );
                    },
                    separatorBuilder: (_, index) {
                      return const SizedBox(width: 6);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: widget.keysList.isEmpty ? 0 : 40,
            child: ListView.separated(
              separatorBuilder: (_, index) {
                return const SizedBox(width: 6);
              },
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.horizontal,
              itemCount: widget.keysList.length,
              itemBuilder: (BuildContext context, int index) {
                return Chip(
                  elevation: 4,
                  backgroundColor: settingsManager.darkMode
                      ? Colors.white
                      : Colors.grey.shade100,
                  label: Text(
                    widget.keysList[index].toString(),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: kOrangeColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
