import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
              color: Colors.white,
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
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 14,
                            height: 1.6,
                            color: Colors.black,
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
