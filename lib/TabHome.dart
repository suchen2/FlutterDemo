import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
	int _counter = 0;
	TabController _tabController;// 顶部tab控制器
	int _currentTopTabIndex = 0;
	
	
	/*
   * 首页顶部tab
   */
	static const List<Tab> _homeTopTabList = <Tab>[
		Tab(text: '音乐', icon: Icon(Icons.music_note)),
		Tab(text: '体育', icon: Icon(Icons.directions_run)),
		Tab(text: '天气', icon: Icon(Icons.cloud_queue)),
		Tab(text: '科技', icon: Icon(Icons.toys))
	];
	
	/*
   * 计算count
   */
	void _incrementCounter() {
		setState(() {
			_counter++;
		});
	}
	
	/// 初始化状态
	@override
	void initState() {
		super.initState();
		// TabController的滚动事件会触发一次监听, 点击事件会触发两次监听(一次是正常触发,一次是tab的动画触发)
		_tabController = TabController(length: _homeTopTabList.length, vsync: this);
		_tabController.addListener(() async{
			
			if(_tabController.index == _tabController.animation.value) {
				setState(() {
					_currentTopTabIndex = _tabController.index;
				});
				
				print('index = ${_tabController.index}');
			}
		});
	}
	
	/// 注销状态
	@override
	void dispose() {
		_tabController.dispose();
		super.dispose();
	}
	
	// tab切换
//  child: _tabList.elementAt(_currentTabIndex),
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: TabBar(
					tabs: _homeTopTabList,
					controller: _tabController,
					labelColor: Colors.lightBlue,
					indicatorColor: Colors.cyan[600],
				),
			
			body: TabBarView(
				controller: _tabController,
				children: <Widget>[
					_tabMusic(context),
					_tabSport(context),
					_tabWeather(context),
					_tabWeather(context)
				],
			),
		);
	}
	
	/*
   * 首页顶部tab music
   */
	Center _tabMusic(BuildContext context){
		return Center(
			child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Image.network(
						"https://pics2.baidu.com/feed/562c11dfa9ec8a13a6db9bb37abd4e8aa2ecc0e1.jpeg?token=5ad4dfb7aa822337a580a75db88f33f4&s=D7BD3CC49B1E6AC40D9E387303000091",
						fit: BoxFit.fill,
					),
					Container(
						padding: EdgeInsets.all(10),
						child: Column(
							children: <Widget>[
								Text(
									'You have pushed the button this many times:',
									style: TextStyle(
										fontSize: 16,
										color: Colors.pink,
										fontStyle: FontStyle.normal,
										fontWeight: FontWeight.bold),
								),
								Text(
									'$_counter',
									style: Theme.of(context).textTheme.display1,
								),
								RaisedButton(
									color: Colors.pink,
									child: Text(
										'跳转FirstPage',
										style: TextStyle(fontSize: 14, color: Colors.white),
									),
									onPressed: () {
//                Navigator.push(context, MaterialPageRoute(builder: (context) => FirstPage()));
										Navigator.pushNamed(context, '/first');
									},
								),
							],
						),
					)
				],
			));
	}
	
	/*
   * 首页顶部tab sport
   */
	Center _tabSport(BuildContext context) {
		return Center(
			child: Text('当前索引$_currentTopTabIndex : ${_homeTopTabList[_currentTopTabIndex].text}')
		);
	}
	
	/*
   * 首页顶部tab weather
   */
	Center _tabWeather(BuildContext context) {
		return Center(
			child: Text('当前索引$_currentTopTabIndex : ${_homeTopTabList[_currentTopTabIndex].text}')
		);
	}
}