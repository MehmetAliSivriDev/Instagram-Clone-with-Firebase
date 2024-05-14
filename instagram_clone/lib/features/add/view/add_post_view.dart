import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../core/theme/theme_notifier.dart';
import '../view_model/add_view_model.dart';
import '../../../product/constant/product_color.dart';
import '../../../product/constant/product_padding.dart';
import '../../../product/util/custom_snackbar.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/routes.dart';

class AddPostView extends StatelessWidget {
  const AddPostView({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<AddViewModel>(context, listen: false);
    // viewModel.addPostInit();
    return Scaffold(
      appBar: _customAppBar(context),
      body: SafeArea(
          child: SingleChildScrollView(
        child: _buildBody(context, viewModel),
      )),
    );
  }

  Widget _buildBody(BuildContext context, AddViewModel viewModel) {
    return Column(
      children: [
        Padding(
          padding: const ProductPadding.bottomNormal(),
          child: _buildSelectedImageView(),
        ),
        Padding(
          padding: const ProductPadding.horizontalLow8(),
          child: _buildSelectText(context),
        ),
        _buildImageSelect(viewModel, context)
      ],
    );
  }

  Widget _buildImageSelect(AddViewModel viewModel, BuildContext context) {
    return InkWell(
      onTap: () {
        viewModel.imagesUpload();
      },
      child: SizedBox(
        width: context.sized.dynamicWidth(1),
        height: context.sized.dynamicHeight(0.25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_library_outlined,
              size: context.sized.dynamicHeight(0.10),
              color: ProductColor.instance.grey600,
            ),
            Consumer<AddViewModel>(
              builder: (context, viewModel, _) {
                return Text(
                  (viewModel.images?.length ?? 0) > 0
                      ? "(${viewModel.images!.length}) photos selected"
                      : "Select a photo",
                  style: context.general.textTheme.displaySmall!.copyWith(
                    color: ProductColor.instance.grey600,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectText(BuildContext context) {
    return Container(
      width: context.sized.dynamicWidth(1),
      height: context.sized.dynamicWidth(0.1),
      color: context.watch<ThemeNotifier>().isLightTheme
          ? ProductColor.instance.white
          : ProductColor.instance.black,
      child: Text(
        "Select",
        style: context.general.textTheme.titleLarge!.copyWith(
          color: context.watch<ThemeNotifier>().isLightTheme
              ? ProductColor.instance.black
              : ProductColor.instance.white,
        ),
      ),
    );
  }

  Widget _buildSelectedImageView() {
    return Consumer<AddViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.images == null || viewModel.images!.isEmpty) {
          return SizedBox(
            width: context.sized.dynamicWidth(1),
            height: context.sized.dynamicHeight(0.4),
            child: Center(
              child: Text("No photos selected.",
                  textAlign: TextAlign.center,
                  style: context.general.textTheme.displaySmall!
                      .copyWith(color: ProductColor.instance.grey600)),
            ),
          );
        }

        return SizedBox(
            width: context.sized.dynamicWidth(1),
            height: context.sized.dynamicHeight(0.4),
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: viewModel.images?.length ?? 0,
              itemBuilder: (context, index) {
                return Container(
                  width: context.sized.dynamicWidth(1),
                  height: context.sized.dynamicHeight(0.4),
                  child: viewModel.images?[index],
                );
              },
            ));
      },
    );
  }

  AppBar _customAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ProductColor.instance.transparent,
      centerTitle: false,
      title: Text(
        "New Post",
        style: context.general.textTheme.titleLarge!.copyWith(
            color: context.watch<ThemeNotifier>().isLightTheme
                ? ProductColor.instance.black
                : ProductColor.instance.white),
      ),
      actions: [
        TextButton(
            onPressed: () async {
              _controlAndNavigate(context);
            },
            child: Text("Next"))
      ],
    );
  }

  void _controlAndNavigate(BuildContext context) {
    if (context.read<AddViewModel>().images != null &&
        context.read<AddViewModel>().images!.isNotEmpty) {
      Navigator.pushNamed(context, Routes.ADD_POST_CONTENT);
    } else {
      CustomSnackbar.show(context,
          message: "Please select a photo",
          backgroundColor: ProductColor.instance.red);
    }
  }
}
