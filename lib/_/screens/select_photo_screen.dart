import 'dart:typed_data';

import 'package:image_picker_plus/image_picker_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../resources/firestore_methods.dart';
import '../utils/utils.dart';

class SelectPhoto extends StatefulWidget {
  const SelectPhoto({Key? key}) : super(key: key);
  @override
  State<SelectPhoto> createState() => _SelectPhotoState();
}

class _SelectPhotoState extends State<SelectPhoto> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: const Text("kombinini oluştur ve yükle "),
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

class DisplayImages extends StatefulWidget {
  final List<SelectedByte> selectedBytes;
  final double aspectRatio;
  final SelectedImagesDetails details;
  const DisplayImages({
    Key? key,
    required this.details,
    required this.selectedBytes,
    required this.aspectRatio,
  }) : super(key: key);

  @override
  State<DisplayImages> createState() => _DisplayImagesState();
}

class _DisplayImagesState extends State<DisplayImages> {
  Uint8List? _file;
  bool isLoading = false;

  final TextEditingController _descriptionController = TextEditingController();
  void postImage(String uid, String username, String profImage,
      Uint8List selectpth) async {
    setState(() {
      isLoading = true;
      //print("post tusuna bastım");
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        selectpth,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        // ignore: use_build_context_synchronously
        showSnackBar(
          context,
          'Posted!',
        );
        clearImage();
      } else {
        // ignore: use_build_context_synchronously
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    SelectedByte selectedByte = widget.selectedBytes[0];
    //print(selectedByte.selectedFile.readAsBytesSync());
    //print("bunbun");
    //_file= widget.selectedBytes[0];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected images'),
        actions: <Widget>[
          TextButton(
            onPressed: () => postImage(
              userProvider.getUser.uid,
              userProvider.getUser.username,
              userProvider.getUser.photoUrl,
              selectedByte.selectedFile.readAsBytesSync(),
            ),
            child: const Text(
              "Post",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          )
        ],
      ),
      // body: ListView.builder(
      //   itemCount: widget.selectedBytes.length,
      //   itemBuilder: (context, index) {
      //     SelectedByte selectedByte = widget.selectedBytes[index];

      //     if (!selectedByte.isThatImage) {
      //       return SizedBox(
      //         width: double.infinity,
      //         child: Container(),
      //       );
      //     } else {
      //       return SizedBox(
      //         width: double.infinity,
      //         child: Image.file(selectedByte.selectedFile),
      //       );
      //     }
      //   },
      // ),
      body: Column(
        children: <Widget>[
          isLoading
              ? const LinearProgressIndicator()
              : const Padding(padding: EdgeInsets.only(top: 0.0)),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 150.0,
                width: 150.0,
                child: AspectRatio(
                  aspectRatio: 487 / 451,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.fill,
                      alignment: FractionalOffset.topCenter,
                      image: MemoryImage(
                          selectedByte.selectedFile.readAsBytesSync()),
                    )),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      hintText: "Write a caption...", border: InputBorder.none),
                  maxLines: 8,
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
