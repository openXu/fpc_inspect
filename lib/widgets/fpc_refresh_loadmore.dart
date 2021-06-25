import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:fpc_inspect/config/Global.dart';

/// 自定义 下拉刷新、上拉加载更多 的列表页
///


///用于构建列表item控件的函数，根据数据t绑定数据到控件上
typedef ListItemBuilder<D> = Widget Function(BuildContext context, D t);
///用于加载数据的函数，如果不需要分页忽略参数。
///注意：返回值为null表示网络错误
///     返回空数组表示请求数据成功，但是没有数据
typedef ListRequestData<D> = Future<List<D>?> Function(int pageNo, int pageSize);

class RefreshLoadmore<T> extends StatefulWidget {

  // /// callback function on pull down to refresh | 下拉刷新时的回调函数，默认为null不能下拉刷新
  // final ListRequestData<T> onRefresh;
  // /// callback function on pull up to load more data | 上拉以加载更多数据的回调函数，默认为null不能加载更多
  // final ListRequestData<T>? onLoadmore;

  ///分页加载数据，使用时不需要维护分页，只需要获取数据后返回即可，_RefreshLoadmoreState中会自动维护分页
  final ListRequestData<T> onLoadData;
  ///item布局构造器
  final ListItemBuilder<T> itemBuilder;
  ///是否可以下拉刷新（默认true）
  final bool refreshAble;
  ///是否支持加载更多（默认true）
  final bool loadmoreAble;
  ///起始页索引（默认为1，可传递其他值，后端接口决定）
  final int firstPage;
  ///每页加载数量（默认30）
  final int pageSize;
  ///分割线
  final Widget divider;
  /// [noMoreText] text style | [noMoreText]的文字样式
  final TextStyle noMoreTextStyle;

  const RefreshLoadmore(
    {
    Key? key,
    required this.itemBuilder,
    required this.onLoadData,
    this.divider = const Divider(),    //默认取自ThemeData的dividerTheme
    this.firstPage = 1,
    this.pageSize = 30,
    this.refreshAble = true,
    this.loadmoreAble = true,
    this.noMoreTextStyle = FPCStyle.middleText,
  }) : super(key: key);
  @override
  _RefreshLoadmoreState<T> createState() => _RefreshLoadmoreState<T>();
}

