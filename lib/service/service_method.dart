import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/config/httpheaders.dart';

//获取首页主题内容
Future getHomePageContent() async {
  try {
    print("开始获取首页数据............................");

    Response response;
    Dio dio = Dio();

    dio.options.contentType = "application/json";

    var formData = {
      "page" : "1",
      "size" : "5"
    };

    dio.options.headers = httpHeaders;
    response = await dio.post(servicePath["homePageContent"]!, data: formData);


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
