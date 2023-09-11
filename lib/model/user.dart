import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String bio;
  final String username;
  final String photoUrl;
  final String uid;
  final List followers;
  final List following;

  const User ({
    required this.email,
    required this.bio,
    required this.username,
    required this.photoUrl,
    required this.uid,
    required this.followers,
    required this.following,
});

  Map<String, dynamic> toJason() => {
    "username": username,
    "uid": uid,
    "email": email,
    "photoUrl": photoUrl,
    "bio": bio,
    "followers": followers,
    "following": following
  };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      bio: snapshot['bio'],
      photoUrl: snapshot['photoUrl'],
      email: snapshot['email'],
      following: snapshot['following'],
      followers: snapshot['followers'],
    );
  }
}