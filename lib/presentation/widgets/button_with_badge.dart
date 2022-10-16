import 'package:flutter/material.dart';

class ButtonWithBadge extends StatelessWidget {
  const ButtonWithBadge({
    Key? key,
    required this.badgeCount,
    this.onPressed,
    required this.child,
  }) : super(key: key);

  final int badgeCount;
  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: onPressed, child: child),
        ),
        if (badgeCount > 0)
          Positioned(
            top: 0,
            right: 0,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Text(badgeCount.toString()),
            ),
          ),
      ],
    );
  }
}
