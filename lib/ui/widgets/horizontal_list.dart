import 'package:books/model/book.dart';
import 'package:books/ui/general/adapt.dart';
import 'package:books/ui/general/color.dart';
import 'package:books/ui/pages/detail_page.dart';
import 'package:books/ui/widgets/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class AppHorizList extends StatefulWidget {
  final Function() function;
  final List<Book> list;

  AppHorizList({
    @required this.function,
    @required this.list
  });

   @override
  _AppHorizListState createState() => _AppHorizListState();
}

class _AppHorizListState extends State<AppHorizList>{
  ScrollController _scrollController;
  bool _isNextPageAvailable = false;

    @override
  void initState() {
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController..removeListener(_scrollListener)..dispose();
    super.dispose();
  }

  _scrollListener() async{
    if(_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange){
      _isNextPageAvailable = await widget.function();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.white,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(20.0)),
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: _isNextPageAvailable
          ? widget.list.length + 1
          : widget.list.length,
        itemBuilder: (context, index){
          return index < widget.list.length
            ? GestureDetector(
                onTap: () => Navigator.push(context, CustomRoute(page: DetailPage(widget.list[index]))),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Adapt.px(15.0)),
                      color: AppColor.white,
                      boxShadow: [BoxShadow(color: AppColor.grey, blurRadius: Adapt.px(5.0))]
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Adapt.px(15.0)),
                      child: SizedBox(
                        width: Adapt.px(130.0),
                        height: Adapt.px(200.0),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: widget.list[index].thumbnail,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Adapt.px(30.0)),
                  child: CircularProgressIndicator(strokeWidth: Adapt.px(1.0),)
                ),
            );
        },
      )
    );
  }
}