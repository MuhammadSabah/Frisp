import 'package:flutter/material.dart';

class CreateRecipePost extends StatelessWidget {
  const CreateRecipePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text('title'),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
