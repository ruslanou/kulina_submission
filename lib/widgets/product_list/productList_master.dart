import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kulina_submission_test/widgets/product_list/item_cart.dart';
import 'package:kulina_submission_test/widgets/product_list/popup_cart_button.dart';

import '../../bloc/bloc_state.dart';
import '../../bloc/product_list_bloc.dart';
import '../../bloc/product_list_event.dart';
import '../../constant/constant.dart';
import '../../models/product_model.dart';

class ProductListMaster extends StatefulWidget {
  @override
  _ProductListMasterState createState() => _ProductListMasterState();
}

class _ProductListMasterState extends State<ProductListMaster> {
  final List<Widget> _widgets = [];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 1.49;
    final double itemWidth = size.width / 2;

    return Container(
      child: BlocBuilder<ProductListBloc, BlocState>(
        builder: (_, state) {
          if (state is Idle) {
            BlocProvider.of<ProductListBloc>(context).add(RequestProduct());
          } else if (state is Success) {
            (state.data as List<Product>).forEach(
              (product) {
                _widgets.add(
                  BlocProvider<ProductListBloc>(
                    create: (_) => ProductListBloc(),
                    child: ItemCard(
                      productId: product.id,
                      imageUrl: product.imageUrl,
                      productName: product.name,
                      productBrand: product.brandName,
                      productCategory: product.packageName,
                      productPrice: product.price,
                      productRating: product.rating,
                      callback: () {
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            );

            return Stack(
              children: <Widget>[
                GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (itemWidth / itemHeight),
                  children: _widgets,
                ),
                BlocProvider<ProductListBloc>(
                  create: (context) => ProductListBloc(),
                  child:
                      isCartButtonActivated ? PopupCartButton() : Container(),
                ),
              ],
            );
          } else if (state is Error) {
            print(state.error);
            // TODO: Make an error screen
            return Container();
          }
          return const Center(
            child: const CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
