import 'package:books/logic/middleware.dart';
import 'package:books/logic/state.dart';
import 'package:books/model/auth.dart';
import 'package:books/ui/general/adapt.dart';
import 'package:books/ui/general/color.dart';
import 'package:books/ui/general/keys.dart';
import 'package:books/ui/general/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
   @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin{
  final TextEditingController _controller = TextEditingController();
  final _secureStorage = FlutterSecureStorage();
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _secureStorage.write(key: 'login', value: '5555');
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    WidgetsBinding.instance.addPostFrameCallback((_) => _animationController.forward());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context){
        Adapt.initContext(context);
        return Scaffold(
          key: Keys.loginPageKey,
          backgroundColor: AppColor.white,
          body: SafeArea(
            child: Center(
              child: FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  curve: Interval(0.2, 1.0, curve: Curves.fastOutSlowIn),
                  parent: _animationController,
                )),
                child: StoreConnector<AppState, AuthResp>(
                  converter: (store) => store.state.authResp,
                  builder: (context, authResp){
                    if(authResp.isLoading) return CircularProgressIndicator(strokeWidth: Adapt.px(1.0));
                    return SizedBox(
                      width: Adapt.px(120.0),
                      child: StoreConnector<AppState, Function(String number)>(
                        converter: (store) => (number) => store.dispatch(signIn(number)),
                        builder: (context, signIn){
                          return TextField(
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(4),
                              WhitelistingTextInputFormatter.digitsOnly,
                              BlacklistingTextInputFormatter.singleLineFormatter,
                            ],
                            controller: _controller,
                            onChanged: (value){
                              if(value.length == 4){
                                signIn(value);
                                FocusScopeNode currentFocus = FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                                _controller.clear();
                              }
                            },
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.displayLarge,
                            cursorColor: AppColor.black,
                            decoration: InputDecoration(
                              hintText: 'ПРОЛЬ',
                              hintStyle: AppTextStyle.displayLargeHint,
                              contentPadding: EdgeInsets.all(0),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.grey, width: Adapt.px(1.0))),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.primary, width: Adapt.px(1.0))),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}