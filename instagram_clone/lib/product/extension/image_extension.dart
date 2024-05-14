import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum Logos { lbl_Instagram_logo }

// ignore: constant_identifier_names
enum ImagePNGs { default_user, person }

// ignore: constant_identifier_names
enum ImageJPGs { post }

// ignore: constant_identifier_names
enum IconsPNG { ic_direct, ic_igtv }

extension LogosExtension on Logos {
  String get path => "assets/images/logos/$name.png";

  Image get image => Image.asset(
        path,
      );
}

extension ImagePNGsExtension on ImagePNGs {
  String get path => "assets/images/$name.png";

  Image get image => Image.asset(
        path,
      );
}

extension ImageJPGsExtension on ImageJPGs {
  String get path => "assets/images/$name.jpg";

  Image get image => Image.asset(
        path,
      );
}

extension IconsPNGExtension on IconsPNG {
  String get path => "assets/images/icons/$name.png";

  Image get image => Image.asset(
        path,
      );
}
