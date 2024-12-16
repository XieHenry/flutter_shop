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
              String adpicture = adPictureList.first["icon"];

              String leaderImage = adPictureList[2]["icon"];
              String leadPhone = "18611696476";

              var recommendList = data["data"]["list"] as List<dynamic>;

              return SingleChildScrollView( //避免超出屏幕
                child: Column(
                  children: <Widget>[
                    SwiperDiy(swiperDateList: scrolist),
                    TopNavgator(navigatorList: navgatorListlist),
                    AdBanner(adPicture: adpicture),
                    LeaderPhone(
                        leaderImage: leaderImage, leaderPhone: leadPhone),
                    Recommend(recommonedList: recommendList),
                  ],
                ),
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
      height: ScreenUtil().setHeight(300),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          print(swiperDateList);
          return Image.network("${swiperDateList[index]["icon"]}",
              fit: BoxFit.fill);
        },
        itemCount: swiperDateList.length,
        pagination: const SwiperPagination(),
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
      height: ScreenUtil().setHeight(60),
      width: ScreenUtil().setWidth(750),
      child: Image.network(
        adPicture,
        fit: BoxFit.cover,
      ),
    );
  }
}

class LeaderPhone extends StatelessWidget {
  final String leaderImage; //店长图片
  final String leaderPhone; //店长电话

  LeaderPhone({Key? key, required this.leaderImage, required this.leaderPhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    padding:
    EdgeInsets.all(5);
    return Container(
      height: ScreenUtil().setHeight(100),
      width: ScreenUtil().setWidth(750),
      child: InkWell(
        onTap: _launchUrl,
        child: Image.network(leaderImage, fit: BoxFit.cover),
      ),
    );
  }

  void _launchUrl() async {
    print("打印手机号：${leaderPhone}");
  }
}

//商品推荐
class Recommend extends StatelessWidget {
  final List recommonedList;
  Recommend({Key? key, required this.recommonedList}) : super(key: key);

  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(10, 2, 0, 5),
      decoration: const BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
      child: const Text("商品推荐", style: TextStyle(color: Colors.pink)),
    );
  }

  //商品单独项方法
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(750 / 3),
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Image.network(recommonedList[index]["icon"]),
            Text("¥${recommonedList[index]["name"]}"),
            Text(
              "¥${recommonedList[index]["name"]}",
              style: const TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  //横向列表
  Widget _recommedList() {
    return Container(
      height: ScreenUtil().setHeight(300),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommonedList.length,
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[_titleWidget(), _recommedList()],
      ),
    );
  }
}
