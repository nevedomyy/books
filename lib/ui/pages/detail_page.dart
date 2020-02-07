import 'package:books/logic/state.dart';
import 'package:books/logic/actions.dart';
import 'package:books/model/book.dart';
import 'package:books/ui/general/adapt.dart';
import 'package:books/ui/general/behavior.dart';
import 'package:books/ui/general/color.dart';
import 'package:books/ui/general/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailPage extends StatefulWidget {
  final Book book;

  DetailPage(this.book);

   @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin{
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    WidgetsBinding.instance.addPostFrameCallback((_) => _animationController.forward());
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: <Widget>[
          ScrollConfiguration(
            behavior: Behavior(),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Adapt.px(30.0)),
                child: Column(
                  children: <Widget>[
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.only(top: Adapt.px(40.0)),
                      ),
                    ),
                    FadeTransition(
                      opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        curve: Interval(0.2, 1.0, curve: Curves.easeIn),
                        parent: _animationController,
                      )),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(Adapt.px(30.0)),
                          boxShadow: [BoxShadow(color: AppColor.darkGrey, blurRadius: Adapt.px(8.0))]
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Adapt.px(30.0)),
                          child: SizedBox(
                            width: Adapt.px(250.0),
                            height: Adapt.px(400.0),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: widget.book.thumbnail,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    FadeTransition(
                      opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        curve: Interval(0.2, 1.0, curve: Curves.easeIn),
                        parent: _animationController,
                        )),
                      child: SlideTransition(
                        position: Tween(begin: Offset(0, 0.4), end: Offset.zero).animate(CurvedAnimation(
                          curve: Interval(0.2, 1.0, curve: Curves.fastOutSlowIn),
                          parent: _animationController,
                        )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(height: Adapt.px(30.0)),
                            Text(
                              widget.book.title,
                              style: AppTextStyle.displayXXLarge,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              widget.book.author,
                              style: AppTextStyle.displayLarge,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: Adapt.px(28.0)),
                            Divider(color: AppColor.lightGrey, thickness: Adapt.px(1.0), height: 0),
                            SizedBox(height: Adapt.px(15.0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  widget.book.price.toString(),
                                  style: AppTextStyle.displayXXLarge,
                                ),
                                SizedBox(width: Adapt.px(5.0)),
                                Text(
                                  widget.book.currencyCode,
                                  style: AppTextStyle.displayMedium,
                                ),
                              ],
                            ),
                            SizedBox(height: Adapt.px(38.0)),
                            Text(
                              'Описулька',
                              style: AppTextStyle.displaySmall,
                            ),
                            SizedBox(height: Adapt.px(20.0)),
                            Text(
                              widget.book.description,
                              style: AppTextStyle.paragraph,
                            ),
                            SafeArea(
                              child: SizedBox(height: Adapt.px(50.0)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: FadeTransition(
              opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                curve: Interval(0.8, 1.0, curve: Curves.easeIn),
                parent: _animationController,
              )),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: Adapt.px(70.0),
                      decoration: BoxDecoration(
                        color: AppColor.grey,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(Adapt.px(40.0)))
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Adapt.px(20.0)),
                        child: SizedBox.fromSize(
                          size: Size.square(Adapt.px(32.0)),
                          child: SvgPicture.asset('assets/back.svg', color: AppColor.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.grey,
                      border: Border(
                        right: BorderSide(width: 0),
                        left: BorderSide(width: 0, color: AppColor.grey),
                      ),
                    ),
                    child: StoreConnector<AppState, Function(Book book)>(
                      converter: (store) => (book) => store.dispatch(ToFav(book)),
                      builder: (context, toFav){
                        return GestureDetector(
                          onTap: () {
                            toFav(widget.book);
                            showBottomSheet(context: context, builder: (context){
                              return GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  height: Adapt.px(100.0),
                                  width: double.infinity,
                                  color: AppColor.blur,
                                  child: Center(
                                    child: Text(
                                      'Мммм ПРИГЛЯНУЛОСЬ',
                                      style: AppTextStyle.displayXLarge,
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                          child: Container(
                            height: Adapt.px(70.0),
                            decoration: BoxDecoration(
                              color: AppColor.darkGrey,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(Adapt.px(40.0))),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: Adapt.px(20.0)),
                              child: SizedBox.fromSize(
                                size: Size.square(Adapt.px(32.0)),
                                child: SvgPicture.asset('assets/fav.svg', color: AppColor.white),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: AppColor.darkGrey,
                    child: StoreConnector<AppState, Function(Book book)>(
                      converter: (store) => (book) => store.dispatch(ToBuy(book)),
                      builder: (context, toBuy){
                        return GestureDetector(
                          onTap: () {
                            toBuy(widget.book);
                            showBottomSheet(context: context, builder: (context){
                              return GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  height: Adapt.px(100.0),
                                  width: double.infinity,
                                  color: AppColor.blur,
                                  child: Center(
                                    child: Text(
                                      'БРОСИЛ В КОРЗИНУ',
                                      style: AppTextStyle.displayXLarge,
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                          child: Container(
                            height: Adapt.px(70.0),
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(Adapt.px(40.0))),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: Adapt.px(20.0)),
                              child: Center(
                                child: Text(
                                  'КУПИТЬ',
                                  style: AppTextStyle.displayLargeWhite,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}