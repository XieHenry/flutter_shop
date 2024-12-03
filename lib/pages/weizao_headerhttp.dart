import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shop/config/httpheaders.dart';

class WeizaoHttpPage extends StatefulWidget {
  const WeizaoHttpPage({super.key});

  @override
  State<WeizaoHttpPage> createState() => _WeizaoHttpPageState();
}

class _WeizaoHttpPageState extends State<WeizaoHttpPage> {
  String showText = "还没有请求数据";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: const Text("请求数据")),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ElevatedButton(
                onPressed: _jike,
                child: const Text("请求数据"),
              ),
              Text(showText),
            ],
          ),
        ),
      ),
    );
  }

  void _jike() {
    print("开始向极客时间请求数据。。。。。。。。。。。。。。");
    getHttp().then((val) {
      setState(() {
        showText = val["training"].toString();
      });
    });
  }

  Future getHttp() async {
    try {
      Response response;
      Dio dio = Dio();
      dio.options.headers = httpHeaders;
      response = await dio.get("https://static001.geekbang.org/static/time/menu/sub_data.json?v=28885207");
      print(response);

      return response.data;
    } catch (e) {
      print(e);
    }
  }
}