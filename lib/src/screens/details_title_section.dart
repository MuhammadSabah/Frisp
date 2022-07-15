import 'package:flutter/material.dart';
import 'package:food_recipe_final/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsTitleSection extends StatefulWidget {
  const DetailsTitleSection({
    Key? key,
    required this.sourceUrl,
    required this.title,
    required this.dishTypes,
    required this.diets,
    required this.keysList,
  }) : super(key: key);
  final String sourceUrl;
  final String title;
  final List<String> dishTypes;
  final List<String> diets;
  final List<String> keysList;
  @override
  State<DetailsTitleSection> createState() => _DetailsTitleSectionState();
}

class _DetailsTitleSectionState extends State<DetailsTitleSection> {
  bool _heartClicked = false;
  bool _starClicked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _heartClicked = !_heartClicked;
                      });
                    },
                    icon: Icon(
                      _heartClicked == false
                          ? Icons.favorite_border_outlined
                          : Icons.favorite,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _starClicked = !_starClicked;
                      });
                    },
                    icon: Icon(
                      _starClicked == false ? Icons.star_outline : Icons.star,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      final Uri toLaunch = Uri.parse(
                        widget.sourceUrl,
                      );
                      if (!await launchUrl(toLaunch,
                          mode: LaunchMode.externalApplication)) {
                        throw 'Could not launch $toLaunch';
                      }
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: Colors.white60,
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        'More Info',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.title,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 28,
                ),
            maxLines: 4,
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: widget.dishTypes.isEmpty ? 0 : 25,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  'Dish Types: ',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 14,
                        color: Colors.grey.shade300,
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
                        style: Theme.of(context).textTheme.headline4!.copyWith(
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
            height: widget.diets.isEmpty ? 0 : 25,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  'Diets: ',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 14,
                        color: Colors.grey.shade300,
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
                        style: Theme.of(context).textTheme.headline4!.copyWith(
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
                  backgroundColor: Colors.white,
                  label: Text(
                    widget.keysList[index].toString(),
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: kOrangeColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
