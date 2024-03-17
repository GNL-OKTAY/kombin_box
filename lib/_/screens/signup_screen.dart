// ignore_for_file: use_build_context_synchronously, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../language/language_items.dart';
import '../reesponsive/mobile_screen_layout_ex.dart';
import '../resources/auth_methods.dart';
import '../screens/login_screen.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import '../widgets/text_fild_input.dart';
import '../reesponsive/responsive_layout_screen.dart';
import '../reesponsive/web_screen_layout.dart';

class SingupSreen extends StatefulWidget {
  const SingupSreen({super.key});

  @override
  State<SingupSreen> createState() => _SingupSreenState();
}

class _SingupSreenState extends State<SingupSreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().singUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(context, res);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayoutEx: MobileScreenLayoutEx(),
              )));
    }
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginSreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            //svg image
            SvgPicture.asset(
              'assets/kombinbox_logo.svg',
              color: primaryColor,
              height: 64,
            ),
            const SizedBox(height: 64),
            // circular widget to accept and show our selected file
            Stack(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64, backgroundImage: MemoryImage(_image!))
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://yt3.ggpht.com/ytc/AMLnZu9NLXtoD59iOc9c9Fon_PkUSOBu-iRgcSxOdczq=s900-c-k-c0x00ffffff-no-rj'),
                      ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ))
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                //text field input kullanıcı adı
                TextFieldInput(
                    textEditingController: _usernameController,
                    hintText: LanguageItems.userName,
                    textInputType: TextInputType.text),
                const SizedBox(
                  height: 24,
                ),
                // text field input e mail
                TextFieldInput(
                    textEditingController: _emailController,
                    hintText: LanguageItems.mailTitle,
                    textInputType: TextInputType.text),
                const SizedBox(
                  height: 24,
                ),
                // text field input şifre
                TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: LanguageItems.passWord,
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                // text field input bio
                TextFieldInput(
                    textEditingController: _bioController,
                    hintText: LanguageItems.bioText,
                    textInputType: TextInputType.text),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
            //buton login
            InkWell(
              onTap: signUpUser,
              child: Container(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text(LanguageItems.singUpText),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    color: blueColor),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text(LanguageItems.hesapYokVar),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                ),
                GestureDetector(
                  onTap: navigateToLogin,
                  child: Container(
                    child: const Text(
                      LanguageItems.logIn,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
