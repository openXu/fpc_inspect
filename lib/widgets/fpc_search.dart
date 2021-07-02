import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:fpc_inspect/widgets/fpc_input.dart';

/// 自定义搜索框
/// 
///

class FpcSearch extends StatelessWidget {

  final ValueChanged<String> search;
  final String? hintText;  //提示文字
  FpcSearch({Key? key,
    this.hintText = "请输入要搜索的内容",
    required this.search,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    //控制器
    final TextEditingController _controller = TextEditingController();
    //焦点节点，一般用于自动获取焦点，取消焦点以便隐藏键盘等
    final FocusNode _focusNode = FocusNode();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 35),
      ///确定高度
      child:SizedBox(
        height: 38,
        child: Container(
          ///整体圆角+蓝色背景（搜索按钮）
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: FPCColors.blue
          ),
          child: Row(
            crossAxisAlignment:CrossAxisAlignment.stretch,   //子控件高度填充38
            children: [
              Expanded(
                ///搜索框+清除按钮
                child:Container(
                  decoration: BoxDecoration(
                      border:Border.all(width: 1.0, color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(4),
                      color: FPCColors.white
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child:FpcInput(
                            hintText:hintText,
                            // fillColor:Colors.blue,
                            contentPadding: EdgeInsets.only(left: 10),
                            // border: OutlineInputBorder(
                            //     borderSide: BorderSide(color: FPCColors.colorPrimary)
                            // ),
                            enterType : TextInputAction.search,
                            enterAction : search,
                            focusNode: _focusNode,
                            controller:_controller
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          _focusNode.requestFocus();
                          _controller.clear();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(Icons.clear, color:Colors.grey[400], size: 16),
                        ),
                      )
                    ],
                  )
                )
              ),

              ///搜索按钮
              GestureDetector(
                onTap: (){
                  _focusNode.unfocus();
                  search(_controller.text);
                },
                child:Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.search, color:Colors.white, size: 25),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
