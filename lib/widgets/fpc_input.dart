import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';

/// 自定义输入组件
/// 
/// FpcInput(
///     maxLines:2,          //最大行数，默认1
///     obscureText: !_pwdShow,   //是否隐藏明文
///     hintText:"请输入密码",     //输入框提示文字
///     keyboardType: TextInputType.visiblePassword,   //输入类型，默认输入文本
///     enterType: TextInputAction.send,   //键盘回车键类型，默认next
///     enterAction:(str){  //回车事件
///       _login();
///     },
///     prefixIcon: Icon(Icons.lock,color:Theme.of(context).primaryColor, size: 25),   //输入框前的图案
///     suffixIcon: IconButton(  //后面的图片
///       icon: Icon( _pwdShow ? Icons.visibility_off : Icons.visibility,
///           color:Theme.of(context).primaryColor, size: 25),
///       onPressed: () {
///         setState(() {
///           _pwdShow = !_pwdShow;
///         });
///       },
///     ),
///     controller: _pwdController,    //输入框控制器，可以获取输入框内容
///     validator: (v) {               //校验事件
///       return v!.trim().isNotEmpty ? null : "密码不能为空";
///     }
///    ),
///

class FpcInput extends StatefulWidget {

  final bool enabled;
  final int minLines;   //最大行数（影响高度）
  final int maxLines;   //最大行数（影响高度）
  final bool obscureText;   //密码模式 是否隐藏明文
  final TextInputType keyboardType; //键盘类型   TextInputType.text
  final List<TextInputFormatter>? inputFormatters;   //输入过滤
  final TextInputAction enterType; //回车键类型  TextInputAction.next
  final ValueChanged<String>? enterAction;

  //设置样式
  final InputDecoration? decoration;   //额外设置装饰
  final Color fillColor;
  final EdgeInsetsGeometry contentPadding;
  final TextAlign textAlign;  //水平对齐方式
  final TextAlignVertical textAlignVertical;// 竖直对齐方式
  final TextStyle style;
  final String? hintText;  //提示文字
  final TextStyle hintStyle;
  final Widget? icon;      //输入框之前的图片
  final Widget? prefixIcon;//输入框开始的图片
  final Widget? suffixIcon;//输入框末尾图片
  final BoxConstraints? iconConstraints;  //图片容器大小控制
  /* prefixIconConstraints: BoxConstraints(
              minWidth: 1,
              minHeight: 1,
            ),*/
  final InputBorder border; //边框

  //内容变化监听
  final ValueChanged<String>? onChanged;
  //控制器
  final TextEditingController? controller;
  //焦点节点，一般用于自动获取焦点，取消焦点以便隐藏键盘等
  final FocusNode? focusNode;
  //校验
  final FormFieldValidator<String>? validator;
  FpcInput(
      {Key? key,
        this.enabled = true,
        this.obscureText = false,
        this.minLines = 1,
        this.maxLines = 1,
        this.keyboardType = TextInputType.text,    //默认输入文本
        this.inputFormatters,
        this.enterType = TextInputAction.next,   //默认回车跳到下一个选项
        this.enterAction,
        this.fillColor = Colors.transparent,
        this.contentPadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 10),//内容内边距，影响高度
        this.hintText,
        this.style = FPCStyle.normalText, //正常字体
        this.hintStyle = const TextStyle(
          color: FPCColors.subTextColor,
          fontSize: FPCSize.tsNormal,
        ),
        this.textAlign = TextAlign.start,
        this.textAlignVertical = TextAlignVertical.center,
        this.icon,
        this.prefixIcon,
        this.suffixIcon,
        //默认下划线
        // border = border??UnderlineInputBorder(borderSide: BorderSide(color: Color(0xff939393)));
        //透明的四周围边框，当设置图标后只能设置OutlineInputBorder，并且isCollapsed=false，才可以使text居中
        //千万不要设置border:InputBorder.none,，  即便不要边框，也要使用 border: OutlineInputBorder(borderSide: BorderSide.none),
        // this.border = const OutlineInputBorder(borderSide: BorderSide(color: FPCColors.colorPrimary)),
        this.border = const OutlineInputBorder(borderSide: BorderSide.none),
        this.iconConstraints,
        this.decoration,
        this.controller,
        this.focusNode,
        this.onChanged,
        this.validator}) : super(key: key){}

  @override
  _FpcInputState createState() => new _FpcInputState();
}

class _FpcInputState extends State<FpcInput> {

  @override
  Widget build(BuildContext context){

    return Center(

      child: new TextFormField(
          style : widget.style,
          enabled : widget.enabled,
          enableInteractiveSelection: true,   //长按是否出现【剪切/复制/粘贴】菜单
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          // maxLength: TextField.noMaxLength,
          maxLength: null,
          // buildCounter: ,
          // counterText: "",//此处控制最大字符是否显示
          /*buildCounter: (context, currentLength = 1, maxLength = 1,isFocused = dfa){
            // return SizedBox();
            return null;
          },*/
          obscureText: widget.obscureText,   //密码模式
          keyboardType: widget.keyboardType, //键盘类型
          inputFormatters: widget.inputFormatters,   //输入过滤
          textInputAction: widget.enterType,//默认回车跳到下一个选项
          onFieldSubmitted: (str) {  //处理回车事件
            print("回车：$str");
            if(widget.enterAction!=null){
              widget.enterAction!(str);
            }
          },
          textAlign : widget.textAlign,   //对齐方式
          textAlignVertical: widget.textAlignVertical,
          //装饰
          decoration: widget.decoration ?? new InputDecoration(
            hintText: widget.hintText,
            hintStyle:widget.hintStyle,
            fillColor: widget.fillColor,//背景颜色，必须结合filled: true,才有效
            filled: true,//重点，必须设置为true，fillColor才有效
            icon: widget.icon,
            prefixIcon: widget.prefixIcon,
            //修改图片大小，突破最小48限制
            prefixIconConstraints: widget.iconConstraints,
            suffixIconConstraints: widget.iconConstraints,
            suffixIcon:widget.suffixIcon,
            //★ isCollapsed = true表示高度包裹内容，使text居中   ，可使用textAlignVertical = TextAlignVertical.center代替
            //单行输入框：如果存在prefixIcon或者suffixIcon图标，则设为false，才能使得text居中，因为图片具有高度
           /* isCollapsed: widget.maxLines==1?
              (widget.prefixIcon!=null||widget.suffixIcon!=null?false:true)
                :true,*/
            contentPadding: widget.contentPadding,//内容内边距，影响高度
            border: widget.border, //边框，一般下面的几个边框一起设置
            focusedBorder: widget.border,
            enabledBorder: widget.border,
            disabledBorder: widget.border,
            focusedErrorBorder: widget.border,
            errorBorder: widget.border,
          ),

          controller: widget.controller,
          focusNode: widget.focusNode,
          onChanged: widget.onChanged,

          ///TextFormField比TextField多了 validator校验函数属性
          validator:widget.validator
      ),
    );
  ///TextFormField包裹一个TextField 并将其集成在Form中。你要提供一个验证函数来检查用户的输入是否满足一定的约束
  ///（例如，一个电话号码）或当你想将TextField与其他FormField集成时，使用TextFormField。
    // return new TextField(
    // return ;
  }
}