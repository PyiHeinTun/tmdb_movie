import 'package:flutter/material.dart';

List<Widget> getStar(double? average) {
  if (average == null) {
    return List.filled(
      5,
      const Icon(
        Icons.star_border,
        color: Colors.amber,
        size: 15,
      ),
    );
  }
  final rating = average / 2;
  int fullStarCount = rating.floor();
  final isHalfStar = (rating - fullStarCount) != 0;

  final list = List.filled(
    5,
    const Icon(
      Icons.star_border,
      color: Colors.amber,
      size: 15,
    ),
    growable: true,
  );
  for (int i = 0; i < fullStarCount; i++) {
    list[i] = const Icon(
      Icons.star,
      color: Colors.amber,
      size: 15,
    );
  }
  if (isHalfStar) {
    list[fullStarCount] = const Icon(
      Icons.star_half,
      color: Colors.amber,
      size: 15,
    );
  }
  return list;
}
