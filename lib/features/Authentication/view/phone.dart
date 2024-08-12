import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/global_variables/global_variables.dart';
import '../../../core/utils.dart';
import 'otp_screen.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  /// variables
  bool isLoading = false;
  TextEditingController phoneNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
/// send OTP methode
  Future<void> sendOtp({required BuildContext context}) async {
    if (phoneNumber.text.isNotEmpty && phoneNumber.text.length == 10) {
      setState(() {
        isLoading = true;
      });

      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          verificationCompleted: (phoneAuthCredential) {},
          verificationFailed: (error) {
            log(error.toString());
            showSnackBar(context,'Verification failed. Please try again.');
            setState(() {
              isLoading = false;
            });
          },
          codeSent: (verificationId, forceResendingToken) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(number: phoneNumber.text, verificationId: verificationId),
              ),
            );
            setState(() {
              isLoading = false;
            });
          },
          codeAutoRetrievalTimeout: (verificationId) {
            log("auto retrievel");
          },
          phoneNumber: "+91${phoneNumber.text}",
        );
      } catch (e) {
        showSnackBar(context,'Error sending OTP. Please try again.');
        setState(() {
          isLoading = false;
        });
      }
    } else {
      showSnackBar(context,'Please check the mobile number');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Colors.black;
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,)),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.1),
        child: Column(
          children: [
            Form(
              key:_formKey ,
              child: SizedBox(
                width: width * 0.8,
                height: height * 0.08,
                child: TextFormField(
                  cursorColor: Colors.orange,
                  maxLength: 10,
                  autofillHints: const [AutofillHints.name],
                  validator: (value) {
                    var val = value ?? '';
                    if (val.isEmpty) {
                      return 'Please enter Mobile Number';
                    }
                    else if (value?.length != 10){
                      return 'Mobile Number must be of 10 digit';

                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  controller: phoneNumber,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(
                      fontFamily: 'Lexend Deca',
                      color: const Color(0xFF57636C),
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.normal,
                    ),
                    hintText: 'Please Enter Phone Number',
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
            ),
            Spacer(),
            isLoading
                ? Center(
                child: CircularProgressIndicator())
                :GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  print("sssssssssssssssssssssssssss");
                  sendOtp(context: context);
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
                      "Send OTP",
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
    ));
  }
}