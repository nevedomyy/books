import 'package:books/logic/state.dart';
import 'package:books/model/book.dart';
import 'package:books/ui/general/adapt.dart';
import 'package:books/ui/general/behavior.dart';
import 'package:books/ui/general/color.dart';
import 'package:books/ui/general/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:transparent_image/transparent_image.dart';

class FavPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: AppColor.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(30.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: Adapt.px(40.0), bottom: Adapt.px(30.0)),
                child: Text(
                  'Любимка',
                  style: AppTextStyle.displayXXLarge,
                ),
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: Behavior(),
                child: SingleChildScrollView(
                  child: StoreConnector<AppState, List<Book>>(
                    converter: (store) => store.state.favList,
                    builder: (context, list){
                      return Wrap(
                        runSpacing: Adapt.px(20.0),
                        children: List.generate(list.length, (index) =>
                            SizedBox(
                              width: (size.width < size.height ? size.width/2 : size.height/2) - Adapt.px(30.0),
                              child: Column(
                                children: <Widget>[
                                  Padding(
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
                                          width: Adapt.px(140.0),
                                          height: Adapt.px(220.0),
                                          child: FadeInImage.memoryNetwork(
                                            placeholder: kTransparentImage,
                                            image: list[index].thumbnail,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    list[index].title,
                                    style: AppTextStyle.displayMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    list[index].author,
                                    style: AppTextStyle.displaySmall,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            )
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}