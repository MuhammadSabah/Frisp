import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/src/providers/settings_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SenderMessageBubble extends StatelessWidget {
  const SenderMessageBubble({
    Key? key,
    required this.message,
    required this.date,
  }) : super(key: key);
  final String message;
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Bubble(
              nip: BubbleNip.leftBottom,
              color:
                  settingsProvider.darkMode ? Colors.white : Colors.grey[850],
              margin: const BubbleEdges.symmetric(horizontal: 12, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 6,
                      top: 5,
                      bottom: 6,
                    ),
                    child: Text(
                      message,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 14,
                            height: 1.6,
                            color: settingsProvider.darkMode
                                ? Colors.black
                                : Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 12),
                Text(
                  DateFormat('dd-MM yy, kk:mm').format(date).toString(),
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
