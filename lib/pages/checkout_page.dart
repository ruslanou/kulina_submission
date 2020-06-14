import 'package:flutter/material.dart';

class CheckOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Review Pesanan",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset(
              "assets/images/empty_cart.png",
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Keranjangmu masih kosong, nih",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 150
          ),
          Container(
            height: 60,
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Center(
                child: Text("Pesan Sekarang"),
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
