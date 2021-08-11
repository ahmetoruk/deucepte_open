import 'package:flutter/material.dart';

import 'package:theme_provider/theme_provider.dart';

final themes = [
  AppTheme(
    id: 'kırmızı_tema',
    description: '',
    data: ThemeData(
      primarySwatch: Colors.red,
    ),
  ),
  AppTheme(
    id: 'yeşil_tema',
    description: '',
    data: ThemeData(primarySwatch: Colors.green),
  ),
  AppTheme(
    id: 'pembe_tema',
    description: '',
    data: ThemeData(primarySwatch: Colors.pink),
  ),
  AppTheme(
    id: 'mor_tema',
    description: '',
    data: ThemeData(primarySwatch: Colors.purple),
  ),
  AppTheme(
    id: 'karanlık_tema',
    description: '',
    data: ThemeData(brightness: Brightness.dark),
  ),
];
