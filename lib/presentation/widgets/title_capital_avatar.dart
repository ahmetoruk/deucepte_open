import 'package:flutter/material.dart';

class TitleCapitalAvatar extends StatelessWidget {
  const TitleCapitalAvatar({
    required this.letter,
    Key? key,
  }) : super(key: key);

  final String letter;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      radius: 24,
      child: Text(
        letter,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
