enum Lotties { splash }

extension LottieExtension on Lotties {
  String get getPath => "assets/lottie/$name.json";
}
