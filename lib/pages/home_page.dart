import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = "正在获取数据";

  @override
  void initState() {
    getHomePageContent().then((val) {
      setState(() {
        homePageContent = val.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: const Text("极客时间")),
        body: FutureBuilder(
          //解决异步请求，不需要动态改变UI
          future: getHomePageContent(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // 解析数据
              var data = snapshot.data as Map<String, dynamic>;
              var list = data["data"]["list"] as List<dynamic>;
              return Column(
                children: [SwiperDiy(swiperDateList: list)],
              );
            } else {
              return Center(child: Text("加载中......"));
            }
          },
        ),
      ),
    );
  }
}

//首页轮播图组件
class SwiperDiy extends StatelessWidget {
  final List swiperDateList;

  SwiperDiy({Key? key, required this.swiperDateList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("设备像素密度:${ScreenUtil().pixelRatio}");
    print("设备的高:${ScreenUtil().scaleHeight}");
    print("设备的宽:${ScreenUtil().scaleWidth}");

    return Container(
      height: ScreenUtil().setHeight(400),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          print(swiperDateList);
          return Image.network("${swiperDateList[index]["base_cover"]}",
              fit: BoxFit.fill);
        },
        itemCount: swiperDateList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
