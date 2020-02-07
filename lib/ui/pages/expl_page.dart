import 'package:books/logic/actions.dart';
import 'package:books/logic/middleware.dart';
import 'package:books/logic/state.dart';
import 'package:books/model/book.dart';
import 'package:books/model/books_list_1.dart';
import 'package:books/model/books_list_2.dart';
import 'package:books/model/books_list_3.dart';
import 'package:books/model/books_list_4.dart';
import 'package:books/ui/general/adapt.dart';
import 'package:books/ui/general/behavior.dart';
import 'package:books/ui/general/color.dart';
import 'package:books/ui/general/textstyle.dart';
import 'package:books/ui/pages/detail_page.dart';
import 'package:books/ui/widgets/custom_route.dart';
import 'package:books/ui/widgets/horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExplPage extends StatefulWidget {
   @override
  _ExplPageState createState() => _ExplPageState();
}

class _ExplPageState extends State<ExplPage>{
  final ScrollController _scrollController = ScrollController();
  double _searchHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollController.jumpTo(Adapt.px(150.0)));
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: AppColor.white,
      child: ScrollConfiguration(
        behavior: Behavior(),
        child: RefreshIndicator(
          onRefresh: () async {
            StoreProvider.of<AppState>(context)
                ..dispatch(getListUno(0))
                ..dispatch(getListDois(0))
                ..dispatch(getListTres(0))
                ..dispatch(getListQuatro(0));
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: Adapt.px(60.0), left: Adapt.px(30.0), right: Adapt.px(30.0), bottom: Adapt.px(30.0)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.ice,
                      borderRadius: BorderRadius.all(Radius.circular(Adapt.px(40.0)))
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Adapt.px(20.0), vertical: Adapt.px(5.0)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: StoreConnector<AppState, Function(String value)>(
                              converter: (store) => (value) => store.dispatch(Search(value)),
                              builder: (context, search){
                                return TextField(
                                  onChanged: (value){
                                    if(value.length == 0) setState(() {
                                      _searchHeight = 0;
                                      FocusScopeNode currentFocus = FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                                    });
                                    if(value.length == 1) setState(() {_searchHeight = size.height;});
                                    if(value.length > 0) search(value);
                                  },
                                  cursorColor: AppColor.black,
                                  style: AppTextStyle.search,
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'Поиск...',
                                    hintStyle: AppTextStyle.searchHint
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox.fromSize(
                            size: Size.square(Adapt.px(24.0)),
                            child: SvgPicture.asset('assets/search.svg', color: AppColor.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  height: _searchHeight,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.fastOutSlowIn,
                  child: _searchHeight != 0
                    ? StoreConnector<AppState, List<Book>>(
                        converter: (store) => store.state.searchList,
                        builder: (context, searchList){
                          return ListView.builder(
                            itemCount: searchList.length,
                            itemBuilder: (context, index){
                              return GestureDetector(
                                onTap: () => Navigator.push(context, CustomRoute(page: DetailPage(searchList[index]))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: Adapt.px(45.0), vertical: Adapt.px(10.0)),
                                  child: Text(
                                    searchList[index].title,
                                    style: AppTextStyle.displayMedium,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                     )
                    : Container()
                ),
                Padding(
                  padding: EdgeInsets.only(top: Adapt.px(60.0), left: Adapt.px(30.0)),
                  child: Text(
                    'Здр, Землянин',
                    style: AppTextStyle.displayXXLarge,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: Adapt.px(46.0), left: Adapt.px(30.0)),
                  child: Text(
                    'Врывайся...',
                    style: AppTextStyle.displayMediumLight,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Adapt.px(30.0)),
                  child: Divider(color: AppColor.lightGrey, thickness: Adapt.px(1.0), height: 0),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Adapt.px(15.0), horizontal: Adapt.px(30.0)),
                  child: Text(
                    'Детективчик',
                    style: AppTextStyle.displayMedium,
                  )
                ),
                SizedBox(
                  height: Adapt.px(220.0),
                  child: Center(
                    child: StoreConnector<AppState, ListUno>(
                      converter: (store) => store.state.listUno,
                      onInit: (store) => store.dispatch(getListUno(0)),
                      builder: (context, listUno){
                        if(listUno.isLoading) return CircularProgressIndicator(strokeWidth: Adapt.px(1.0));
                        if(listUno.list != null) return AppHorizList(
                          function: (){
                            int listLength = listUno.list.length;
                            int allOrders = listUno.totalItems;
                            if(listLength < allOrders){
                              StoreProvider.of<AppState>(context).dispatch(getListUno(listLength));
                              return true;
                            }
                            return false;
                          },
                          list: listUno.list,
                        );
                        return Container();
                      },
                    ),
                  ),
                ),
                SizedBox(height: Adapt.px(20.0),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Adapt.px(30.0)),
                  child: Divider(color: AppColor.lightGrey, thickness: Adapt.px(1.0), height: 0),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Adapt.px(15.0), horizontal: Adapt.px(30.0)),
                  child: Text(
                    'Космос',
                    style: AppTextStyle.displayMedium,
                  )
                ),
                SizedBox(
                  height: Adapt.px(220.0),
                  child: Center(
                    child: StoreConnector<AppState, ListDois>(
                      converter: (store) => store.state.listDois,
                      onInit: (store) => store.dispatch(getListDois(0)),
                      builder: (context, listDois){
                        if(listDois.isLoading) return CircularProgressIndicator(strokeWidth: Adapt.px(1.0));
                        if(listDois.list != null) return AppHorizList(
                          function: (){
                            int listLength = listDois.list.length;
                            int allOrders = listDois.totalItems;
                            if(listLength < allOrders){
                              StoreProvider.of<AppState>(context).dispatch(getListDois(listLength));
                              return true;
                            }
                            return false;
                          },
                          list: listDois.list,
                        );
                        return Container();
                      },
                    ),
                  ),
                ),
                SizedBox(height: Adapt.px(20.0),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Adapt.px(30.0)),
                  child: Divider(color: AppColor.lightGrey, thickness: Adapt.px(1.0), height: 0),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Adapt.px(15.0), horizontal: Adapt.px(30.0)),
                  child: Text(
                    'Всякое',
                    style: AppTextStyle.displayMedium,
                  )
                ),
                SizedBox(
                  height: Adapt.px(220.0),
                  child: Center(
                    child: StoreConnector<AppState, ListTres>(
                      converter: (store) => store.state.listTres,
                      onInit: (store) => store.dispatch(getListTres(0)),
                      builder: (context, listTres){
                        if(listTres.isLoading) return CircularProgressIndicator(strokeWidth: Adapt.px(1.0));
                        if(listTres.list != null) return AppHorizList(
                          function: (){
                            int listLength = listTres.list.length;
                            int allOrders = listTres.totalItems;
                            if(listLength < allOrders){
                              StoreProvider.of<AppState>(context).dispatch(getListTres(listLength));
                              return true;
                            }
                            return false;
                          },
                          list: listTres.list,
                        );
                        return Container();
                      },
                    ),
                  ),
                ),
                SizedBox(height: Adapt.px(20.0),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Adapt.px(30.0)),
                  child: Divider(color: AppColor.lightGrey, thickness: Adapt.px(1.0), height: 0),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Adapt.px(15.0), horizontal: Adapt.px(30.0)),
                  child: Text(
                    'Классика',
                    style: AppTextStyle.displayMedium,
                  )
                ),
                SizedBox(
                  height: Adapt.px(220.0),
                  child: Center(
                    child: StoreConnector<AppState, ListQuatro>(
                      converter: (store) => store.state.listQuatro,
                      onInit: (store) => store.dispatch(getListQuatro(0)),
                      builder: (context, listQuatro){
                        if(listQuatro.isLoading) return CircularProgressIndicator(strokeWidth: Adapt.px(1.0));
                        if(listQuatro.list != null) return AppHorizList(
                          function: (){
                            int listLength = listQuatro.list.length;
                            int allOrders = listQuatro.totalItems;
                            if(listLength < allOrders){
                              StoreProvider.of<AppState>(context).dispatch(getListQuatro(listLength));
                              return true;
                            }
                            return false;
                          },
                          list: listQuatro.list,
                        );
                        return Container();
                      },
                    ),
                  ),
                ),
                SafeArea(
                  child: SizedBox(height: Adapt.px(100.0),)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}