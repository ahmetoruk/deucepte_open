import 'package:flutter/material.dart';

class ForwardIcon extends StatelessWidget {
  const ForwardIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_forward_ios,
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
    );
  }
}
