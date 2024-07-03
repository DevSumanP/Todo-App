import 'dart:math';

class GetColor {
  static final List<int> colors = [
    0xffD9E8FC,
    0xffFFD8F4,
    0xffFDE99D,
    0xffB0E9CA,
    0xffFFEADD,
    0xffFCFAD9,
  ];

  static int getRandomColor() {
    final random = Random();
    return colors[random.nextInt(colors.length)];
  }
}
