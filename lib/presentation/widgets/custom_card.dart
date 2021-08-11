import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key, required this.title, this.actions, required this.content})
      : super(key: key);

  final Widget title;
  final List<Widget>? actions;
  final Widget content;

  Widget cardHeader({required Widget title, List<Widget>? actions}) {
    return ListTile(
      title: title,
      trailing: Row(
        children: actions!,
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          cardHeader(
            title: title,
            actions: actions,
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
