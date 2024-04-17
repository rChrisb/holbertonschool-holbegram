import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../methods/firestore_method.dart';
import '../../providers/user_provider.dart';
import '../../widgets/utility/global_variable.dart';
import '../../widgets/utils.dart';
import '../../models/user.dart' as model;

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddImage> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
      );

      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(context, 'Post uploaded successfully');
        clearImage();
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

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(title: const Text('Create a post'), children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Take a photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Choose from Gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ]);
        });
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
    final model.User user = Provider.of<UserProvider>(context).getUser;

    if (_file != null) {
      postImage(user.uid, user.username, user.photoUrl);
    }

    return _file == null
        ? Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Holbegram',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'Billabong',
                    ),
                  ),
                  Image.asset(
                    'assets/images/logo.jpg',
                    height: 32,
                  ),
                ],
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    'Post',
                    style: TextStyle(
                      fontFamily: 'Billabong',
                      color: primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                const Text(
                  'Add Image',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Choose an image from your gallery or take a photo',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                Column(
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          _selectImage(context);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Image(
                                image:
                                    AssetImage('assets/images/iconupload.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title:  Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Holbegram',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'Billabong',
                    ),
                  ),
                  Image.asset(
                    'assets/images/logo.jpg',
                    height: 32,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    postImage(user.uid, user.username, user.photoUrl);
                  },
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      color: primaryColor,
                      fontFamily: 'Billabong',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                const Divider(),
                const Text(
                  'Add Image',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Choose an image from your gallery or take a photo',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Column(
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          _selectImage(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Column(
                            children: [
                              TextField(
                                controller: _descriptionController,
                                decoration: const InputDecoration(
                                  hintText: 'write caption...',
                                  border: InputBorder.none,
                                ),
                                maxLines: 8,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(
                                    image: MemoryImage(_file!),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
