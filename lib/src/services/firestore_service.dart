import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:stacked_firebase/src/models/post.dart';
import 'package:stacked_firebase/src/models/user.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');
  final CollectionReference _postsCollectionReference =
      Firestore.instance.collection('posts');

  final StreamController<List<Post>> _postsController =
      StreamController<List<Post>>.broadcast();

  Future<dynamic> createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future<dynamic> getUser(String uid) async {
    try {
      final DocumentSnapshot userData =
          await _usersCollectionReference.document(uid).get();
      return User.fromData(userData.data);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future<dynamic> addPost(Post post) async {
    try {
      await _postsCollectionReference.add(post.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future<dynamic> getPostsOnceOff() async {
    try {
      final QuerySnapshot postDocumentSnapshot =
          await _postsCollectionReference.getDocuments();
      if (postDocumentSnapshot.documents.isNotEmpty) {
        return postDocumentSnapshot.documents
            .map((DocumentSnapshot snapshot) =>
                Post.fromMap(snapshot.data, snapshot.documentID))
            .where((Post mappedItem) => mappedItem.title != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Stream<List<Post>> listenToPostsRealTime() {
    // Register the handler for when the posts data changes
    _postsCollectionReference.snapshots().listen((QuerySnapshot postsSnapshot) {
      if (postsSnapshot.documents.isNotEmpty) {
        final List<Post> posts = postsSnapshot.documents
            .map((DocumentSnapshot snapshot) =>
                Post.fromMap(snapshot.data, snapshot.documentID))
            .where((Post mappedItem) => mappedItem.title != null)
            .toList();

        // Add the posts onto the controller
        _postsController.add(posts);
      }
    });

    return _postsController.stream;
  }

  Future<dynamic> deletePost(String documentId) async {
    try {
      final Post postToDelete = await getPost(documentId) as Post;
      postToDelete.isDeleted = true;

      await _postsCollectionReference
          .document(documentId)
          .updateData(postToDelete.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future<dynamic> updatePost(Post post) async {
    try {
      await _postsCollectionReference
          .document(post.documentId)
          .updateData(post.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future<dynamic> getPost(String documentId) async {
    try {
      final QuerySnapshot postDocumentSnapshot =
          await _postsCollectionReference.getDocuments();
      if (postDocumentSnapshot.documents.isNotEmpty) {
        return postDocumentSnapshot.documents
                .map((DocumentSnapshot snapshot) =>
                    Post.fromMap(snapshot.data, snapshot.documentID))
                .where((Post mappedItem) => mappedItem.documentId == documentId)
            as Post;
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}