class _RefreshLoadmoreState<D> extends State<RefreshLoadmore<D>> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  //滚动控制器
  late ScrollController _scrollController;
  ///是否正在刷新数据
  bool _isRefreshing = false;
  ///是否正在加载更多
  bool _isLoading = false;
  ///是否是空页面(第一次进入页面加载数据为空:null网络错误、空数组无数据)
  bool _emptyPage = true;
  ///空页面提示语
  String _emptyPageStr = "加载中...";
  String _endHintStr = "";

  /// 是否为最后一页，如果为true，则无法加载更多
  bool _isLastPage = false;

  ///当前页面
  late int _page;
  var _datas = <D>[];

  @override
  void initState() {
    super.initState();
    _page = widget.firstPage;

    _scrollController = ScrollController();
    ///滚动监听
    _scrollController.addListener(() async {
      // print("1当前滚动像素值${_scrollController.position.pixels}");
      // print("1控件可以滚动的最大范围${_scrollController.position.maxScrollExtent}");
      //当前位置的像素值
      if (_scrollController.position.pixels >=
          //控件可以滚动的最大范围
          _scrollController.position.maxScrollExtent) {
        // print("=====滚动到最后了，检查是否需要加载更多$_isRefreshing  $_isLoading");
        if (_isRefreshing || _isLoading)
          return;
        setState(() {
          _isLoading = true;
        });
        ///触发加载更多
        if (widget.loadmoreAble && !_isLastPage) {
          _page ++;
          _endHintStr = "";
          List<D>? moreList = await widget.onLoadData(_page, widget.pageSize);
          if(moreList!=null){
            if(moreList.length < widget.pageSize){
              _isLastPage = true; //没有更多数据了
              _endHintStr = "没有更多数据了";
            }
            _datas.addAll(moreList);
          }else{
            _endHintStr = "请求失败，请检查网络";
          }
        }
        setState(() {
          _isLoading = false;
        });
      }
    });

    _firstLoad();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_emptyPage){    ///1 空页面展示内容
      if(_isRefreshing){
        return Center(  ///1.1 空页面正在加载，在页面中间显示加载圈
          child: CupertinoActivityIndicator(),
        );
      }else{
        return GestureDetector(  ///1.2 空页面无数据，点击重新加载
          onTap: ()=>_firstLoad(),
          child: Center(
            child: Text(_emptyPageStr),
          ),
        );
      }
    }else{
      if (!widget.refreshAble) {
        //一个Material风格的滚动指示器（滚动条），如果要给可滚动组件添加滚动条，只需将Scrollbar作为可滚动组件的任意一个父级组件即可
        return Scrollbar(child: _getMainListView());
      }else{
        return RefreshIndicator(
          key: _refreshIndicatorKey,
          ///触发刷新
          onRefresh: () async {
            await _firstLoad();
          },
          child: _getMainListView(),
        );
      }
    }
  }

  ///第一次 或者 下拉刷新时触发加载数据
  _firstLoad() async {
    // print("=====下拉刷新，检查是否需要刷新$_isRefreshing  $_isLoading");
    if (_isRefreshing || _isLoading)
      return;
    _isRefreshing = true;
    _isLastPage = false;
    _endHintStr = "";
    // if(_emptyPage)    //空页面刷新页面（加载中）
      setState(() {
      });

    _page = widget.firstPage;
    // if(!Global.isRelease) {//TODO debug模式下延迟看效果
    //   await Future.delayed(Duration(seconds: 1));
    //   print("等待1s");
    // }
    List<D>? dataList = await widget.onLoadData(_page, widget.pageSize);
    print("刷新加载数据：$dataList");

    if(dataList == null){   //onLoadData返回null，认为是网络请求失败
      _emptyPageStr = "网络请求失败，点击重试";
    }else{
      _datas.clear();
      if(dataList.length>0){
        _emptyPage = false;
      }else{
        _emptyPage = true;
        _emptyPageStr = "暂无数据，点击重试";
      }
      _datas.addAll(dataList);
    }

    setState((){
      _datas = List.of(_datas);
      _isRefreshing = false;
    });
  }

  Widget _getMainListView(){
    //通过ListView.builder()构造函数创建的ListView是支持基于Sliver的懒加载模型的
    return ListView.separated(   //separated比builder多了一个separatorBuilder参数：分割组件生成器
        scrollDirection : Axis.vertical,   //垂直滚动
        // physics: BouncingScrollPhysics(),  //ClampingScrollPhysics：Android下微光效果。 BouncingScrollPhysics：iOS下弹性效果。
        /// Solve the problem that there are too few items to pull down and refresh | 解决item太少，无法下拉刷新的问题
        physics: AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        ///正在下拉刷新或者不支持分页加载的情况下item数量就是数据数量
        itemCount: (_isRefreshing || !widget.loadmoreAble) ? _datas.length : _datas.length+1,
        //分割线
        separatorBuilder:(BuildContext context, int index) {
          return widget.divider;
        },
        //item生成
        itemBuilder : (context, index){
          return index < _datas.length?
          /// ★★★ widget.itemBuilder抛异常：type '(BuildContext, CheckTask) => Text' is not a subtype of type '(BuildContext, dynamic) => Widget'
          /// 原因：RefreshLoadmore 和 _RefreshLoadmoreState两个类的泛型必须在定义时就绑定：
          /// class _RefreshLoadmoreState<D> extends State<RefreshLoadmore<D>>
          ///
          /// 之所以报错是因为写成了 class _RefreshLoadmoreState<D> extends State<RefreshLoadmore>，没有为RefreshLoadmore打上泛型标志
          ///
          /// 所以相对于_RefreshLoadmoreState来说，RefreshLoadmore的泛型可以是任意类型dynamic，它的成员itemBuilder的类型也就是 BuildContext, dynamic) => Widget
          ///
          widget.itemBuilder(context, _datas[index]):
            _getLoadMoreView();
        },

    );
  }

  Widget _getLoadMoreView(){
    return ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          height: 50,
        ),
        child:Center(
          child: _isLoading
              ? CupertinoActivityIndicator()
          // ? CircularProgressIndicator(strokeWidth: 1.0)
              : Text(_endHintStr,
              style: widget.noMoreTextStyle
          ),
        )
    );
  }


}