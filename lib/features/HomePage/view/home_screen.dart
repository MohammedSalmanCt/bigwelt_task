import 'dart:io';
import 'package:bigwelt_task/core/constants/asset_constants.dart';
import 'package:bigwelt_task/core/constants/firebase_constants.dart';
import 'package:bigwelt_task/core/utils.dart';
import 'package:bigwelt_task/features/Authentication/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/global_variables/global_variables.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key,required this.userModel});
 late  UserModel userModel;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// location variable
  String location = "";
  bool loading=false;

  /// getCurrentLocation
  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        location = "Location services are disabled.";
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          location = "Location permissions are denied.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        location = "Location permissions are permanently denied.";
      });
      return;
    }

    // When we reach here, permissions are granted and we can access the location.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Convert the latitude and longitude to an address
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark place = placemarks[0];

    setState(() {
      location = "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
    });
  }
  /// image update
  imageUpdate(context) async {
    try {
      setState(() {
        loading = true;
      });
      final imageFile = await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);
      if (imageFile != null) {
        final file = File(imageFile.path);
        final ref = FirebaseStorage.instance.ref().child("profile/${DateTime.now().microsecondsSinceEpoch}");
        UploadTask uploadTask = ref.putFile(file);
        final snapshot = await uploadTask;
        final imgUrl = await snapshot.ref.getDownloadURL();

        UserModel updatedUserModel = widget.userModel.copyWith(profile: imgUrl);

        await FirebaseFirestore.instance
            .collection(FirebaseConstants.userCollections)
            .doc(widget.userModel.id)
            .update(updatedUserModel.toMap());

        setState(() {
          widget.userModel = updatedUserModel;
          loading = false;
        });

        showSnackBar(context, "Profile Updated successfully");
      } else {
        setState(() {
          loading = false;
        });
        showSnackBar(context, "No image selected");
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      showSnackBar(context, "Error updating profile: ${e.toString()}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child:Padding(
          padding:  EdgeInsets.only(bottom: width*(0.08),right: width*(0.05),left: width*(0.05),top: width*(0.05)),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  GoogleSignIn().signOut();
                Navigator.pop(context);
                },
                   child: Icon(Icons.arrow_back,)),
                  Spacer(),
                  Expanded(
                    child: Text("${location != "" ?location :"Location Fetching..."}",style: TextStyle(color: CupertinoColors.black,fontSize:width*(0.045)),
                    ),
                  ),
                  SizedBox(width: 3,),
                  Icon(Icons.location_on_outlined,color: CupertinoColors.activeBlue,size: width*(0.07),)
                ],
              ),
              SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     loading==false?widget.userModel.profile!=""? CircleAvatar(
                        backgroundImage: NetworkImage(widget.userModel.profile),
                        radius: width*(0.2),
                      )
                     :CircleAvatar(
                       backgroundColor: Colors.blue,
                       radius: width*(0.2),
                     )
                      :CircleAvatar(
                         radius: width*(0.2),
                         child: CircularProgressIndicator()),
                      TextButton(onPressed: ()  {
                         imageUpdate(context);
                      },
                        child: Text("Edit",style: TextStyle(color: Colors.blue,fontSize: width*(0.04),decoration:TextDecoration.underline,decorationColor: Colors.blue),),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text("Name : ${widget.userModel.name!=""?widget.userModel.name:"............"}",style: TextStyle(fontSize: width*(0.05)),),
                 SizedBox(height: 8,),
                 Text("Phone : ${widget.userModel.phoneNumber!=""?widget.userModel.phoneNumber:"..............."}",style: TextStyle(fontSize: width*(0.05)),),
                  SizedBox(height: 8,),
                  Text("Email : ${widget.userModel.email!=""?widget.userModel.name:".................."}",style: TextStyle(fontSize: width*(0.05)),),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
