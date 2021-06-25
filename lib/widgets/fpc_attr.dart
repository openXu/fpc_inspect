import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpc_inspect/common/style/fpc_style.dart';
import 'package:image_picker/image_picker.dart';

/// 附件

///
///

class FpcAttr extends StatefulWidget {

  final bool editAble; //是否可编辑
  final int maxSize;   //支持添加附件的最大数量
  final bool sliver;   //是否嵌套滚动？ 父Widget为CustomScrollView的情况下传true
  FpcAttr({
    Key? key,
    this.editAble = true,
    this.maxSize = 6,
    this.sliver = true,
  }) : super(key: key);

   @override
   _FpcAttrState createState() => new _FpcAttrState();
}
class _FpcAttrState extends State<FpcAttr> {
  late ImagePicker _picker;
  List<File> attrList = [];
  @override
  void initState() {
    //实例化选择图片
    _picker = new ImagePicker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,    //横轴三个子widget
        childAspectRatio: 0.85, //宽高比为1时，子widget
        mainAxisSpacing: FPCSize.lineSpace,   //主轴方向上的空隙间距；
        crossAxisSpacing : FPCSize.lineSpace,   //次轴方向上的空隙间距
    );
    final _childCount = widget.editAble && attrList.length<widget.maxSize?
        attrList.length+1:attrList.length;
    final _padding =  EdgeInsets.all(FPCSize.lineSpace);
    return widget.sliver?
      SliverPadding(
          padding: _padding,
          sliver: SliverGrid(
              gridDelegate: _gridDelegate,
              delegate : SliverChildBuilderDelegate(
                    (context, index) =>_getItem(index),
                childCount : _childCount,
              )
          )
      )
      :
      GridView.builder(
          gridDelegate: _gridDelegate,
          padding: _padding,
          physics: NeverScrollableScrollPhysics(),
          itemCount:_childCount,
          itemBuilder: (context, index) =>_getItem(index)
      );
  }

  Widget _getItem(index){
    return AttrItem(
      editAble: widget.editAble,
      data : index == attrList.length?null:attrList[index],
      onCheck: (){
        print("查看");
      },
      onAdd: (){
        _getImage();
      },
      onDelete: (){
        setState(() {
          attrList.removeAt(index);
        });
      },
    );
  }

//异步吊起相机拍摄新照片方法
  Future _getCameraImage() async {
    ///调用相机拍照
    final cameraImages = await _picker.getImage(source: ImageSource.camera);
    //拍摄照片不为空
    if (cameraImages != null) {
      File _userImage = File(cameraImages.path);
      print('你选择的路径是：${_userImage.toString()}');
      setState(() {
        attrList.add(_userImage);
      });
      //图片为空
    } else {
      print('没有照片可以选择');
    }
  }
  Future _getImage() async {
    //选择相册
    final pickerImages = await _picker.getImage(source: ImageSource.gallery);
    if(pickerImages != null){
      File _userImage = File(pickerImages.path);
      print('你选择的本地路径是：${_userImage.toString()}');
      setState(() {
        attrList.add(_userImage);
      });
    }else{
      print('没有照片可以选择');
    }
  }
}

///
class AttrItem extends StatelessWidget {

  final VoidCallback? onCheck;
  final VoidCallback? onAdd;
  final VoidCallback? onDelete;
  final bool editAble;
  const AttrItem({
    Key? key,
    this.data,
    required this.editAble,
    this.onCheck,
    this.onAdd,
    this.onDelete
  }) : super(key: key);
  final File? data;

  @override
  Widget build(BuildContext context) {

    return DecoratedBox(
        decoration: BoxDecoration(
            // color: Colors.blue
        ),
        child:Column(
          children: <Widget>[
            Expanded(
              child: AspectRatio(              //宽高比为1，保持正方形
              aspectRatio: 1,
                child:Stack(
                  fit: StackFit.passthrough,   //passthrough从父级传递到堆栈的约束未经修改地传递给未定位的孩子
                  children: [
                    ClipRRect(   //圆角裁剪
                        borderRadius: BorderRadius.circular(4),
                        child:GestureDetector(
                            onTap:(){
                              data==null?onAdd!():onCheck!();
                            },
                            child : data==null?Icon(Icons.add, color:Theme.of(context).primaryColor, size: 50):
                            Image.file(data!,  fit: BoxFit.cover,)
                        )
                    ),
                    ///右上角删除
                    data == null || !editAble ?SizedBox():
                    Positioned(
                      right: 0,
                      top: 0,
                      child:
                      GestureDetector(
                        onTap: ()async{
                          print("删除");
                          onDelete!();
                        },
                        child:Container(
                          // padding: EdgeInsets.all(0.5),
                          decoration: BoxDecoration(   //删除按钮装饰
                            borderRadius: BorderRadius.circular(10),
                            // gradient: LinearGradient(colors: [Color(0xFFA17551), Color(0xFFCCBEB5)]),
                            color: FPCColors.white
                          ),
                          child:Icon(Icons.highlight_remove, color:Theme.of(context).primaryColor, size: 20)
                        )
                      ),
                    ),
                  ],
                ),
              )

              //宽高比为1，保持正方形
            /*  child: AspectRatio(
                aspectRatio: 1,
                child: data==null?Icon(Icons.add, color:Theme.of(context).primaryColor, size: 50):
                Image.file(data!,  fit: BoxFit.cover,),
              )*/
/*
              child: Container(
                color: FPCColors.yellow,
                constraints:BoxConstraints(minWidth: double.infinity, minHeight: double.infinity),
                child: data==null?Icon(Icons.add, color:Theme.of(context).primaryColor, size: 50):
                Image.file(data!,  fit: BoxFit.cover,),
              )
*/
            ),
            Padding(padding: EdgeInsets.only(top: FPCSize.lineSpace)),
            Text(
              data ==null?"": data!.path,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: FPCStyle.middleText,
            ),
          ],
        ),
    );

  }
}

















