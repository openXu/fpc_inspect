import 'dart:ui';

import 'package:flutter/material.dart';

///颜色
class FPCColors {
  static const int primaryIntValue = 0xffdb4527;

  static const MaterialColor primarySwatch = const MaterialColor(
    primaryIntValue,
    const <int, Color>{
      50: const Color(primaryIntValue),
      100: const Color(primaryIntValue),
      200: const Color(primaryIntValue),
      300: const Color(primaryIntValue),
      400: const Color(primaryIntValue),
      500: const Color(primaryIntValue),
      600: const Color(primaryIntValue),
      700: const Color(primaryIntValue),
      800: const Color(primaryIntValue),
      900: const Color(primaryIntValue),
    },
  );

  // accentColor:Color(int.parse("db4527",radix:16)|0xFF000000), //次级色，决定大多数Widget的颜色，如进度条、开关等
  // dividerColor : Color(int.parse("e6e6e6",radix:16)).withAlpha(255), //分割线颜色
  ///app整体颜色规范
  static const Color colorPrimary = Color(0xffdb4527);//主色，决定导航栏颜色
  static const Color colorAccent = Color(0xfff15b6c);//次级色，决定大多数Widget的颜色，如进度条、开关等
  static const Color mainBackgroundColor = Color(0xfff7f7f7);
  // <!--线条色-->
  static const Color colorLine = Color(0xfff7f7f7);

  // <!--字体颜色-->
  static const Color mainTextColor = Color(0xff5E5E5E);
  static const Color subTextColor = Color(0xff939393);
  static const Color subLightTextColor = Color(0xffcecece);

  // <!--辅助色-->
  static const Color white = Color(0xffffffff);
  static const Color red = Color(0xffd94630);
  static const Color yellow = Color(0xfff28d02);
  static const Color green = Color(0xff66b61d);
  static const Color blue = Color(0xff5da3f4);
  static const Color grey = Color(0xffF2F2F2);
  static const Color orange = Color(0xffDB4528);
  static const Color trance = Color(0xffDB4528);


/*  static const Color colorAccent = Color(0xffdb4527);
  <!--Window的背景色-->
  static const Color windowBackground = Color(0xfff7f7f7);
  static const Color main_style = Color(0xfff7f7f7);    <!--通用背景色-->
  <!--主要的文字颜色，一般TextView的文字都是这个颜色-->
  static const Color textColorPrimary = Color(0xff1B1B1D);
  <!--辅助的文字颜色，一般比textColorPrimary的颜色弱一点，用于一些弱化的表示-->
  static const Color textColorSecondary = Color(0xff6B7178);
  <!--内容区域按下时的背景色-->
  static const Color colorRipple = Color(0xffFFCBC3);
  static const Color white_press_bg = Color(0xff16000000);*/

}

class FPCSize{
  ///文本大小
  static const tsTitle = 16.0;   //标题
  static const tsBig = 15.0;
  static const tsNormal = 14.0;  //正常
  static const tsMiddle = 12.0;  //中等
  static const tsSmall = 10.0;   //小字

  static const pageSides = 12.0;   //页面两边的间隙
  static const itemSides = 8.0;   //item上下间隙
  static const itemRowSpace = 6.0;   //item中的行间距
  static const textRowSpace = 5.0;   //多行文本行间距
  static const lineHeight = 1.0;   //分割线
  static const lineSpace = 7.0;    //分割条

  ///xml自动解析表单相关
  static const formItemHight = 40.0;   //表单条目高度
  static const formTextSize = 13.0;   //表单字体
  static const formSides = 10.0;   //表单条目左右边距
  static const formContentSpace = 8.0;   //表单条目中控件间隔

}

///文本样式
class FPCStyle {
  ///标题文本样式，不需要单独设置，ThemeData.textTheme.headline6统一设置
  static const titleText = TextStyle(
    // color: primaryColor.computeLuminance() < 0.5 ? Colors.white : Colors.black, FPCColors.subTextColor,
    // color: Colors.white,
    fontSize: FPCSize.tsTitle,
  );
  ///程序中所有的文本样式都应该基于这三种，如果有需要特殊处理的请使用如下方式(扩展父主题)：
  /// style: FPCStyle.normalText.copyWith(
  ///          fontSize: FPCSize.tsBig
  ///        )
  ///默认文本样式，不需要单独设置，ThemeData.textTheme.bodyText2统一设置
  static const normalText = TextStyle(
    color: FPCColors.mainTextColor,
    fontSize: FPCSize.tsNormal,
  );
  static const middleText = TextStyle(
    color: FPCColors.subTextColor,
    fontSize:FPCSize.tsMiddle,
  );
  static const smallText = TextStyle(
    color: FPCColors.subTextColor,
    fontSize: FPCSize.tsSmall,
  );


}

