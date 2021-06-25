

import 'package:fpc_inspect/com/openxu/demo/hello/HelloFlutter.dart';
import 'package:fpc_inspect/com/openxu/demo/page/anim_set.dart';
import 'package:fpc_inspect/com/openxu/demo/page/anim_widget.dart';
import 'package:fpc_inspect/com/openxu/demo/page/fade_trandition.dart';

import 'favorite/RandomWords.dart';
import 'my_app.dart';

class PageRouter{

  // static const String app = '/';
  static const String helloFlutter = '/hello_flutter';
  static const String randomWords = '/random_words';
  static const String shopList = '/shop_list';
  static const String animFade = '/anim_fade';
  static const String animWidget = '/anim_widget';
  static const String animSet = '/anim_set';

  static var myRoutes = {
    // app:(context)=>new MyApp(),
    helloFlutter:(context)=>HelloFlutter(),
    randomWords:(context)=>new RandomWords(),
    // shopList:(context)=>ShoppingList(),
    animFade:(context)=>new FadeTradition(),
    animWidget:(context)=>new AnimWidget(),
    animSet:(context)=>new AnimSet(),
  };

}
