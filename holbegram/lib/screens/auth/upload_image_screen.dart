import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../methods/auth_methods.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/utils.dart';
import '../home_screen.dart';

class AddPicture extends StatefulWidget {
  final String email;
  final String password;
  final String username;

  const AddPicture({
    Key? key,
    required this.email,
    required this.password,
    required this.username,
  }) : super(key: key);

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  Uint8List? _image;
  bool _isLoading = false;

  @override
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }


  void postImage() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await AuthMethods().SignUpUser(
        email: widget.email,
        password: widget.password,
        username: widget.username,
        file: _image!,
      );
      setState(() {
        _isLoading = false;
      });
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(context, 'Post uploaded successfully');
        clearImage();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(context, res);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, e.toString());
    }
  }


  void clearImage() {
    setState(() {
      _image = null;
    });
  }

  _selectImageFromCamera(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(title: const Text('Take a Picture'), children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Take a photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _image = file;
                });
              },
            ),
          ]);
        });
  }

  _selectImageFromGallery(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
              title: const Text('Choose from your gallery'),
              children: [
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Text('Choose a Picture'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List file = await pickImage(ImageSource.gallery);
                    setState(() {
                      _image = file;
                    });
                  },
                ),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    final String username = widget.username;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 0,
              child: Container(
                alignment: Alignment.center,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Holbegram',
                      style: TextStyle(
                        fontFamily: 'Billabong',
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image(
                      image: AssetImage('assets/images/logo.jpg'),
                      width: 80,
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: Text(
                    'Hello, $username Welcome to Holbegram!',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Choose image from your gallery or take a new one',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                _image != null
                    ? CircleAvatar(
                        radius: 100,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const Image(
                        image: AssetImage('assets/images/Sample.png'),
                        width: 200,
                        height: 200,
                      ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => _selectImageFromCamera(context),
                      icon: const Icon(
                        Icons.photo,
                        size: 30,
                        color: Color.fromARGB(218, 226, 37, 24),
                      ),
                    ),
                    const SizedBox(width: 80),
                    IconButton(
                      onPressed: () => _selectImageFromGallery(context),
                      icon: const Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: Color.fromARGB(218, 226, 37, 24),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(218, 226, 37, 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: postImage,
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Flexible(
              flex: 0,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
