import 'package:flutter/material.dart';

class Product {
  final String image, title, description, video;
  final int price, size, id;
  final Color color;

  Product(this.image, this.video, this.title, this.description, this.price, this.size,
      this.id, this.color);
}
