import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/theme_notifier.dart';
import 'profile_post_view.dart';
import '../../../product/constant/product_border_radius.dart';
import '../../../product/constant/product_padding.dart';
import '../../../product/util/cached_image.dart';
import '../../../product/util/navigator_w_animation.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import '../../../core/model/user_model.dart';
import '../../../core/service/base_service.dart';
import '../../../product/constant/product_color.dart';
import '../viewModel/profile_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    IBaseService baseService = BaseService();
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore fireStore = FirebaseFirestore.instance;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _buildCustomAppBar(),
        body: _buildBody(baseService, context, fireStore, auth),
      ),
    );
  }

  AppBar _buildCustomAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: Consumer<ProfileViewModel>(
        builder: (context, viewModel, _) {
          viewModel.getCurrentUser();

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock),
              Text(viewModel.model.username.toString(),
                  style: context.general.textTheme.titleLarge!.copyWith(
                    color: context.watch<ThemeNotifier>().isLightTheme
                        ? ProductColor.instance.black
                        : ProductColor.instance.white,
                  )),
              const Icon(Icons.arrow_drop_down)
            ],
          );
        },
      ),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
    );
  }

  Widget _buildBody(IBaseService baseService, BuildContext context,
      FirebaseFirestore fireStore, FirebaseAuth auth) {
    return SafeArea(
        child: CustomScrollView(
      slivers: [
        _buildUserInfo(baseService),
        _buildTabBar(context),
        _buildPosts(fireStore, auth),
      ],
    ));
  }

  Widget _buildPosts(FirebaseFirestore fireStore, FirebaseAuth auth) {
    return StreamBuilder(
      stream: fireStore
          .collection("posts")
          .where(
            'uid',
            isEqualTo: auth.currentUser!.uid,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return GestureDetector(
                  onTap: () {
                    NavigatorWAnimation.rightToLeft(
                        context: context,
                        widget: ProfilePostView(
                            snapshot: snapshot.data!.docs[index]));
                  },
                  child: CachedImage(
                      imageURL: snapshot.data!.docs[index]["postImage"]),
                );
              }, childCount: snapshot.data!.docs.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4));
        }
      },
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const ProductPadding.bottomLow(),
        child: SizedBox(
          width: context.sized.dynamicWidth(1),
          height: context.sized.dynamicHeight(0.05),
          child: TabBar(
              dividerHeight: 0,
              indicatorColor: context.watch<ThemeNotifier>().isLightTheme
                  ? ProductColor.instance.black
                  : ProductColor.instance.white,
              labelColor: context.watch<ThemeNotifier>().isLightTheme
                  ? ProductColor.instance.black
                  : ProductColor.instance.white,
              overlayColor:
                  MaterialStateProperty.all(ProductColor.instance.grey200),
              isScrollable: false,
              tabs: const [
                Icon(Icons.grid_on),
                Icon(Icons.account_box_rounded)
              ]),
        ),
      ),
    );
  }

  Widget _buildUserInfo(IBaseService baseService) {
    return SliverToBoxAdapter(
      child: FutureBuilder(
        future: baseService.getUser(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return _buildUserInfoBar(
                context: context, model: snapshot.data ?? UserModel());
          }
        },
      ),
    );
  }

  Widget _buildUserInfoBar(
      {required BuildContext context, required UserModel model}) {
    return SizedBox(
      width: context.sized.dynamicWidth(1),
      height: context.sized.dynamicHeight(0.28),
      child: Column(
        children: [
          Padding(
            padding: const ProductPadding.bottomLow(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipOval(
                  child: SizedBox(
                      width: context.sized.dynamicWidth(0.25),
                      height: context.sized.dynamicHeight(0.12),
                      child: CachedImage(imageURL: model.profile ?? "")),
                ),
                Column(
                  children: [
                    Consumer<ProfileViewModel>(
                      builder: (context, viewModel, _) {
                        viewModel.getCurrentUserPostCount();
                        return Text(viewModel.userPostCount.toString(),
                            style: context.general.textTheme.titleLarge!
                                .copyWith(
                                    color: context
                                            .watch<ThemeNotifier>()
                                            .isLightTheme
                                        ? ProductColor.instance.black
                                        : ProductColor.instance.white));
                      },
                    ),
                    Text("Posts",
                        style: context.general.textTheme.bodyLarge!.copyWith(
                            color: context.watch<ThemeNotifier>().isLightTheme
                                ? ProductColor.instance.black
                                : ProductColor.instance.white))
                  ],
                ),
                Column(
                  children: [
                    Text(model.followers?.length.toString() ?? "",
                        style: context.general.textTheme.titleLarge!.copyWith(
                            color: context.watch<ThemeNotifier>().isLightTheme
                                ? ProductColor.instance.black
                                : ProductColor.instance.white)),
                    Text("Followers",
                        style: context.general.textTheme.bodyLarge!.copyWith(
                            color: context.watch<ThemeNotifier>().isLightTheme
                                ? ProductColor.instance.black
                                : ProductColor.instance.white))
                  ],
                ),
                Column(
                  children: [
                    Text(model.following?.length.toString() ?? "",
                        style: context.general.textTheme.titleLarge!.copyWith(
                            color: context.watch<ThemeNotifier>().isLightTheme
                                ? ProductColor.instance.black
                                : ProductColor.instance.white)),
                    Text("Following",
                        style: context.general.textTheme.bodyLarge!.copyWith(
                            color: context.watch<ThemeNotifier>().isLightTheme
                                ? ProductColor.instance.black
                                : ProductColor.instance.white))
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const ProductPadding.bottomLow(),
            child: Row(
              children: [
                Padding(
                  padding: const ProductPadding.horizontalNormal15(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.username?.toString() ?? "",
                        style: context.general.textTheme.titleMedium!.copyWith(
                            color: context.watch<ThemeNotifier>().isLightTheme
                                ? ProductColor.instance.black
                                : ProductColor.instance.white),
                      ),
                      Text(model.bio?.toString() ?? "",
                          style: context.general.textTheme.bodyMedium!.copyWith(
                              color: context.watch<ThemeNotifier>().isLightTheme
                                  ? ProductColor.instance.black
                                  : ProductColor.instance.white))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const ProductPadding.horizontalNormal15(),
            child: SizedBox(
              width: context.sized.dynamicWidth(1),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor:
                          context.watch<ThemeNotifier>().isLightTheme
                              ? ProductColor.instance.black
                              : ProductColor.instance.white,
                      textStyle: context.general.textTheme.titleMedium,
                      shape: RoundedRectangleBorder(
                          borderRadius: ProductBorderRadius.circularNormal(),
                          side: BorderSide(
                              width: 0.5,
                              color: ProductColor.instance.grey800!))),
                  onPressed: () async {},
                  child: const Text("Edit Profile")),
            ),
          )
        ],
      ),
    );
  }
}
