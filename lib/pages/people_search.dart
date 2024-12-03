import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class PeopleSearch extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<PeopleSearch> {
  TextEditingController typeController = TextEditingController();
  String showText = "欢迎您来到极客直播间";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: const Text("极客学习")),
        //如果越界，可以放入body:SingChildScrollView中进行解决
        body: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: typeController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  labelText: "学习课程类型",
                  helperText: "请输入你喜欢的类型",
                ),
                autofocus: false,
              ),
              ElevatedButton(
                onPressed: _choiceAction,
                child: const Text("选择完毕"),
              ),
              Text(
                showText,
                overflow: TextOverflow.clip,
                maxLines: null,

              ),
            ],
          ),
        ),
      ),
    );
  }



  void _choiceAction(){
    print("开始选择你喜欢的类型");
    if(typeController.text.toString() == "") {
      showDialog(context: context, builder: (context)=>const AlertDialog(title: Text("类型不能为空")));
    } else {
      getHttp(typeController.text.toString()).then((val){
        setState(() {
          showText = val.toString();
        });
      });
    }
  }





  Future getHttp(String Typetext) async {
    try {
      Response response;
      final dio = Dio();

      var data = {"wd":Typetext};
      //暂时没找到合适的网站地址，视频地址出错了
      response = await dio.get("https://www.baidu.com/sugrec?pre=1&p=3&ie=utf-8&json=1&prod=pc&from=pc_web",
          queryParameters: data
      );

      return response.data;
    } catch(e){
      return print(e);
    }
  }

}
