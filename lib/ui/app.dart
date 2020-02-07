import 'package:books/logic/reducer.dart';
import 'package:books/logic/state.dart';
import 'package:books/ui/general/color.dart';
import 'package:books/ui/general/keys.dart';
import 'package:books/ui/pages/login_page.dart';
import 'package:books/ui/pages/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

class App extends StatelessWidget {
  final Store<AppState> store = Store<AppState>(
      reducer,
      initialState: AppState.initial(),
      middleware: [thunkMiddleware]
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        navigatorKey: Keys.navigationKey,
        theme: ThemeData(
            accentColor: AppColor.black
        ),
        initialRoute: 'loginPage',
        routes: {
          'loginPage': (context) => LoginPage(),
          'menuPage': (context) => MenuPage(),
        },
      ),
    );
  }
}
