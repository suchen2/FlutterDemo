import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' as prefix0;
import 'package:flutter_app/TabBaidu.dart';
import 'package:flutter_app/TabFuncation.dart';
import 'package:toast/toast.dart';
import 'package:flutter_app/TabHome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 不显示状态栏
  prefix0.SystemChrome.setEnabledSystemUIOverlays([]);

  // 沉浸状态栏
  /*SafeArea(top: true,
    child: MaterialApp(
      home: ,
    ),);*/
  
  // 保存上一个 tab 的状态 tab with AutomaticKeepAliveClientMixin
  
  // 设置只允许竖屏
  SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]
  ).then((_){
    runApp(MyApp());
  });
  
//  printList();
}

void printList() {
  var array = [23, 4, 23, 12, 0];

  print("array： $array");
}

//////////////////////////////MyApp///////////////////////////////////////////////////

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: 'Home Page'),
      routes: <String, WidgetBuilder>{
        '/first': (BuildContext context) => FirstPage(),
        '/second': (BuildContext context) => SecondPage(),
      },
    );
  }
}



//////////////////////////////FirstPage///////////////////////////////////////////////////

class FirstPage extends StatefulWidget {
  FirstPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _FirstPageState();
}

/// DefaultTabController (TabBar + TabBarView) 使用 (内部还是TabController实现)
class _FirstPageState extends State<FirstPage> {
  final List<Tab> myTabs = <Tab>[
    Tab(text: '全部订单'),
    Tab(text: '已完成'),
    Tab(text: '未完成')
  ];
//    Toast.show("我是FirstPage !",context, duration: 1000);

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('FirstPage'),
          bottom: TabBar(
            tabs: myTabs
          ),
        ),
        body: TabBarView(
            children: <Widget>[
        
              /// 全部订单
              Center(
//              padding: EdgeInsets.all(10),
                  child: RaisedButton(
                      child: Text('跳转SecondPage'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/second');
                      }
                  )
              ),
        
              /// 已完成订单
              Center(child: Text('已完成')),
        
              /// 未完成订单
              Center(child: Text('未完成'))
            ]),
      ),
    );
  }
}



//////////////////////////////HomePage///////////////////////////////////////////////////

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}
 
 /*
  * 首页
  * 1. BottomNavigation 使用
  * 2. Drawer 使用
  * 3. App Bar 使用
  * 4. TabController (TabBar + TabBarView) 使用 -> 实现 SingleTickerProviderStateMixin
  * 5. FloatingActionButton 使用
  */
class _MainPageState extends State<MainPage>{
  int _currentBottomTabIndex = 0;

  static  List<Widget> _mainPageList = <Widget>[
    new HomePage(),
    new FunctionPage(),
    new BaiduPage()
  ];
  
  /*
   * 底部tab
   */
  static const List<BottomNavigationBarItem> _homeBottomTabList = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Home')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.music_note),
      title: Text('Funcation')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.pets),
      title: Text('Baidu')
    )
  ];
  
 
  /*
   * 底部Tab选择
   */
  void _onItemTapped(int index) {
    setState(() {
      _currentBottomTabIndex = index;
      
     /* PageView(children: <Widget>[
//        _mainPageList[_currentBottomTabIndex]
        HomePage(),
        FunctionPage(),
        BaiduPage()
      ]
      );*/
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),

          // Toolbar logo
//        leading: FlutterLogo(colors: Colors.lightGreen),

          // Toolbar overflow menu
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Toast.show('分享此APP', context);
              },
            )
          ],
        ),
        
        body: _mainPageList[_currentBottomTabIndex],

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: _drawerViewList,
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          selectedItemColor: Colors.lightBlue,
          currentIndex: _currentBottomTabIndex,
          items: _homeBottomTabList,
        ),
      );
  }
  
  /*
   * drawerView list data
   */
  List<Widget> get _drawerViewList {
    return <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text('柏占彬'),
              accountEmail: Text('bzb2419@163.com'),
            currentAccountPicture: CircleAvatar(child: Text('Su2')),
          ),
          
          ListTile(
            leading: Icon(Icons.phone_android),
            title: Text('OnePlus 6T')
          ),
          
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('18516694287')
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text('中国重庆市梁平区')
          ),

          ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              subtitle: Column(
                  children: <Widget>[
                    Text('Android'),
                    Text('Java'),
                    Text('Kotlin'),
                    Text('Flutter')
                  ],
                ),
          )
        ];
  }
  
}



//////////////////////////////SecondPage///////////////////////////////////////////////////
class SecondPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SecondPage')),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: RaisedButton(
          child: Text('回到首页'),
          onPressed: () {
            Navigator.of(context).pop();
//            Navigator.pop(context, MyHomePage(title: 'Home Page'));
          },
        ),
      ),
    );
  }
}