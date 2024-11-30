import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();
  String showText = "欢迎您来到美好人间高级会所";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: const Text("美好人间")),
        body: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: typeController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  labelText: "美女类型",
                  helperText: "请输入你喜欢的类型",
                ),
                autofocus: false,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showText = "您选择了：${typeController.text}";
                  });
                },
                child: const Text("选择完毕"),
              ),
              Text(
                showText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
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
      showDialog(context: context, builder: (context)=>const AlertDialog(title: Text("美女类型不能为空")));
    } else {
      getHttp(typeController.text.toString()).then((val){
        setState(() {
          showText = val["data"]["name"];
        });
      });
    }
  }
  
  
  
  

  Future getHttp(String Typetext) async {
    try {
      Response response;
      final dio = Dio();
      
      var data = {"name":Typetext};
      response = await dio.get("https://dart.dev",
      queryParameters: data
      );

      return response.data;
    } catch(e){
return print(e);
    }
  }




}
