import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shop/service/service_method.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homepageContent = "正在获取数据";

  @override
  void initState() {
    getHomepageContent().then((val) {
      setState(() {
        homepageContent = val.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: const Text("极客时间")),
        body: SingleChildScrollView(
          child: Text(homepageContent),
        ),
      ),
    );
  }
}
