import 'package:flutter/material.dart';

import 'data/mock_api_space_items_api.dart';
import 'ui/screens/catalog_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Каталог космоса',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2F5D50)),
        scaffoldBackgroundColor: const Color(0xFFF3F1EC),
      ),
      home: CatalogScreen(api: MockApiSpaceItemsApi()),
    ),
  );
}
