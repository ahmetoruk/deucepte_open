import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key, required this.title, this.actions, required this.content})
      : super(key: key);

  final String title;
  final List<Widget>? actions;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(title),
            trailing: Row(
              children: actions!,
              mainAxisSize: MainAxisSize.min,
            ),
          ),
          const Divider(
            height: 1,
          ),
          content
        ],
      ),
    );
  }
}
