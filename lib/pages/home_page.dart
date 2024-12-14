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
              var scrolist = data["data"]["list"] as List<dynamic>;
              var navgatorListlist = data["data"]["list"] as List<dynamic>;
              var adPictureList = data["data"]["list"] as List<dynamic>;
              var firstDic = adPictureList.first;
              String adpicture = firstDic["icon"];

              return Column(
                children: <Widget>[
                  SwiperDiy(swiperDateList: scrolist),
                  TopNavgator(navigatorList: navgatorListlist),
                  AdBanner(adPicture: adpicture),
                ],
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

    if (this.swiperDateList.length > 10) {
      this.swiperDateList.removeRange(10, this.swiperDateList.length);
    }

    return Container(
      height: ScreenUtil().setHeight(400),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          print(swiperDateList);
          return Image.network("${swiperDateList[index]["icon"]}",
              fit: BoxFit.fill);
        },
        itemCount: swiperDateList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//金刚区域
class TopNavgator extends StatelessWidget {
  final List navigatorList;
  TopNavgator({Key? key, required this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext content, item) {
    return InkWell(
      onTap: () {
        print("点击了导航");
      },
      child: Column(
        children: <Widget>[
          Image.network(item["icon"], width: ScreenUtil().setWidth(95)),
          Text(item["name"])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //对数据进行截取，只保留10个
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }

    return Container(
        height: ScreenUtil().setHeight(260),
        padding: EdgeInsets.all(5),
        child: GridView.count(
          crossAxisCount: 5,
          padding: EdgeInsets.all(5),
          children: navigatorList.map((item) {
            return _gridViewItemUI(context, item);
          }).toList(),
        ));
  }
}

//广告
class AdBanner extends StatelessWidget {
  final String adPicture;
  AdBanner({Key? key, required this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(80),
      width: ScreenUtil().setWidth(750),
      child: Image.network(
        adPicture,
        fit: BoxFit.cover,
      ),
    );
  }
}
