import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  String photoUrl;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<String> getPhotoUrl() async {
    var user = firebaseAuth.currentUser.email;
    String url;
    firebase_storage.ListResult list = await storage.ref("$user/picture").listAll();
    if (list.items.isNotEmpty) {
      url = await storage.ref("$user/picture/avatar.png").getDownloadURL();
      setState(() {
        photoUrl = url;
      });
    } else {
      setState(() {
        photoUrl = "https://i.ibb.co/JQXS1m8/profile.png";
      });
    }
  }

  Future<void> uploadPhoto(BuildContext context) async {
    var user = firebaseAuth.currentUser.email;
    File _imageFile;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    try {
      _imageFile = File(pickedFile.path);
      firebase_storage.UploadTask uploadTask = storage.ref("$user/picture/avatar.png").putFile(_imageFile);
      setState(() {});
    } catch (e) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPhotoUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFACD),
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "My Profile",
            style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
              color: Color(0xFFD78B0D),
              fontSize: 24,
            ),
          ),
        ),
        backgroundColor: Color(0xFFFFF67D),
        iconTheme: IconThemeData(color: Color(0xFFD78B0D)),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipRect(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height* 0.25,
                  child: Image.asset(
                    "assets/img/bottom_splash_screen.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          FutureBuilder<QuerySnapshot>(
              //Get User Data
              future: users.where('email', isEqualTo: firebaseAuth.currentUser.email).get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var document = snapshot.data.docs;
                var userDocument = document[0].data();

                return Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        height: 140,
                        width: 140,
                        alignment: Alignment.bottomRight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          border: Border.all(
                            color: Color(0xFFFFF67D),
                            width: 3,
                          ),
                          image: DecorationImage(image: NetworkImage(photoUrl.toString()), fit: BoxFit.fill),
                        ),
                        child: GestureDetector(
                          onTap: () => uploadPhoto(context),
                          child: Container(
                              height: 30,
                              width: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xFFD78B0D),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    offset: Offset(0, 0),
                                    color: Colors.black.withOpacity(0.25),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.photo_camera_rounded,
                                color: Color(0xFFFEFACD),
                              )),
                        )),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        userDocument["username"].toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10),
                      width: 240,
                      height: 0,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Color(0xFFD78B0D),
                        width: 2,
                      )),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        userDocument["email"].toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      width: 280,
                      height: 80,
                      margin: EdgeInsets.only(top: 150, left: 25, right: 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(52),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.25),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                          onPressed: () async {
                            await firebaseAuth.signOut().then(
                                  (value) => {
                                    Navigator.pushReplacementNamed(context, '/login'),
                                  },
                                );
                          },
                          child: Text(
                            "Log Out",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFFFFDF9),
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color(0xFFEE9B0F)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(52),
                                ),
                              ))),
                    )
                  ],
                );
              }),
        ],
      ),
    );
  }
}
