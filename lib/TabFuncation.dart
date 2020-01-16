import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class FunctionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FunctionPageState();
}

class _FunctionPageState extends State<FunctionPage>{
  List<String> _list = <String>[''];

  /// 生成单词从列表最后一行插入
  void _loadWords() {
    Future.delayed(Duration(milliseconds: 700)).then((e) {
      _list.insertAll(_list.length - 1,
          generateWordPairs().take(15).map((e) => e.asPascalCase).toList());

      setState(() {});// TODO 不要忘记这里更改状态
    });
  }

  @override
  void initState(){
    super.initState();
    _loadWords();// 加载数据
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {

            if (index == _list.length - 1) {
              if (_list.length - 1 < 80) {
                _loadWords(); // 在显示loading时，加载数据

                // 最后一个显示加载对话框
                return Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: Text('没有更多数据了...',style: TextStyle(color: Colors.green),),
                );
              }
            }

            // 返回item数据
            return ListTile(
              title: Text(_list[index]),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 1,
              color: Colors.cyan,
            );
          },
          itemCount: _list.length),
    );
  }


}
