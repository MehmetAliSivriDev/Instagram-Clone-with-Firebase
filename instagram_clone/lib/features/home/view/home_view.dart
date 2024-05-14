import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/theme_notifier.dart';
import '../../../product/constant/product_border_radius.dart';
import 'package:provider/provider.dart';
import '../../../product/constant/product_color.dart';
import '../../../product/extension/image_extension.dart';
import 'package:kartal/kartal.dart';

import '../../../product/widget/post/post_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: _customAppBar(context),
      body: _buildBody(fireStore),
    );
  }

  Widget _buildBody(FirebaseFirestore fireStore) {
    return CustomScrollView(
      slivers: [
        StreamBuilder(
            stream: fireStore
                .collection("posts")
                .orderBy("time", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              return SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: snapshot.data == null
                          ? 0
                          : snapshot.data!.docs.length, (context, index) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return PostWidget(snapshot.data!.docs[index].data());
                }
              }));
            })
      ],
    );
  }

  AppBar _customAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ProductColor.instance.transparent,
      leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.camera_alt_outlined,
            size: context.sized.dynamicWidth(0.1),
          )),
      centerTitle: true,
      title: SizedBox(
        width: context.sized.dynamicWidth(0.4),
        height: context.sized.dynamicHeight(1),
        child: Image.asset(
          Logos.lbl_Instagram_logo.path,
          color: context.watch<ThemeNotifier>().isLightTheme
              ? ProductColor.instance.black
              : ProductColor.instance.white,
        ),
      ),
      actions: [
        SizedBox(
          width: context.sized.dynamicWidth(0.07),
          child: InkWell(
            borderRadius: ProductBorderRadius.circularLow(),
            onTap: () {
              context.read<ThemeNotifier>().changeTheme();
            },
            child: Image.asset(IconsPNG.ic_igtv.path,
                color: context.watch<ThemeNotifier>().isLightTheme
                    ? ProductColor.instance.black
                    : ProductColor.instance.white),
          ),
        ),
        context.sized.emptySizedWidthBoxLow3x,
        SizedBox(
          width: context.sized.dynamicWidth(0.08),
          child: InkWell(
            borderRadius: ProductBorderRadius.circularLow(),
            onTap: () {},
            child: Image.asset(IconsPNG.ic_direct.path,
                color: context.watch<ThemeNotifier>().isLightTheme
                    ? ProductColor.instance.black
                    : ProductColor.instance.white),
          ),
        ),
        context.sized.emptySizedWidthBoxLow3x,
      ],
    );
  }
}
