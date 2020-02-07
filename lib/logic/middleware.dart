import 'package:books/logic/actions.dart';
import 'package:books/logic/provider.dart';
import 'package:books/logic/state.dart';
import 'package:books/ui/general/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:connectivity/connectivity.dart';

Future<bool> checkConnection() async{
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) return false;
  return true;
}

ThunkAction<AppState> signIn(String number) {
  return (Store<AppState> store) async {
    store.dispatch(AuthLoading());
    bool isConnected = await checkConnection();
    if(!isConnected) Keys.loginPageKey.currentState.showSnackBar(SnackBar(
      content: Text('А ДЕ ИНТЕРНЕТ?'),
      duration: Duration(seconds: 3),
    ));
    final secureStorage = FlutterSecureStorage();
    String login = await secureStorage.read(key: 'login');
    await Future.delayed(Duration(milliseconds: 1200));
    if(number == login) {
      Keys.navigationKey.currentState.pushReplacementNamed('menuPage');
      store.dispatch(AuthSuccess());
    }else{
      Keys.loginPageKey.currentState.showSnackBar(SnackBar(
        content: Text('ВРОНГ ПАСВОРД'),
        duration: Duration(seconds: 3),
      ));
      store.dispatch(AuthFailed());
    }
  };
}

ThunkAction<AppState> getListUno(int startIndex) {
  return (Store<AppState> store) async {
    if(startIndex == 0) store.dispatch(GetListUnoLoading());
    final provider = ListUnoProvider();
    final resp = await provider.getList(startIndex);
    if(startIndex == 0) store.dispatch(GetListUno(resp));
    else store.dispatch(GetListUnoNext(resp));
  };
}

ThunkAction<AppState> getListDois(int startIndex) {
  return (Store<AppState> store) async {
    if(startIndex == 0) store.dispatch(GetListDoisLoading());
    final provider = ListDoisProvider();
    final resp = await provider.getList(startIndex);
    if(startIndex == 0) store.dispatch(GetListDois(resp));
    else store.dispatch(GetListDoisNext(resp));
  };
}

ThunkAction<AppState> getListTres(int startIndex) {
  return (Store<AppState> store) async {
    if(startIndex == 0) store.dispatch(GetListTresLoading());
    final provider = ListTresProvider();
    final resp = await provider.getList(startIndex);
    if(startIndex == 0) store.dispatch(GetListTres(resp));
    else store.dispatch(GetListTresNext(resp));
  };
}

ThunkAction<AppState> getListQuatro(int startIndex) {
  return (Store<AppState> store) async {
    if(startIndex == 0) store.dispatch(GetListQuatroLoading());
    final provider = ListQuatroProvider();
    final resp = await provider.getList(startIndex);
    if(startIndex == 0) store.dispatch(GetListQuatro(resp));
    else store.dispatch(GetListQuatroNext(resp));
  };
}