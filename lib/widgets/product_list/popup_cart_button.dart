import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kulina_submission_test/bloc/bloc_state.dart';
import 'package:kulina_submission_test/bloc/product_list_bloc.dart';
import 'package:kulina_submission_test/pages/checkout_page.dart';

class PopupCartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 20,
      right: 20,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width / 1.1,
        color: Colors.red,
        child: OutlineButton(
          onPressed: () {
            print("Show Cart screen");
          },
          child: BlocBuilder<ProductListBloc, BlocState>(
            builder: (_, state) {
              // if(state)
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Makanan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        "Termasuk ongkos kirim",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckOutPage()),);
                    },
                    child: Text(
                      "CHECKOUT >",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
