import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instg_clone/utils/colors.dart';
import 'package:instg_clone/utils/utils.dart';
import 'package:provider/provider.dart';
import '../model/user.dart';
import '../proviers/user_provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? _file;

  _selectImage(BuildContext context) async {
    final Uint8List? file = await showDialog<Uint8List?>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Create a post'),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text('Pick a photo'),
              onPressed: () async {
                Navigator.of(context).pop(await pickImage(ImageSource.camera));
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text('Choose from gallery'),
              onPressed: () async {
                Navigator.of(context).pop(await pickImage(ImageSource.gallery));
              },
            ),
          ],
        );
      },
    );

    if (file != null) {
      setState(() {
        _file = file;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context, listen: false).getUser;
    final String userPhotoUrl = user.photoUrl ?? '';

    return _file == null
        ? Center(
            child: Container(
            child: IconButton(
              icon: Icon(Icons.upload),
              onPressed: () => _selectImage(context),
            ),
          ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {},
              ),
              title: Text('Post to'),
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Post',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(userPhotoUrl),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Write caption',
                              border: InputBorder.none),
                          maxLines: 8,
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        width: 45,
                        child: AspectRatio(
                          aspectRatio: 487 / 451,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://images.unsplash.com/photo-1692712824888-653531b082ee?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80'),
                                    fit: BoxFit.fill,
                                    alignment: FractionalOffset.topCenter)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider()
              ],
            ),
          );
  }
}
