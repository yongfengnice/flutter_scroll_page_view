import 'package:flutter/material.dart';
import 'package:flutter_nest_page_view/page_view_scroll_utils.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        brightness: Brightness.light,
      ),
      home: PageViewScrollPage(),
    ),
  );
}

class PageViewScrollPage extends StatefulWidget {
  @override
  _PageViewScrollPageState createState() => _PageViewScrollPageState();
}

class _PageViewScrollPageState extends State<PageViewScrollPage> with SingleTickerProviderStateMixin {
  PageController _pageController;
  TabController _bottomController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _bottomController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PageView嵌套滑动测试'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                _bottomController.animateTo(index);
              },
              children: [
                Container(
                  color: Colors.white,
                  child: HomePage(_pageController),
                ),
                Container(
                  color: Colors.red,
                  child: Center(child: Text("商场")),
                ),
                Container(
                  color: Colors.cyan,
                  child: Center(child: Text("购物")),
                ),
                Container(
                  color: Colors.orange,
                  child: Center(child: Text("我的")),
                ),
              ],
            ),
          ),
          TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 0.1,
            controller: _bottomController,
            onTap: (index) {
              _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
            },
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: '首页'),
              Tab(text: '商场'),
              Tab(text: '购物'),
              Tab(text: '我的'),
            ],
          )
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final PageController pageController;

  HomePage(this.pageController);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  PageViewScrollUtils _pageViewScrollUtils;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _pageViewScrollUtils = PageViewScrollUtils(widget.pageController, _tabController);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _tabController,
          tabs: [
            Tab(text: '科技'),
            Tab(text: '军事'),
            Tab(text: '时尚'),
            Tab(text: '团购'),
            Tab(text: '健康'),
            Tab(text: '央视'),
          ],
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  color: Colors.green,
                  child: Center(child: Text("科技")),
                ),
                Container(
                  color: Colors.red,
                  child: Center(child: Text("军事")),
                ),
                Container(
                  color: Colors.cyan,
                  child: Center(child: Text("时尚")),
                ),
                Container(
                  color: Colors.orange,
                  child: Center(child: Text("团购")),
                ),
                Container(
                  color: Colors.pink,
                  child: Center(child: Text("健康")),
                ),
                Container(
                  color: Colors.blueAccent,
                  child: Center(child: Text("央视")),
                ),
              ],
            ),
            onNotification: _pageViewScrollUtils.handleNotification,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
