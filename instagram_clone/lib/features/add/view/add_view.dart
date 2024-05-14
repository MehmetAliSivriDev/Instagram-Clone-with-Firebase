import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'add_post_view.dart';
import 'add_reels_view.dart';
import '../view_model/add_view_model.dart';
import '../../../product/constant/product_border_radius.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../../product/constant/product_color.dart';

class AddView extends StatelessWidget {
  const AddView({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<AddViewModel>(context, listen: false);
    viewModel.init();
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        PageView(
          onPageChanged: viewModel.onPageChanged,
          controller: viewModel.pageController,
          children: const [AddPostView(), AddReelsView()],
        ),
        AnimatedPositioned(
            bottom: context.sized.dynamicHeight(0.01),
            left: viewModel.currentIndex == 0
                ? context.sized.dynamicWidth(0.4)
                : context.sized.dynamicWidth(0.2),
            right: viewModel.currentIndex == 0
                ? context.sized.dynamicWidth(0.2)
                : context.sized.dynamicWidth(0.4),
            duration: const Duration(milliseconds: 400),
            child: Container(
              width: context.sized.dynamicWidth(0.4),
              height: context.sized.dynamicHeight(0.05),
              decoration: BoxDecoration(
                color: ProductColor.instance.grey800,
                borderRadius: ProductBorderRadius.circularHigh(),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      viewModel.navigationTapped(0);
                    },
                    child: Text("Post",
                        style: context.general.textTheme.bodyLarge!.copyWith(
                            color:
                                context.watch<AddViewModel>().currentIndex == 0
                                    ? ProductColor.instance.white
                                    : ProductColor.instance.grey600)),
                  ),
                  GestureDetector(
                    onTap: () {
                      viewModel.navigationTapped(1);
                    },
                    child: Text("Reels",
                        style: context.general.textTheme.bodyLarge!.copyWith(
                            color:
                                context.watch<AddViewModel>().currentIndex == 1
                                    ? ProductColor.instance.white
                                    : ProductColor.instance.grey600)),
                  ),
                ],
              ),
            ))
      ],
    )));
  }
}
