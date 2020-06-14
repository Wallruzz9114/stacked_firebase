import 'package:stacked/stacked.dart';
import 'package:stacked_firebase/src/app/locator.dart';
import 'package:stacked_firebase/src/models/post.dart';
import 'package:stacked_firebase/src/models/routes/routes.dart';
import 'package:stacked_firebase/src/services/cloud_storage_service.dart';
import 'package:stacked_firebase/src/services/firestore_service.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  List<Post> _posts;
  List<Post> get posts => _posts;

  // Future<dynamic> fetchPosts() async {
  //   setBusy(true);
  //   final dynamic postsResults = await _firestoreService.getPostsOnceOff();
  //   setBusy(false);

  //   if (postsResults is List<Post>) {
  //     _posts = postsResults;
  //     notifyListeners();
  //   } else {
  //     await _dialogService.showDialog(
  //         title: 'Error while fetching posts',
  //         description: postsResults.toString());
  //   }
  // }

  Future<dynamic> deletePost(int index) async {
    final DialogResponse dialogResponse =
        await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Do you really want to delete the post?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse.confirmed) {
      final String imageUrl = _posts[index].imageUrl;

      setBusy(true);
      await _firestoreService.deletePost(_posts[index].documentId);
      await _cloudStorageService.deleteImage(imageUrl);
      setBusy(false);
    }
  }

  Future<dynamic> navigateToCreateView() async {
    await _navigationService.navigateTo(Routes.createPostViewRoute);
  }

  void editPost(int index) {
    _navigationService.navigateTo(
      Routes.createPostViewRoute,
      arguments: _posts[index],
    );
  }

  void listenToPosts() {
    setBusy(true);

    _firestoreService.listenToPostsRealTime().listen((List<Post> postsData) {
      final List<Post> updatedPosts = postsData;

      if (updatedPosts != null && updatedPosts.isNotEmpty) {
        _posts = updatedPosts;
        notifyListeners();
      }

      setBusy(false);
    });
  }
}
