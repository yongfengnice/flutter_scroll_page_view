import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nest_page_view/page_view_scroll_utils.dart';
import 'package:flutter_nest_page_view/tar_bat_view_scroll_utils.dart';

class TarBarScrollPage extends StatefulWidget {
  const TarBarScrollPage({Key? key}) : super(key: key);

  @override
  State<TarBarScrollPage> createState() => _TarBarScrollPageState();
}

class _TarBarScrollPageState extends State<TarBarScrollPage>
    with TickerProviderStateMixin {
  late TabController _homeTabController;
  late TabController _mineTabController;
  late PageController _pageController;

  late TarBarViewScrollUtils _homePageViewScrollUtils;
  late TarBarViewScrollUtils _minePageViewScrollUtils;

  @override
  void initState() {
    super.initState();
    _homeTabController = TabController(length: 3, vsync: this);
    _mineTabController = TabController(length: 2, vsync: this);
    _pageController = PageController();

    _homePageViewScrollUtils = TarBarViewScrollUtils(_pageController, _homeTabController);
    _minePageViewScrollUtils = TarBarViewScrollUtils(_pageController, _mineTabController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TarBarView嵌套滑动测试'),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Colors.deepOrangeAccent,
                  child: Text("Home"),
                  onPressed: () {
                    _pageController.jumpToPage(0);
                  },
                ),
                MaterialButton(
                  color: Colors.grey,
                  child: Text("Mine"),
                  onPressed: () {
                    _pageController.jumpToPage(1);
                  },
                ),
              ],
            ),
            Expanded(child: buildPageViewChild(_pageController))
          ],
        ));
  }

  Widget buildHomeTabChild() {
    return Column(
      children: [
        TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _homeTabController,
          tabs: [
            Tab(text: '科技'),
            Tab(text: '军事'),
            Tab(text: '时尚'),
          ],
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            child: TabBarView(
              controller: _homeTabController,
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
              ],
            ),
            onNotification: _homePageViewScrollUtils.handleNotification,
          ),
        ),
      ],
    );
  }

  Widget buildMineTabChild() {
    return Column(
      children: [
        TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _mineTabController,
          tabs: [
            Tab(text: '介绍'),
            Tab(text: '描述'),
          ],
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            child: TabBarView(
              controller: _mineTabController,
              children: [
                Container(
                  color: Colors.green,
                  child: Center(child: Text("介绍")),
                ),
                Container(
                  color: Colors.red,
                  child: Center(child: Text("描述")),
                ),
              ],
            ),
            onNotification: _minePageViewScrollUtils.handleNotification,
          ),
        ),
      ],
    );
  }

  Widget buildPageViewChild(PageController pageController) {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        // _bottomController.animateTo(index);
      },
      children: [
        Container(
          color: Colors.deepOrangeAccent,
          // child: HomePage(_pageController),
          child: buildHomeTabChild(),
        ),
        Container(
          color: Colors.grey,
          child: buildMineTabChild(),
        ),
      ],
    );
  }
}
