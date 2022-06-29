import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Post {
  final String description;
  final String uid;
  final String postId;
  final String username;
  final datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.postUrl,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.profImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "description": description,
        "postUrl": postUrl,
        "profImage": profImage,
        "datePublished": datePublished,
        "following": likes,
        "postId": postId,
      };
  static Post fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        description: snapshot['description'],
        uid: snapshot['uid'],
        postId: snapshot['postId'],
        username: snapshot['username'],
        datePublished: snapshot['datePublished'],
        likes: snapshot['likes'],
        profImage: snapshot['profImage'],
        postUrl: snapshot['postUrl']);
  }
}
