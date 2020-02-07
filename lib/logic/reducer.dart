import 'package:books/logic/actions.dart';
import 'package:books/logic/state.dart';
import 'package:books/model/book.dart';
import 'package:books/model/books_list_1.dart';
import 'package:books/model/books_list_2.dart';
import 'package:books/model/books_list_3.dart';
import 'package:books/model/books_list_4.dart';

AppState reducer(AppState currentState, dynamic action){
  if(action is AuthLoading) return _authLoading(currentState, action);
  if(action is AuthSuccess) return _authSuccess(currentState, action);
  if(action is AuthFailed) return _authFailed(currentState, action);
  if(action is GetListUnoLoading) return _getListUnoLoading(currentState, action);
  if(action is GetListUno) return _getListUno(currentState, action);
  if(action is GetListUnoNext) return _getListUnoNext(currentState, action);
  if(action is GetListDoisLoading) return _getListDoisLoading(currentState, action);
  if(action is GetListDois) return _getListDois(currentState, action);
  if(action is GetListDoisNext) return _getListDoisNext(currentState, action);
  if(action is GetListTresLoading) return _getListTresLoading(currentState, action);
  if(action is GetListTres) return _getListTres(currentState, action);
  if(action is GetListTresNext) return _getListTresNext(currentState, action);
  if(action is GetListQuatroLoading) return _getListQuatroLoading(currentState, action);
  if(action is GetListQuatro) return _getListQuatro(currentState, action);
  if(action is GetListQuatroNext) return _getListQuatroNext(currentState, action);
  if(action is ToBuy) return _toBuy(currentState, action);
  if(action is ToFav) return _toFav(currentState, action);
  if(action is Search) return _search(currentState, action);
  return currentState;
}

AppState _authLoading(AppState currentState, dynamic action){
  return currentState.copyWith(authResp: action.authResp);
}

AppState _authSuccess(AppState currentState, dynamic action){
  return currentState.copyWith(authResp: action.authResp);
}

AppState _authFailed(AppState currentState, dynamic action){
  return currentState.copyWith(authResp: action.authResp);
}

AppState _getListUnoLoading(AppState currentState, dynamic action){
  return currentState.copyWith(listUno: action.listUno);
}

AppState _getListUno(AppState currentState, dynamic action){
  return currentState.copyWith(listUno: action.listUno);
}

AppState _getListUnoNext(AppState currentState, dynamic action){
  return currentState.copyWith(listUno: ListUno(
      totalItems: currentState.listUno.totalItems,
      list: List.from(currentState.listUno.list)..addAll(action.listUno.list),
      error: action.listUno.error,
      isLoading: false
  ));
}

AppState _getListDoisLoading(AppState currentState, dynamic action){
  return currentState.copyWith(listDois: action.listDois);
}

AppState _getListDois(AppState currentState, dynamic action){
  return currentState.copyWith(listDois: action.listDois);
}

AppState _getListDoisNext(AppState currentState, dynamic action){
  return currentState.copyWith(listDois: ListDois(
      totalItems: currentState.listDois.totalItems,
      list: List.from(currentState.listDois.list)..addAll(action.listDois.list),
      error: action.listDois.error,
      isLoading: false
  ));
}

AppState _getListTresLoading(AppState currentState, dynamic action){
  return currentState.copyWith(listTres: action.listTres);
}

AppState _getListTres(AppState currentState, dynamic action){
  return currentState.copyWith(listTres: action.listTres);
}

AppState _getListTresNext(AppState currentState, dynamic action){
  return currentState.copyWith(listTres: ListTres(
      totalItems: currentState.listTres.totalItems,
      list: List.from(currentState.listTres.list)..addAll(action.listTres.list),
      error: action.listTres.error,
      isLoading: false
  ));
}

AppState _getListQuatroLoading(AppState currentState, dynamic action){
  return currentState.copyWith(listQuatro: action.listQuatro);
}

AppState _getListQuatro(AppState currentState, dynamic action){
  return currentState.copyWith(listQuatro: action.listQuatro);
}

AppState _getListQuatroNext(AppState currentState, dynamic action){
  return currentState.copyWith(listQuatro: ListQuatro(
      totalItems: currentState.listQuatro.totalItems,
      list: List.from(currentState.listQuatro.list)..addAll(action.listQuatro.list),
      error: action.listQuatro.error,
      isLoading: false
  ));
}

AppState _toBuy(AppState currentState, dynamic action){
  return currentState.copyWith(
    toBuyList: List.from(currentState.toBuyList)..add(action.book)
  );
}

AppState _toFav(AppState currentState, dynamic action){
  return currentState.copyWith(
    favList: List.from(currentState.favList)..add(action.book)
  );
}

AppState _search(AppState currentState, dynamic action){
  final List<Book> tmpList = List();
  currentState.listUno.list.forEach((book){
    if(book.title.toLowerCase().startsWith(action.value.toLowerCase())) tmpList.add(book);
  });
  currentState.listDois.list.forEach((book){
    if(book.title.toLowerCase().startsWith(action.value.toLowerCase())) tmpList.add(book);
  });
  currentState.listTres.list.forEach((book){
    if(book.title.toLowerCase().startsWith(action.value.toLowerCase())) tmpList.add(book);
  });
  currentState.listQuatro.list.forEach((book){
    if(book.title.toLowerCase().startsWith(action.value.toLowerCase())) tmpList.add(book);
  });
  return currentState.copyWith(searchList: tmpList);
}
