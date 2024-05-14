import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../product/widget/post/post_widget.dart';

class ProfilePostView extends StatelessWidget {
  const ProfilePostView({super.key, this.snapshot});

  final snapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: PostWidget(snapshot));
  }
}
