import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../view_model/add_view_model.dart';
import '../../../product/constant/product_color.dart';
import '../../../product/constant/product_padding.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme_notifier.dart';

class AddPostContentView extends StatelessWidget {
  const AddPostContentView({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<AddViewModel>(context, listen: false);
    TextEditingController captionController = TextEditingController();
    TextEditingController locationController = TextEditingController();

    return Scaffold(
      appBar: _buildCustomAppBar(context, viewModel, captionController,
          locationController, viewModel.getSingleImage()!),
      body:
          _buildBody(context, viewModel, captionController, locationController),
    );
  }

  Widget _buildBody(
      BuildContext context,
      AddViewModel viewModel,
      TextEditingController captionController,
      TextEditingController locationController) {
    return Consumer<AddViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: const ProductPadding.allLow(),
                child: _buildImageAndCaptionRow(
                    context, viewModel, captionController),
              ),
              const Divider(),
              Padding(
                padding: const ProductPadding.horizontalLow8(),
                child: _buildLocationTF(locationController),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildLocationTF(TextEditingController locationController) {
    return TextField(
      maxLines: 2,
      controller: locationController,
      decoration: InputDecoration(
        hintText: "Add Location",
        border: InputBorder.none,
      ),
    );
  }

  Widget _buildImageAndCaptionRow(BuildContext context, AddViewModel viewModel,
      TextEditingController captionController) {
    return SizedBox(
      width: context.sized.dynamicWidth(1),
      height: context.sized.dynamicHeight(0.12),
      child: Row(
        children: [
          SizedBox(
            width: context.sized.dynamicWidth(0.3),
            height: context.sized.dynamicHeight(1),
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: viewModel.images!.length,
              itemBuilder: (context, index) {
                return viewModel.images![index];
              },
            ),
          ),
          Expanded(
            child: TextField(
              maxLength: 75,
              maxLines: 2,
              controller: captionController,
              decoration: InputDecoration(
                hintText: "Write a caption...",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildCustomAppBar(
    BuildContext context,
    AddViewModel viewModel,
    TextEditingController captionController,
    TextEditingController locationController,
    File file,
  ) {
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
            onPressed: () {
              viewModel.uploadPost(
                  context: context,
                  caption: captionController.text,
                  location: locationController.text,
                  file: file);
            },
            child: const Text("Share"))
      ],
    );
  }
}
