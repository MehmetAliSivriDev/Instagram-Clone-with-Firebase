import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/service/base_service.dart';
import '../service/add_service.dart';

import '../../../core/routes/routes.dart';
import '../../../product/util/image_upload_manager.dart';

class AddViewModel extends ChangeNotifier {
  void init() {
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  //Post - Reels Navigation
  late PageController _pageController;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;
  PageController get pageController => _pageController;

  void onPageChanged(int page) {
    _currentIndex = page;
    notifyListeners();
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
    notifyListeners();
  }

  //---

  //Post

  File? imageFile;

  List<XFile>? imageFiles;
  List<Widget>? images;

  IBaseService _baseService = BaseService();
  IAddService _addService = AddService();

  bool isLoading = false;

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  File? getSingleImage() {
    if (imageFiles != null) {
      return imageFiles!
          .map((XFile imageFile) => File(imageFile.path))
          .toList()
          .first;
    }
    return null;
  }

  Future<void> imagesUpload() async {
    List<XFile>? uploadedImages = await ImageUploadManager().uploadImages();

    // ignore: unnecessary_null_comparison
    if (uploadedImages != null && uploadedImages.isNotEmpty) {
      imageFiles = uploadedImages;
      imagesToWidget();
      notifyListeners();
    }
  }

  void imagesToWidget() {
    images = imageFiles!
        .map((XFile imageFile) => Image.file(
              File(imageFile.path),
              fit: BoxFit.cover,
            ))
        .toList();
  }

  Future<void> uploadPost(
      {required BuildContext context,
      required String caption,
      required String location,
      required File file}) async {
    changeLoading();
    String post_url =
        await _baseService.uploadImageToStorage(name: 'post', file: file);

    await _addService.createPost(
        postImage: post_url, caption: caption, location: location);
    changeLoading();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.NAVIGATION, (route) => false);
    }
  }

  //Photomanager code (not working)

  // List<Widget> mediaList = [];
  // List<File> path = [];
  // File? file;

  // Future<void> addPostInit() async {
  //   await fetchNewMedia();
  // }

  // Future<void> fetchNewMedia() async {
  //   print("giriş");
  //   final PermissionState ps = await PhotoManager.requestPermissionExtend();

  //   if (ps.isAuth) {
  //     List<AssetPathEntity> album =
  //         await PhotoManager.getAssetPathList(onlyAll: true);
  //     List<AssetEntity> media =
  //         await album[0].getAssetListPaged(page: currentIndex, size: 60);

  //     for (var asset in media) {
  //       if (asset.type == AssetType.image) {
  //         final fileA = await asset.file;
  //         if (fileA != null) {
  //           path.add(File(fileA.path));
  //           file = path[0];
  //         }
  //       }
  //     }
  //     List<Widget> temp = [];
  //     for (var asset in media) {
  //       temp.add(FutureBuilder(
  //         future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState == ConnectionState.done) {
  //             return Container(
  //               child: Stack(
  //                 children: [
  //                   Positioned.fill(
  //                       child: Image.memory(
  //                     snapshot.data!,
  //                     fit: BoxFit.cover,
  //                   ))
  //                 ],
  //               ),
  //             );
  //           }
  //           return Container();
  //         },
  //       ));
  //     }
  //     mediaList.addAll(temp);
  //     print("dememe");
  //     notifyListeners();
  //   }
  //   print("dememe 2");
  // }
}
