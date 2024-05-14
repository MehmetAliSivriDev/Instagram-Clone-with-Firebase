import 'package:flutter/material.dart';
import '../../util/cached_image.dart';
import '../../../core/theme/theme_notifier.dart';
import '../../constant/product_color.dart';
import '../../constant/product_padding.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';

class PostWidget extends StatelessWidget {
  const PostWidget(
    this.snapshot, {
    super.key,
  });

  final snapshot;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: const ProductPadding.horizontalLow8(),
          leading: CircleAvatar(
            backgroundColor: ProductColor.instance.grey200,
            child: CachedImage(imageURL: snapshot["profileImage"]),
          ),
          title: Text(
            snapshot["username"],
            style: context.general.textTheme.titleMedium!.copyWith(
              color: context.watch<ThemeNotifier>().isLightTheme
                  ? ProductColor.instance.black
                  : ProductColor.instance.white,
            ),
          ),
          subtitle: Text(
            snapshot["location"],
            style: context.general.textTheme.bodyMedium!.copyWith(
              color: context.watch<ThemeNotifier>().isLightTheme
                  ? ProductColor.instance.black
                  : ProductColor.instance.white,
            ),
          ),
          trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz,
                color: context.watch<ThemeNotifier>().isLightTheme
                    ? ProductColor.instance.black
                    : ProductColor.instance.white,
              )),
        ),
        SizedBox(
          width: context.sized.dynamicWidth(1),
          height: context.sized.dynamicHeight(0.4),
          child: CachedImage(imageURL: snapshot["postImage"]),
        ),
        SizedBox(
          width: context.sized.dynamicWidth(1),
          height: context.sized.dynamicHeight(0.05),
          child: Row(
            children: [
              IconButton(
                  iconSize: context.sized.dynamicWidth(0.07),
                  onPressed: () {},
                  icon: Icon(Icons.favorite_outline)),
              IconButton(
                  iconSize: context.sized.dynamicWidth(0.07),
                  onPressed: () {},
                  icon: Icon(Icons.messenger_outline_sharp)),
              IconButton(
                  iconSize: context.sized.dynamicWidth(0.07),
                  onPressed: () {},
                  icon: Icon(Icons.send)),
              const Spacer(),
              IconButton(
                  iconSize: context.sized.dynamicWidth(0.07),
                  onPressed: () {},
                  icon: Icon(Icons.bookmark_border_outlined)),
            ],
          ),
        ),
        Padding(
          padding: const ProductPadding.leftNormal(),
          child: Text("0"),
        ),
        Padding(
          padding: const ProductPadding.allLow(),
          child: Row(
            children: [
              Text(snapshot["username"] + " ",
                  style: context.general.textTheme.titleSmall!.copyWith(
                    color: context.watch<ThemeNotifier>().isLightTheme
                        ? ProductColor.instance.black
                        : ProductColor.instance.white,
                  )),
              Text(snapshot["caption"],
                  style: context.general.textTheme.bodySmall!.copyWith(
                    color: context.watch<ThemeNotifier>().isLightTheme
                        ? ProductColor.instance.black
                        : ProductColor.instance.white,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const ProductPadding.leftLow(),
          child: Text(
              formatDate(snapshot["time"].toDate(), [yyyy, '-', mm, "-", dd]),
              style: context.general.textTheme.bodySmall!
                  .copyWith(color: ProductColor.instance.grey600)),
        )
      ],
    );
  }
}