class FPCICons {
  static const String FONT_FAMILY = 'fpcIconFont';

  static const String DEFAULT_USER_ICON = 'static/images/logo.png';
  static const String DEFAULT_IMAGE = 'static/images/default_img.png';
  static const String DEFAULT_REMOTE_PIC =
      'http://img.cdn.guoshuyu.cn/gsy_github_app_logo.png';

  static const IconData HOME =
      const IconData(0xe624, fontFamily: FPCICons.FONT_FAMILY);
  static const IconData MORE =
      const IconData(0xe674, fontFamily: FPCICons.FONT_FAMILY);
  static const IconData SEARCH =
      const IconData(0xe61c, fontFamily: FPCICons.FONT_FAMILY);

  static const IconData MAIN_DT =
      const IconData(0xe684, fontFamily: FPCICons.FONT_FAMILY);
  static const IconData MAIN_QS =
      const IconData(0xe818, fontFamily: FPCICons.FONT_FAMILY);
  static const IconData MAIN_MY =
      const IconData(0xe6d0, fontFamily: FPCICons.FONT_FAMILY);
  static const IconData MAIN_SEARCH =
      const IconData(0xe61c, fontFamily: FPCICons.FONT_FAMILY);

  static const IconData LOGIN_USER =
      const IconData(0xe666, fontFamily: FPCICons.FONT_FAMILY);
  static const IconData LOGIN_PW =
      const IconData(0xe60e, fontFamily: FPCICons.FONT_FAMILY);

  static const IconData REPOS_ITEM_USER =
      const IconData(0xe63e, fontFamily: FPCICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_STAR =
      const IconData(0xe643, fontFamily: FPCICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_FORK =
      const IconData(0xe67e, fontFamily: FPCICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_ISSUE =
      const IconData(0xe661, fontFamily: FPCICons.FONT_FAMILY);

  static const IconData REPOS_ITEM_STARED =
      const IconData(0xe698, fontFamily: FPCICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_WATCH =
      const IconData(0xe681, fontFamily: FPCICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_WATCHED =
      const IconData(0xe629, fontFamily: FPCICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_DIR = Icons.folder;
  static const IconData REPOS_ITEM_FILE =
      const IconData(0xea77, fontFamily: FPCICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_NEXT =
      const IconData(0xe610, fontFamily: FPCICons.FONT_FAMILY);

  static const IconData USER_ITEM_COMPANY =
      const IconData(0xe63e, fontFamily: FPCICons.FONT_FAMILY);
  static const IconData USER_ITEM_LOCATION =
      const IconData(0xe7e6, fontFamily: FPCICons.FONT_FAMILY);
  static const IconData USER_ITEM_LINK =
      const IconData(0xe670, fontFamily: FPCICons.FONT_FAMILY);
  static const IconData USER_NOTIFY =
      const IconData(0xe600, fontFamily: FPCICons.FONT_FAMILY);

  static const IconData ISSUE_ITEM_ISSUE =
      const IconData(0xe661, fontFamily: FPCICons.FONT_FAMILY);
  static const IconData ISSUE_ITEM_COMMENT =
      const IconData(0xe6ba, fontFamily: FPCICons.FONT_FAMILY);
  static const IconData ISSUE_ITEM_ADD =
      const IconData(0xe662, fontFamily: FPCICons.FONT_FAMILY);

  static const IconData ISSUE_EDIT_H1 = Icons.filter_1;
  static const IconData ISSUE_EDIT_H2 = Icons.filter_2;
  static const IconData ISSUE_EDIT_H3 = Icons.filter_3;
  static const IconData ISSUE_EDIT_BOLD = Icons.format_bold;
  static const IconData ISSUE_EDIT_ITALIC = Icons.format_italic;
  static const IconData ISSUE_EDIT_QUOTE = Icons.format_quote;
  static const IconData ISSUE_EDIT_CODE = Icons.format_shapes;
  static const IconData ISSUE_EDIT_LINK = Icons.insert_link;

  static const IconData NOTIFY_ALL_READ =
      const IconData(0xe62f, fontFamily: FPCICons.FONT_FAMILY);

  static const IconData PUSH_ITEM_EDIT = Icons.mode_edit;
  static const IconData PUSH_ITEM_ADD = Icons.add_box;
  static const IconData PUSH_ITEM_MIN = Icons.indeterminate_check_box;
}
