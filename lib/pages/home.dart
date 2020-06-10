import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/pages/create_account.dart';
import 'package:fluttershare/pages/profile.dart';
import 'package:fluttershare/pages/search.dart';
import 'package:fluttershare/pages/upload.dart';
import 'package:fluttershare/screens/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_icons/line_icons.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final StorageReference storageRef = FirebaseStorage.instance.ref();
final usersRef = Firestore.instance.collection("users");
final postsRef = Firestore.instance.collection("posts");
final DateTime timestamp = DateTime.now();
User currentUser;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;
  int selectedIndex = 0;

  //call this method on click of each bottom app bar item to update the screen
  void updateTabSelection(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Error signing in 1: $err');
    });
    // Re-authenticate user when app is open
    // googleSignIn.signInSilently(suppressErrors: false).then((account) {
    //   handleSignIn(account);
    // }).catchError((error) {
    //   print('Error signing in 2: $error');
    // });
  }

  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      createUserInFirestore();
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  createUserInFirestore() async {
    // 1. check if user exists in users collection in database
    final GoogleSignInAccount user = googleSignIn.currentUser;
    DocumentSnapshot doc = await usersRef.document(user.id).get();

    // 2. if the user doesn't exist take them to create account page
    if (!doc.exists) {
      final username = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateAccount(),
          ));
      // 3. get username from create account, use it to make new document in users collection
      usersRef.document(user.id).setData({
        "id": user.id,
        "username": username,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "timestamp": timestamp,
      });
    }
    doc = await usersRef.document(user.id).get();
    currentUser = User.fromDocument(doc);
    print(currentUser);
    print(currentUser.username);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
//    if (pageIndex == 2) {
//      Navigator.push(
//        context,
//        MaterialPageRoute(builder: (BuildContext context) => CameraScreen()),
//      );
//    }
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.bounceIn,
    );
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      backgroundColor: Color(0xffF4F4FA),
      body: SafeArea(
        child: PageView(
          children: <Widget>[
            // Timeline(),
            RaisedButton(
              child: Text('Logout'),
              onPressed: logout,
            ),
            HomeScreen(),
            Upload(currentUser: currentUser),
            Search(),
            Profile(profileId: currentUser?.id),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(LineIcons.whatsapp, size: 20.0),
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: <Widget>[
                Icon(
                  LineIcons.comments,
                  size: 20.0,
                ),
                Positioned(
                  right: 0,
                  child: new Container(
                    padding: EdgeInsets.all(1),
                    decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        border: Border.all(color: Colors.white, width: 1)),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: new Text(
                      '2',
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.camera, size: 35.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.search, size: 20.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.user, size: 20.0),
          ),
        ],
      ),
    );
  }

  Widget buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash.jpg"),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.8), BlendMode.darken),
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'FlutterShare',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 40.0,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: login,
              child: Container(
                padding: EdgeInsets.only(top: 10.0),
                child: SvgPicture.asset(
                  'assets/images/google_signin_button.svg',
                  height: 50.0,
                  width: 250.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: login,
              child: Container(
                padding: EdgeInsets.only(top: 10.0),
                child: SvgPicture.asset(
                  'assets/images/facebook_signin_button.svg',
                  height: 50.0,
                  width: 250.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //return isAuth ? buildAuthScreen() : buildUnAuthScreen();
    return buildAuthScreen();
  }
}
