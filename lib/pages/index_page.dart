import 'package:flutter/cupertino.dart'; //ios的风格
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'member_page.dart';
import 'cart_page.dart';
import 'people_search.dart';
import 'weizao_headerhttp.dart';


class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        label: "首页"
    ),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        label: "分类"
    ),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart),
        label: "购物车"
    ),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled),
        label: "会员中心"
    ),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.info),
        label: "人物查找"
    ),
  ];


  List<Widget> get tabBodies =>
      [
        const HomePage(),
        const CategoryPage(),
        const CartPage(),
        // const MemberPage(),
        PeopleSearch(),
        const WeizaoHttpPage()
      ];


  int currentIndex = 0;
  var currentpage;

  @override
  void initState() {
    currentpage = tabBodies[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 245, 245, 1),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentpage = tabBodies[currentIndex];
          });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      )
    );
  }


}