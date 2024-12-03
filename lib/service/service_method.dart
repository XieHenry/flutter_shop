import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/config/httpheaders.dart';

//获取首页主题内容
Future getHomepageContent() async {
  try {
    print("开始获取首页数据............................");

    Response response;
    Dio dio = Dio();

    dio.options.contentType = "application/json";

    var formData = {
      "ids": [
        "100843101",
        "100839601",
        "100017301",
        "100020801",
        "100002201",
        "100006601",
        "100007101",
        "100006701",
        "100039001",
        "100021701"
      ]
    };

    dio.options.headers = httpHeaders;
    response = await dio.post(servicePath["homePageContent"]!, data: formData);

    if(response.statusCode == 200) {
      return response.data;
    } else {
      // throw Exception("后端接口出现异常");
      print("Request failed with status: ${response.statusCode}");
    }


  } catch (e) {
    return print("Error:========>${e}");
  }
}
