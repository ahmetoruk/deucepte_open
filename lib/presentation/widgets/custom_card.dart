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
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.8)),
            ),
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
