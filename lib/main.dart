import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ScreenUtil.init(context, designSize: const Size(750, 1334));
    return  MaterialApp(
      title: "百姓生活+",
      debugShowCheckedModeBanner: false, //去除Debug
      theme: ThemeData(
        // primaryColor: Colors.pink,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pink, //设置导航栏背景色
          foregroundColor: Colors.white, //设置导航烂文字和图标颜色
        )
      ),
      home: const IndexPage(),
    );
  }
}
