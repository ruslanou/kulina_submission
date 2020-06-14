import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kulina_submission_test/widgets/product_list/productList_master.dart';
import 'package:kulina_submission_test/bloc/product_list_bloc.dart';
import 'package:kulina_submission_test/widgets/product_list/date_picker.dart';

class ProductList extends StatelessWidget {
  static const String tag = "/product-list";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ClipOval(
          child: Material(
            elevation: 2,
            color: Colors.white, // button color
            child: InkWell(
              child: SizedBox(
                width: 10,
                height: 10,
                child: Icon(
                  Icons.arrow_left,
                  color: Colors.orange,
                ),
              ),
              onTap: () {
                print("Left pressed");
              },
            ),
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            onPressed: () {
              print("Right pressed");
            },
            color: Colors.white,
            textColor: Colors.orange,
            child: Icon(
              Icons.arrow_right,
            ),
            padding: EdgeInsets.all(16),
            shape: CircleBorder(),
          )
        ],
        backgroundColor: Colors.white12,
        title: SizedBox(
          height: 200,
          child: HorizontalDatePicker(),
        ),
      ),
      body: BlocProvider<ProductListBloc>(
        create: (_) => ProductListBloc(),
        child: ProductListMaster(),
      ),
    );
  }
}

