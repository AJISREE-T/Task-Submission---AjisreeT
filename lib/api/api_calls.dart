import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:productapp/api/api_links.dart';
import 'package:http/http.dart' as http;
import 'package:productapp/model/category_model.dart';
import 'package:productapp/model/product_model.dart';

class ApiCalls {
  static loginUser({required email, required password}) async {
    try {
      String url = '${ApiLinks.loginUrl}?email=$email&password=$password';

      var response = await http.post(Uri.parse(url));
      log(response.body.toString());
      log(url.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        var data = jsonDecode(response.body);
        return data;
      } else {
        return [
          {'Result': "Failed to connect"}
        ];
      }
    } on SocketException {
      return [
        {'Result': "Network Error"}
      ];
    } catch (e) {
      return [
        {'Result': e}
      ];
    }
  }

  Future<Map> getCategory() async {
    try {
      String url = '${ApiLinks.categoryUrl}';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<CategoryModel> categoryData = categoryModelFromJson(response.body);
        return {'Result': 'success', 'data': categoryData};
      } else {
        return {'Result': 'Failed to connect'};
      }
    } on SocketException {
      return {'Result': 'Network Error'};
    } catch (e) {
      return {'Result': e};
    }
  }

  Future<Map> getProducts() async {
    try {
      String url = '${ApiLinks.productUrl}';
      var response = await http.get(Uri.parse(url));
      log(response.body.toString());
      log(url.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        List<ProductModel> productData = productModelFromJson(response.body);
        return {'Result': 'success', 'data': productData};
      } else {
        return {'Result': 'Failed to connect'};
      }
    } on SocketException {
      return {'Result': 'Network Error'};
    } catch (e) {
      return {'Result': e};
    }
  }
}
