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

  // #6: Create a list that will keep the paged results
  final List<List<Post>> _allPagedResults = <List<Post>>[];

  static const int postsLimit = 20;

  DocumentSnapshot _lastDocument;
  bool _hasMorePosts = true;

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
    _requestPosts();
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

  void requestMoreData() => _requestPosts();

  // #1: Move the request posts into it's own function
  void _requestPosts() {
    // #2: split the query from the actual subscription
    Query pagePostsQuery = _postsCollectionReference
        .orderBy('title')
        // #3: Limit the amount of results
        .limit(postsLimit);

    // #5: If we have a document start the query after it
    if (_lastDocument != null) {
      pagePostsQuery = pagePostsQuery.startAfterDocument(_lastDocument);
    }

    if (!_hasMorePosts) {
      return;
    }

    // #7: Get and store the page index that the results belong to
    final int currentRequestIndex = _allPagedResults.length;

    pagePostsQuery.snapshots().listen((QuerySnapshot postsSnapshot) {
      if (postsSnapshot.documents.isNotEmpty) {
        final List<Post> posts = postsSnapshot.documents
            .map((DocumentSnapshot snapshot) =>
                Post.fromMap(snapshot.data, snapshot.documentID))
            .where((Post mappedItem) => mappedItem.title != null)
            .toList();

        // #8: Check if the page exists or not
        final bool pageExists = currentRequestIndex < _allPagedResults.length;

        // #9: If the page exists update the posts for that page
        if (pageExists) {
          _allPagedResults[currentRequestIndex] = posts;
        }
        // #10: If the page doesn't exist add the page data
        else {
          _allPagedResults.add(posts);
        }

        // #11: Concatenate the full list to be shown
        final List<Post> allPosts = _allPagedResults.fold<List<Post>>(
            <Post>[],
            (List<Post> initialValue, List<Post> pageItems) =>
                initialValue..addAll(pageItems));

        // #12: Broadcase all posts
        _postsController.add(allPosts);

        // #13: Save the last document from the results only if it's the current last page
        if (currentRequestIndex == _allPagedResults.length - 1) {
          _lastDocument = postsSnapshot.documents.last;
        }

        // #14: Determine if there's more posts to request
        _hasMorePosts = posts.length == postsLimit;
      }
    });
  }
}
