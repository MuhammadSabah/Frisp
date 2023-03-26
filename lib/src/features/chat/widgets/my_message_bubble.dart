import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:intl/intl.dart';

class MyMessageBubble extends StatelessWidget {
  const MyMessageBubble({
    Key? key,
    required this.message,
    required this.date,
  }) : super(key: key);
  final String message;
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Bubble(
              nip: BubbleNip.rightBottom,
              color: kOrangeColor,
              margin: const BubbleEdges.symmetric(horizontal: 12, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 14, height: 1.6),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat('dd-MM yy, kk:mm').format(date).toString(),
                  maxLines: 1,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.done_all,
                  size: 20,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 12),
              ],
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
