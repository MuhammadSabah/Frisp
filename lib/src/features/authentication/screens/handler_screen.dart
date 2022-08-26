// import 'package:flutter/material.dart';

// class HandlerScreen extends StatefulWidget {
//   const HandlerScreen({Key? key}) : super(key: key);

//   @override
//   State<HandlerScreen> createState() => _HandlerScreenState();
// }

// class _HandlerScreenState extends State<HandlerScreen> {
//   @override
//   void initState() {
//     super.initState();
//     navigationResult();
//   }

//   Future<bool> userCreateAccountStatus() async {
//     return await UserProfileDao().didUserCreateProfileBefore() ?? false;
//   }

//   void navigationResult() async {
//     final navigator = Navigator.of(context);
//     bool result = await userCreateAccountStatus();
//     // If the user created their profile before.
//     if (result) {
//       navigator.push(MaterialPageRoute(
//         builder: (context) => const OpenVacanciesScreen(),
//       ));
//     } else {
//       navigator.push(MaterialPageRoute(
//         builder: (context) => const CreateProfileScreenView(),
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }