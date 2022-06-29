import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/resources/auth_method.dart';
import 'package:insta_clone/responsive/mobilescreenlayout.dart';
import 'package:insta_clone/responsive/responsive_layout.dart';
import 'package:insta_clone/responsive/webscreenlayout.dart';
import 'package:insta_clone/screens/login_screen.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:insta_clone/widgets/textfield.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _biocontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  Uint8List? _Image;
  bool _isloading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _biocontroller.dispose();
    _usernamecontroller.dispose();
  }

  void selectimage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _Image = img;
    });
  }

  void signupuser() async {
    setState(() {
      _isloading = true;
    });

    String res = await Authmethod().signUpuser(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
      username: _usernamecontroller.text,
      bio: _biocontroller.text,
      file: _Image!,
    );

    // print(res);
    if (res != 'success') {
      showsnackbar(res, context);
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout()),
      ));
    }
  }

  void gotologin() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: ((context) => const LoginScreen()),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  color: primaryColor,
                  height: 64,
                ),
                const SizedBox(
                  height: 64,
                ),
                Stack(
                  children: [
                    _Image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_Image!),
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgd3SjY4Nowsfr0xD4xuKlGPzg33fkgC7ySw5GBdI5Nj3ug9qfAOmUBxylxysL_4brpDE&usqp=CAU'),
                          ),
                    Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                            onPressed: () {
                              selectimage();
                            },
                            icon: const Icon(
                              Icons.add_a_photo,
                            )))
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Textfieldinput(
                    hintText: "Enter Your Username",
                    textEditingController: _usernamecontroller,
                    textInputType: TextInputType.text),
                const SizedBox(
                  height: 24,
                ),
                Textfieldinput(
                    hintText: "Enter Your Email",
                    textEditingController: _emailcontroller,
                    textInputType: TextInputType.emailAddress),
                const SizedBox(
                  height: 24,
                ),
                Textfieldinput(
                  hintText: "Enter Your Password",
                  textEditingController: _passwordcontroller,
                  textInputType: TextInputType.text,
                  ispass: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                Textfieldinput(
                    hintText: "Enter Your Bio",
                    textEditingController: _biocontroller,
                    textInputType: TextInputType.text),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: signupuser,
                  child: Container(
                    child: _isloading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text('Sign Up'),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      )),
                      color: blueColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Flexible(
                  child: Container(),
                  flex: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text("Already have an account?"),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                    GestureDetector(
                      onTap: gotologin,
                      child: Container(
                        child: const Text("Login",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
