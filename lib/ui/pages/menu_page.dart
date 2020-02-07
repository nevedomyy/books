import 'package:books/ui/general/adapt.dart';
import 'package:books/ui/general/color.dart';
import 'package:books/ui/pages/expl_page.dart';
import 'package:books/ui/pages/fav_page.dart';
import 'package:books/ui/pages/pref_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

class MenuPage extends StatefulWidget {
   @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin{
  final List<String> _labels = ['search', 'fav', 'menu'];
  AnimationController _animationController;
  int _currentPage = 0;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1800));
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
    final size = MediaQuery.of(context).size;
    return Material(
      color: AppColor.white,
      child: Stack(
        children: <Widget>[
          FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              curve: Interval(0.7, 1.0, curve: Curves.fastOutSlowIn),
              parent: _animationController,
            )),
            child: IndexedStack(
              index: _currentPage,
              children: <Widget>[
                ExplPage(),
                FavPage(),
                PrefPage()
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: Adapt.px(80.0),
              width: size.width,
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(Adapt.px(40.0)), topRight: Radius.circular(Adapt.px(40.0))),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        color: AppColor.blur,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(3, (index) => GestureDetector(
                      onTap: (){
                        _currentPage = index;
                        setState(() {});
                      },
                      child: SizedBox(
                        height: Adapt.px(80.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: Adapt.px(30.0)),
                          child: ScaleTransition(
                            scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                              curve: Interval(0.2, 1.0, curve: Curves.elasticOut),
                              parent: _animationController,
                            )),
                            child: SizedBox.fromSize(
                              size: Size.square(Adapt.px(30.0)),
                              child: SvgPicture.asset('assets/${_labels[index]}.svg', color: _currentPage == index ? Colors.red[900] : AppColor.primary),
                            ),
                          ),
                        ),
                      ),
                    )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}