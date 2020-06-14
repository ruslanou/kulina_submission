import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kulina_submission_test/bloc/bloc_state.dart';
import 'package:kulina_submission_test/bloc/product_list_bloc.dart';
import 'package:kulina_submission_test/bloc/product_list_event.dart';
import 'package:kulina_submission_test/constant/constant.dart';
import 'package:kulina_submission_test/services/helper.dart';
import 'package:kulina_submission_test/models/cart.dart';

class ItemCard extends StatelessWidget {
  final int productId;
  final String imageUrl;
  final String productName;
  final String productBrand;
  final String productCategory;
  final int productPrice;
  final double productRating;
  final Function callback;
  ItemCard(
      {@required this.productId,
      @required this.imageUrl,
      @required this.productName,
      @required this.productBrand,
      @required this.productCategory,
      @required this.productPrice,
      @required this.productRating,
      this.callback})
      : assert(productName != null &&
            productBrand != null &&
            productCategory != null &&
            productPrice != null &&
            productRating != null &&
            productId != null);

  bool _firstTime = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Card(
        child: BlocBuilder<ProductListBloc, BlocState>(
          builder: (_, state) {
            if (state is Idle) {
              if (_firstTime) {
                BlocProvider.of<ProductListBloc>(context).add(
                  FindItemInCart(itemId: productId),
                );
                _firstTime = false;
              }
              if (state.event is SubtractQuantity) {
                if (state.data['quantity'] <= 0) {
                  isCartButtonActivated = false;
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    if (callback != null) {
                      callback();
                    }
                  });
                }
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ProductImage(imageUrl),
                  PersonalizedRatingIndicator(productRating),
                  ProductInfo(
                    productName: productName,
                    productBrand: productBrand,
                    productCategory: productCategory,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: <Widget>[
                      PriceTag(productPrice),
                      OutlineButton.icon(
                        textColor: Colors.red,
                        borderSide: BorderSide(color: Colors.red),
                        onPressed: () {
                          BlocProvider.of<ProductListBloc>(context).add(
                            AddProductToCart(
                              productId: productId,
                            ),
                          );
                        },
                        icon: Icon(Icons.add_shopping_cart),
                        label: AutoSizeText(
                          "Tambah ke Keranjang",
                          maxLines: 1,
                          maxFontSize: 10,
                          minFontSize: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else if (state is Success) {
              Cart _itemOnCart = state.data as Cart;
              if (!isCartButtonActivated) {
                isCartButtonActivated = true;
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (callback != null) {
                    callback();
                  }
                });
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ProductImage(imageUrl),
                  PersonalizedRatingIndicator(productRating),
                  ProductInfo(
                    productName: productName,
                    productBrand: productBrand,
                    productCategory: productCategory,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: <Widget>[
                      PriceTag(productPrice),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: OutlineButton(
                              textColor: Colors.red,
                              onPressed: () {
                                BlocProvider.of<ProductListBloc>(context)
                                    .add(SubtractQuantity(cart: _itemOnCart));
                              },
                              child: Icon(Icons.remove),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: OutlineButton(
                              onPressed: null,
                              child: Center(
                                child: Text("${_itemOnCart.quantity}"),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: OutlineButton(
                              textColor: Colors.red,
                              onPressed: () {
                                BlocProvider.of<ProductListBloc>(context)
                                    .add(AddQuantity(cart: _itemOnCart));
                              },
                              child: Icon(Icons.add),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ProductImage(imageUrl),
                PersonalizedRatingIndicator(productRating),
                ProductInfo(
                  productName: productName,
                  productBrand: productBrand,
                  productCategory: productCategory,
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: <Widget>[
                    PriceTag(productPrice),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  final String text;
  TitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: 1,
      maxFontSize: 15,
      minFontSize: 5,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class PriceTag extends StatelessWidget {
  final int price;
  PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 17,
      ),
      child: Row(
        children: <Widget>[
          TitleText(
            Helper().currencyFormatter(price),
          ),
          Text(
            "(Termasuk ongkir)",
            style: TextStyle(fontSize: 6, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  final String imageUrl;
  ProductImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 176,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
      ),
      child: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.medium,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Text("Image Loading...");
          },
        ),
      ),
    );
  }
}

class PersonalizedRatingIndicator extends StatelessWidget {
  final double productRating;
  PersonalizedRatingIndicator(this.productRating);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 13.0,
        top: 10,
      ),
      child: RatingBarIndicator(
        rating: productRating,
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        itemCount: 5,
        itemSize: 15,
        direction: Axis.horizontal,
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  final String productName;
  final String productBrand;
  final String productCategory;
  ProductInfo({this.productName, this.productBrand, this.productCategory});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TitleText(productName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AutoSizeText(
            productBrand,
            maxLines: 1,
            maxFontSize: 10,
            minFontSize: 5,
          ),
          SizedBox(
            height: 10,
          ),
          AutoSizeText(
            productCategory,
            maxLines: 1,
            maxFontSize: 10,
            minFontSize: 5,
          ),
        ],
      ),
    );
  }
}
