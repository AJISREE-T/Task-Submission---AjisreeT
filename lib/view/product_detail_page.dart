import 'package:flutter/material.dart';
import 'package:productapp/api/api_calls.dart';
import 'package:productapp/model/category_model.dart';
import 'package:productapp/model/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key,
  //  required this.productDetails
   });
  // final CategoryModel productDetails;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ApiCalls().getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            Map data = snapshot.data!;
            if (data['Result'] == 'success') {
              ProductModel productData = snapshot.data!['data'];
              return Column(
                children: [
                  Container(
                    child: Image(image: AssetImage(productData.partImage)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(child: Text(productData.price))
                ],
              );
            } else {
              return Text('something went wrong');
            }
          } else {
            return Text('something went wrong.....');
          }
        },
      ),
    );
  }
}
