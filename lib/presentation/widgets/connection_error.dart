import 'package:flutter/material.dart';

class ConnectionError extends StatelessWidget {
  const ConnectionError({
    Key? key,
    required this.fetch,
  }) : super(key: key);

  final void Function()? fetch;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Hata'),
          ElevatedButton(
            onPressed: fetch,
            child: const Text('Yeniden dene'),
          )
        ],
      ),
    );
  }
}
