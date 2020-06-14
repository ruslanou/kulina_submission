import 'package:flutter/material.dart';
import 'package:kulina_submission_test/pages/product_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kulina App',
      initialRoute: ProductList.tag,
      routes: {
        ProductList.tag: (_) => ProductList(),
      },
    );
  }
}
