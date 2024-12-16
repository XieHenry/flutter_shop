import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/config/httpheaders.dart';

//获取首页主题内容
Future getHomePageContent() async {
  try {
    print("开始获取首页轮播图............................");

    Response response;
    Dio dio = Dio();

    dio.options.contentType = "application/json";

    var formData = {
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



//获取首页推荐图
Future getHomeCommendContent() async {
  try {
    print("开始获取首页推荐商品............................");

    Response response;
    Dio dio = Dio();

    dio.options.contentType = "application/json";

    var formData = {
      "tag_ids": [
        5
      ],
      "product_type": 1,
      "product_form": 2,
      "pvip": 0,
      "prev": 0,
      "size": 20,
      "sort": 4,
      "with_articles": true
    };

    dio.options.headers = httpHeaders;
    response = await dio.post(servicePath["homeCommendList"]!, data: formData);


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



// 首页 广告
Future getHomeAdContent() async {
  try {
    print("开始获取首页广告商品............................");

    Response response;
    Dio dio = Dio();

    dio.options.contentType = "application/json";

    var formData = {
      "block_name": "lecture_banner_v2"
    };

    dio.options.headers = httpHeaders;
    response = await dio.post(servicePath["homeAdContent"]!, data: formData);


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


