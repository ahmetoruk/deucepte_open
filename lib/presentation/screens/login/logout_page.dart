import 'package:flutter/material.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Başarıyla çıkış yapıldı! Uygulamayı kapatın.'),
      ),
    );
  }
}
