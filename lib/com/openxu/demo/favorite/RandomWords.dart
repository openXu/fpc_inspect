import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

/**
 * StatelessWidget：是不可变的, 这意味着它们的属性不能改变 - 所有的值都是最终的.
 * StatefulWidget：持有的状态可能在widget生命周期中发生变化.
 *
 * 为什么StatefulWidget和State是单独的对象?
 * 在Flutter中，这两种类型的对象具有不同的生命周期：
 * Widget是临时对象，用于构建当前状态下的应用程序，
 * 而State对象在多次调用build()之间保持不变，允许它们记住信息(状态)。
 *
 */


class RandomWords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Startup Name Generator"),
        //为AppBar添加一个列表图标。当用户点击列表图标时，包含收藏夹的新路由页面入栈显示。
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.list),
            onPressed: () {
              Navigator.of(context).push(RandomWordsState.getSavedRoute());
            },
          ),
        ],
      ),
      body: new RandomWordsList(),
    );
  }

}


class RandomWordsList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWordsList> {
  //列表以保存建议的单词对。在Dart语言中使用_前缀标识符，会强制其变成私有的。
  final _suggestions = <WordPair>[];
  //这个集合存储用户喜欢（收藏）的单词对。Set比List更合适，因为Set中不允许重复的值。
  static final _saved = new Set<WordPair>();
  //添加一个biggerFont变量来增大字体大小
  static final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    // return new Text(wordPair.asPascalCase);
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
        // 在偶数行，该函数会为单词对添加一个ListTile row.
        // 在奇数行，该函数会添加一个分割线widget，来分隔相邻的词对。
        // 注意，在小屏幕上，分割线看起来可能比较吃力。
        itemBuilder: (context, i) {
          // 在每一列之前，添加一个1像素高的分隔线widget
          if (i.isOdd) return new Divider();

          // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
          // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
          final index = i ~/ 2;
          // 如果是建议列表中最后一个单词对
          if (index >= _suggestions.length) {
            // ...接着再生成10个单词对，然后添加到建议列表
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      //列表平铺的主要内容
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      //标题后显示的小部件。
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      //当用户轻触此列表平铺时调用
      onTap: (){
        //在Flutter的响应式风格的框架中，调用setState() 会为State对象触发build()方法，从而导致对UI的更新
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  static MaterialPageRoute getSavedRoute() {
    return new MaterialPageRoute(
      builder: (context) {
        final tiles = _saved.map(
              (pair) {
            return new ListTile(
              title: new Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
            );
          },
        );
        final divided = ListTile
            .divideTiles(
          context: context,
          tiles: tiles,
        ).toList();

        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Saved Suggestions'),
          ),
          body: new ListView(children: divided),
        );
      },
    );
  }
/*  static void _pushSaved() {
    //使路由入栈（以后路由入栈均指推入到导航管理器的栈）
    Navigator.of(context).push(
      //新页面的内容在在MaterialPageRoute的builder属性中构建，builder是一个匿名函数。
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
                (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),

    );
  }*/




}
