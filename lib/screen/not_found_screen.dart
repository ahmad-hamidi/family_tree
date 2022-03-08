import 'package:auto_route/auto_route.dart';
import 'package:family_tree/config/routes.gr.dart';
import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            context.pushRoute(const HomeScreen());
          },
        ),
      ),
      body: const Center(
        child: Text(
          "Page Not Found",
          style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              decoration: TextDecoration.none),
        ),
      ),
    );
  }
}
