import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/button_filled.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/check_box.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/login_text_form_field.dart';
import 'package:flutter_hishab_khata/src/features/account/presentation/providers/account_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  bool isObscure = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //check whether remember credential or not
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AccountProvider>(context, listen: false).initLoginPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 117, 197, 184),
      body: Consumer<AccountProvider>(
        builder: (_, accountProvider, child) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset('assets/logo/logo.png', height: 200, width: 200,),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Welcome to HishabKhata',
                      style: theme.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      height: 400,
                      child: ClipPath(
                        //clipper: BackgroundClipper(),
                        child: Form(
                          child: Card(
                            shape:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 24,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, right: 14, left: 14, bottom: 8),
                                  child: LoginTextFomrFiledWidget(
                                    textEditingController: accountProvider.requestLogin.emailController,
                                    //initialValue: accountProvider.requestLogin.email,
                                    onChanged: (String value){
                                      var data = accountProvider.requestLogin;
                                      data.username = value;
                                      accountProvider.requestLogin = data;
                                    },
                                    hintText: "username",
                                    labelText: 'Username',
                                    prefixIcon: const Icon(
                                      Icons.email_sharp,
                                      color: Colors.grey,
                                    ),
                                    cursorColor: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, right: 14, left: 14, bottom: 8),
                                  child: LoginTextFomrFiledWidget(
                                    textEditingController: accountProvider.requestLogin.passwordController,
                                    //initialValue: accountProvider.requestLogin.password,
                                    onChanged: (String value){
                                      var data = accountProvider.requestLogin;
                                      data.password = value;
                                      accountProvider.requestLogin = data;
                                    },
                                    obscureText: isObscure,
                                    hintText: "Password",
                                    labelText: 'Password',
                                    prefixIcon: const Icon(
                                      Icons.vpn_key,
                                      color: Colors.grey,
                                    ),
                                    sufixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isObscure = !isObscure;
                                          });
                                        },
                                        icon: isObscure
                                            ? const Icon(
                                          Icons.visibility_off,
                                          color: Colors.grey,
                                        )
                                            : const Icon(
                                          Icons.visibility,
                                          color: Colors.grey,
                                        )),
                                    cursorColor: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    CheckBoxWidget(
                                        onChanged: (value) {
                                          accountProvider.rememberLoginCredentials = value??false;
                                        },
                                        value: accountProvider.rememberLoginCredentials,
                                        activeColor: Colors.cyan,
                                        inactiveColor: Colors.grey),
                                    Text(
                                      'Remember me',
                                      style: theme.textTheme.bodySmall,
                                    )
                                  ],
                                ),
                                Container(
                                  height: 60,
                                  padding: const EdgeInsets.only(top: 10.0, right: 14, left: 14, bottom: 8),
                                  child: accountProvider.loading
                                      ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                      : ButtonFilled(
                                    function: () {
                                      accountProvider.login();
                                    },
                                    buttonText: 'LOGIN',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 60.h,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
