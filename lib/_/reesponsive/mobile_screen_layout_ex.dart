// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_plus/image_picker_plus.dart';
import 'package:ionicons/ionicons.dart';
import '../models/user.dart';
import '../screens/add_post_screen.dart';
import '../screens/feed_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/select_photo_screen.dart';
import '../utils/colors.dart';
import '../screens/cht/HomePage.dart';
import '../screens/ss_popup.dart';

class MobileScreenLayoutEx extends StatefulWidget {
  const MobileScreenLayoutEx({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayoutEx> createState() => _MobileScreenLayoutExState();
}

//class needs to extend StatefulWidget since we need to make changes to the bottom app bar according to the user clicks

class _MobileScreenLayoutExState extends State<MobileScreenLayoutEx> {
  int selectedIndex =
      0; //to handle which item is currently selected in the bottom app bar
  String text = "Home";
  int currentTab = 0;
  Widget currentScreen = FeedScreen();

  //call this method on click of each bottom app bar item to update the screen
  void updateTabSelection(int index, Widget selectedScreen) {
    setState(() {
      selectedIndex = index;
      currentTab = index;
      currentScreen = selectedScreen;
    });
  }

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentScreen),
      bottomNavigationBar: BottomAppBar(
        //color: Colors.white,
        child: Container(
          margin: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                //update the bottom app bar view each time an item is clicked
                onPressed: () {
                  updateTabSelection(0, FeedScreen());
                },
                iconSize: 27.0,
                icon: Icon(
                  Icons.home,
                  //darken the icon if it is selected or else give it a different color
                  color: selectedIndex == 0
                      ? PalletteColors.sysNavPriColar
                      : PalletteColors.sysNavSecColar,
                ),
              ),
              IconButton(
                onPressed: () {
                  updateTabSelection(1, const SearchScreenPop());
                },
                iconSize: 27.0,
                icon: Icon(
                  Ionicons.search,
                  color: selectedIndex == 1
                      ? PalletteColors.sysNavPriColar
                      : PalletteColors.sysNavSecColar,
                ),
              ),
              //to leave space in between the bottom app bar items and below the FAB
              // SizedBox(
              //   width: 50.0,
              // ),
              IconButton(
                onPressed: () async {
                  ImagePickerPlus picker = ImagePickerPlus(context);
                  SelectedImagesDetails? details = await picker.pickBoth(
                    source: ImageSource.both,

                    /// On long tap, it will be available.
                    multiSelection: false,

                    galleryDisplaySettings: GalleryDisplaySettings(
                        cropImage: true, showImagePreview: true),
                  );
                  if (details != null) await displayDetails(details);
                },
                iconSize: 37.0,
                icon: const Icon(Ionicons.logo_apple_ar),
              ),
              IconButton(
                //enableFeedback: false,
                //autofocus: true,
                onPressed: () {
                  updateTabSelection(2, const AddPostScreen());
                },
                iconSize: 27.0,
                icon: Icon(
                  Icons.call_received,
                  color: selectedIndex == 2
                      ? PalletteColors.sysNavPriColar
                      : PalletteColors.sysNavSecColar,
                ),
              ),
              IconButton(
                onPressed: () {
                  updateTabSelection(
                      3,
                      ProfileScreen(
                        uid: FirebaseAuth.instance.currentUser!.uid,
                      ));
                },
                iconSize: 27.0,
                icon: Icon(
                  Ionicons.person_outline,
                  color: selectedIndex == 3
                      ? PalletteColors.sysNavPriColar
                      : PalletteColors.sysNavSecColar,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> displayDetails(SelectedImagesDetails details) async {
    await Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) {
          return DisplayImages(
              selectedBytes: details.selectedFiles,
              details: details,
              aspectRatio: details.aspectRatio);
        },
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
    required this.clickedCentreFAB,
  }) : super(key: key);

  final bool clickedCentreFAB;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        //if clickedCentreFAB == true, the first parameter is used. If it's false, the second.
        height: clickedCentreFAB ? MediaQuery.of(context).size.height : 10.0,
        width: clickedCentreFAB ? MediaQuery.of(context).size.height : 10.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(clickedCentreFAB ? 0.0 : 300.0),
            color: Colors.blue),
      ),
    );
  }
}
