import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wahidz/models/product.dart';

class PromoCarousel extends StatelessWidget {
  final List<Product> products;

  const PromoCarousel({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final promoProducts = products.take(5).toList();

    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.95,
        autoPlayInterval: Duration(seconds: 5),
      ),

      items: promoProducts.map((product) {
        final image = product.thumbnail.isNotEmpty
            ? product.thumbnail
            : "https://via.placeholder.com/800x400";

        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(image, fit: BoxFit.cover),

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black54, Colors.transparent],
                  ),
                ),
              ),

              Positioned(
                left: 16,
                bottom: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "-${product.discountPercentage.toStringAsFixed(0)}%",
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
