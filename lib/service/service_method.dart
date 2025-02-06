import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/config/httpheaders.dart';




//封装的接口请求
Future requestHttp(url,{formData}) async {
  try {
    Response response;
    Dio dio = Dio();
    dio.options.contentType = "application/json";
    dio.options.headers = httpHeaders;

    if (formData == null) {
      response = await dio.post(servicePath[url]!);
    } else {
      response = await dio.post(servicePath[url]!, data: formData);
    }

    if(response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    } else {
      // throw Exception("后端接口出现异常");
      print("Request failed with status: ${response.statusCode}");
    }


  } catch (e) {
    return print("Error:========>${e}");
  }
}