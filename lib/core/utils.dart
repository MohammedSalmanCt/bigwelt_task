import 'package:flutter/material.dart';

void showSnackBar(BuildContext context,String message){
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Center(child: Text(message)),
      backgroundColor: Colors.black,
    ),
    );
}

