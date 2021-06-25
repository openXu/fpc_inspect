# fpc_inspect

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# 工程结构

```xml
fpc_inspect
├── android
├── ios
├── test
├── images     //保存外部图片
├── fonts    //保存Icon文件
├── jsons    //保存Json文件
├── l10n-arb //国际化
└── lib
     ├── common 	//一些工具类，如通用方法类、网络接口类、保存全局变量的静态类等
     ├── l10n    	//国际化相关的类都在此目录下
     ├── models 	//Json文件对应的Dart Model类会在此目录下
     ├── states 	//保存APP中需要跨组件共享的状态类
     ├── pages 	    //存放所有路由页面类
     ├── widgets    //APP内封装的一些Widget组件都在该目录下
     
```

# Json转Dart

## 手动序列化

可以通过`dart:convert`中内置的JSON解码器`json.decode()` 将JSON字符串转为`List`或`Map`，然后通过字符串形式的key获取内容，容易出错，小项目可以尝试:

```dart
//一个JSON格式的用户列表字符串
String jsonStr='[{"name":"Jack"},{"name":"Rose"}]';
//将JSON字符串转为Dart对象(此处是List)
List items=json.decode(jsonStr);
//输出第一个用户的姓名
print(items[0]["name"]);

jsonStr='''{
  "name": "John Smith",
  "email": "john@example.com"
}'''
Map<String, dynamic> user = json.decode(json);
print('Howdy, ${user['name']}!');
print('We sent the verification link to ${user['email']}.');
```

## 自动序列化

Flutter中没有`GSON / Jackson / Moshi`库（Flutter中禁用反射）。
可以使用json_serializable package包，它是一个自动化的源代码生成器，原理还是手动序列化，但是可以为我们生成JSON序列化模板。

**添加依赖**

```xml
dependencies:
  json_annotation: 4.0.0

dev_dependencies:
  build_runner: ^1.11.5
  json_serializable: 4.0.2
```

**根据json编写model类**

```dart
import 'package:json_annotation/json_annotation.dart';
// User.g.dart 将在我们运行生成命令后自动生成，注意User名称必须和类名一样
part 'User.g.dart';
///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class User{
  //下面内容是根据json写字段
  User(this.name, this.email);
  String name;
  String email;
  //别名
  @JsonKey(name: 'registration_date_millis')
  int registrationDateMillis;
  //不同的类使用不同的mixin即可
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

**生成xxx.g.dart**

在Terminal中项目根目录下运行`flutter packages pub run build_runner build --delete-conflicting-outputs`
持续生成：`flutter packages pub run build_runner watch`

## 根据json自动生成model类

[json_model](https://github.com/flutterchina/json_model/blob/master/README-ZH.md)

```xml
dev_dependencies: 
  json_model: 0.0.2
  build_runner: ^1.11.5
  json_serializable: 4.0.2
```

在jsons文件夹中创建xxx.json文件：
```xml
{
  "name":"wendux",
  "father":"$user", //★ 可以通过"$"符号引用其它model类, user为json文件名
  "friends":"$[]user", //★ 通过"$[]"来引用数组
  "keywords":"$[]String", // 同上
  //★ 别名
  "@JsonKey(ignore: true) dynamic":"md",
  "@JsonKey(name: '+1') int": "loved", //将“+1”映射为“loved”
  //★ 导入指定的文件
  "@import":"test_dir/profile.dart",
  "@JsonKey(ignore: true) Profile":"profile",
  
  "age":20
}
```

执行命令生成model:
```xml
flutter packages pub run json_model

//默认的源json文件目录为根目录下名为 "json" 的目录；可以通过 src 参数自定义源json文件目录，例如:
flutter packages pub run json_model src=json_files 
//默认的生成目录为"lib/models"，同样也可以通过dist 参数来自定义输出目录:
flutter packages pub run json_model src=json_files  dist=data # 输出目录为 lib/data
```
