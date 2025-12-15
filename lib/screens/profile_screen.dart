import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wisata_candi/widgets/profile_info_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSignedIn = false;
  String fullName = 'Jessen Cornelius';
  String username = 'jessen';
  int favoriteCandiCount = 10;

  void signIn() {
    // setState(() {
    //   isSignedIn = !isSignedIn;
    // });
    Navigator.pushNamed(context, '/signin');
  }

  void signOut() {
    setState(() {
      isSignedIn = !isSignedIn;
    });
  }

  String _imageFile = '';
  final picker = ImagePicker();
  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile.path;
      });
    }
  }

  void _showPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            ListTile(
              title: Text(
                'Image Source',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.photo_library_outlined),
              title: Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop(_getImage(ImageSource.gallery));
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library_outlined),
              title: Text("Camera"),
              onTap: () {
                Navigator.of(context).pop(_getImage(ImageSource.camera));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.deepPurple,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 200 - 50),
              child: Column(
                children: [
                  // TODO: 1. header profile
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.deepPurple,
                            width: 1,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _imageFile.isNotEmpty
                              ? FileImage(File(_imageFile))
                              : null,
                          child: _imageFile.isEmpty
                              ? Icon(Icons.person, size: 50)
                              : null,
                        ),
                      ),
                      if (isSignedIn)
                        IconButton(
                          onPressed: _showPicker,
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.deepPurple[50],
                          ),
                        ),
                    ],
                  ),
                  // TODO : profile info
                  SizedBox(height: 20),
                  Divider(color: Colors.deepPurple[100]),
                  SizedBox(height: 4),
                  ProfileInfoItem(
                    icon: Icons.lock,
                    label: 'Pengguna',
                    value: username,
                    iconColor: Colors.amber,
                  ),
                  SizedBox(height: 4),
                  Divider(color: Colors.deepPurple[100]),
                  SizedBox(height: 4),
                  ProfileInfoItem(
                    icon: Icons.person,
                    label: 'Nama',
                    value: fullName,
                    iconColor: Colors.blue,
                    showEditIcon: isSignedIn,
                    onEditPressed: () {
                      debugPrint('Icon Edit Ditekan...');
                    },
                  ),
                  SizedBox(height: 4),
                  Divider(color: Colors.deepPurple[100]),
                  SizedBox(height: 4),
                  ProfileInfoItem(
                    icon: Icons.favorite,
                    label: "Favorit",
                    value: favoriteCandiCount > 0 ? '$favoriteCandiCount' : '',
                    iconColor: Colors.red,
                  ),
                  // todo : membuat profile action
                  SizedBox(height: 4),
                  Divider(color: Colors.deepPurple[100]),
                  SizedBox(height: 4),
                  isSignedIn
                      ? TextButton(onPressed: signOut, child: Text("Sign Out"))
                      : TextButton(onPressed: signIn, child: Text("Sign In")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
