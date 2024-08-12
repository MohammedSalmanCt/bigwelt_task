import 'package:bigwelt_task/features/Authentication/controller/auth_controller.dart';
import 'package:bigwelt_task/features/Authentication/view/phone.dart';
import 'package:bigwelt_task/features/HomePage/view/home_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/asset_constants.dart';
import '../../../core/global_variables/global_variables.dart';
import '../../../core/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// AuthController
final AuthController authController=AuthController();

  /// focus nodes
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  /// password visibility variable
  bool passwordVisibility=false;
  /// TextEditingController
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

  ///Login with userName and Password
  loginWithUserNameAndPassword({required String pass,required String name,required BuildContext context}) async {
    final login=await authController.loginWithUserNameAndPassword(password: pass, name: name,);
    login.fold((l) => showSnackBar(context,l.message), (r) {
      password.clear();
      userName.clear();
       Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(userModel: r,),));
    } );
  }

  ///googleSign
  googleSign() async {
    print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
    final login=await authController.googleSign();
    login.fold((l) { showSnackBar(context,l.message);
      print(l.message);}, (r) {
       Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(userModel: r,),));
    } );
  }
  
  /// forgot password
 forgotPassword(String email,String newPassword,BuildContext context) async {
  final forget=await authController.forgotPassword(email,newPassword);
  forget.fold((l) => showSnackBar(context, l.message), (r) {
    Navigator.pop(context);
    showSnackBar(context, 'Password Updated');},);
}
  /// forget password show dialog
  forgotPasswordDialog(BuildContext context) {
    final TextEditingController existUserName = TextEditingController();
    final TextEditingController newPassword = TextEditingController();
    showDialog(
    context: context,
    builder: (BuildContext context1) {
      return AlertDialog(
        title: const Text('Forgot Password'),
        content: Form(
          key: _formKey1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: width * 0.8,
                height: height * 0.08,
                child: TextFormField(
                  cursorColor: Colors.orange,
                  autofillHints: const [AutofillHints.name],
                  validator: (value) {
                    var val = value ?? '';
                    if (val.isEmpty) {
                      return 'Please enter Username';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  autofocus: true,
                  controller: existUserName,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      fontFamily: 'Lexend Deca',
                      color: const Color(0xFF57636C),
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.normal,
                    ),
                    hintText: 'Please Enter Username',
                    hintStyle: TextStyle(
                      fontFamily: 'Lexend Deca',
                      color: const Color(0xFF57636C),
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.normal,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.only(
                        top: height * 0.015, left: width * 0.05),
                  ),
                  style: TextStyle(
                    fontFamily: 'Lexend Deca',
                    color: const Color(0xFF1D2429),
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.8,
                height: height * 0.08,
                child: TextFormField(
                  cursorColor: Colors.black,
                  autofillHints: const [AutofillHints.password],
                  controller: newPassword,
                  validator: (passCurrentValue) {
                    var passNonNullValue = passCurrentValue ?? '';
                    if (passNonNullValue.isEmpty) {
                      return ("Please Enter New Password");
                    } else if (passNonNullValue.length < 6) {
                      return ("Password must have\n at least 6 characters");
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Please Enter New Password',
                    labelStyle: TextStyle(
                      fontFamily: 'Lexend Deca',
                      color: const Color(0xFF57636C),
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.normal,
                    ),
                    hintText: 'Please Enter New Password',
                    hintStyle: TextStyle(
                      fontFamily: 'Lexend Deca',
                      color: const Color(0xFF57636C),
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.normal,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.only(
                        top: height * 0.015, left: width * 0.05),
                  ),
                  style: TextStyle(
                    fontFamily: 'Lexend Deca',
                    color: const Color(0xFF1D2429),
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
            if(_formKey1.currentState!.validate())
              {
                forgotPassword(existUserName.text.trim(), newPassword.text.trim(), context1);
              }
            },
            child: const Text(' Reset'),
          ),
        ],
      );
    },
  );
}
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userName.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Colors.black;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(width * 0.1),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.08,
                  ),
                  SizedBox(
                      width: width * 0.8,
                      height: height * 0.2,
                      child: Image.asset(AssetConstants.login)),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                        fontSize: width * 0.065, fontWeight: FontWeight.bold),
                  ),
                  Text("your account",
                      style: TextStyle(
                          fontSize: width * 0.065,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  SizedBox(
                    width: width * 0.8,
                    height: height * 0.08,
                    child: TextFormField(
                      cursorColor: Colors.orange,
                      autofillHints: const [AutofillHints.name],
                      validator: (value) {
                        var val = value ?? '';
                        if (val.isEmpty) {
                          return 'Please enter Username';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      focusNode: f1,
                      onFieldSubmitted: (value) {
                        f1.unfocus();
                        FocusScope.of(context).requestFocus(f2);
                      },
                      autofocus: true,
                      controller: userName,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: const Color(0xFF57636C),
                          fontSize: width * 0.035,
                          fontWeight: FontWeight.normal,
                        ),
                        hintText: 'Please Enter Username',
                        hintStyle: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: const Color(0xFF57636C),
                          fontSize: width * 0.035,
                          fontWeight: FontWeight.normal,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(
                            top: height * 0.015, left: width * 0.05),
                      ),
                      style: TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: const Color(0xFF1D2429),
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.8,
                    height: height * 0.08,
                    child: TextFormField(
                      cursorColor: primaryColor,
                      autofillHints: const [AutofillHints.password],
                      controller: password,
                      validator: (passCurrentValue) {
                        var passNonNullValue = passCurrentValue ?? '';
                        if (passNonNullValue.isEmpty) {
                          return ("Please Enter Password");
                        } else if (passNonNullValue.length < 6) {
                          return ("Password must have\n at least 6 characters");
                        }
                        return null;
                      },
                      focusNode: f2,
                      autofocus: true,
                      obscureText: !passwordVisibility,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: const Color(0xFF57636C),
                          fontSize: width * 0.035,
                          fontWeight: FontWeight.normal,
                        ),
                        hintText: 'Please Enter Password',
                        hintStyle: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: const Color(0xFF57636C),
                          fontSize: width * 0.035,
                          fontWeight: FontWeight.normal,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(
                            top: height * 0.015, left: width * 0.05),
                        suffixIcon: InkWell(
                          onTap: () {
                            passwordVisibility=!passwordVisibility;
                            setState(() {

                            });
                          },
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            passwordVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0xFF757575),
                            size: width * 0.04,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: const Color(0xFF1D2429),
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        forgotPasswordDialog(context);
                      },
                      child: Text(
                        "Forget Password",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: width * (0.035),
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        print("2222222222222222222222");
                        googleSign();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: Colors.black,
                            )),
                        backgroundColor: Colors.white,
                        minimumSize: Size(
                          width * (0.8),
                          height * (0.05),
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            AssetConstants.google,
                            width: width * (0.1),
                          ),
                          SizedBox(
                            width: width * (0.05),
                          ),
                          Text(
                            "Sign in with Google",
                            style: TextStyle(
                                color: Colors.black, fontSize: width * (0.05)),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneScreen(),));
                    },
                    child: Container(
                      width: width * 0.8,
                      height: height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.02),
                        color: primaryColor,
                      ),
                      child: Center(
                          child: Text(
                            "Signing with Phone Number",
                            style: TextStyle(
                                fontSize: width * 0.04,
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),

                  /// login button
                GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        loginWithUserNameAndPassword(pass: password.text.trim(), name: userName.text.trim(), context: context);
                      }
                    },
                    child: Container(
                      width: width * 0.8,
                      height: height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.02),
                        color: primaryColor,
                      ),
                      child: Center(
                          child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: width * 0.05,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
