import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {
  final String title;
  final String buttonLabel;
  final String imageUrl;
  final VoidCallback onTap;
  final String? promoText;
  final VoidCallback? onBuyNow;

  const PromoBanner({
    super.key,
    required this.title,
    required this.buttonLabel,
    required this.imageUrl,
    required this.onTap,
    this.promoText,
    this.onBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  if (promoText != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      promoText!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: onTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF63C2FF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(buttonLabel),
                      ),
                      if (onBuyNow != null) ...[
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: onBuyNow,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            minimumSize: const Size(100, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: const Text(
                            "Buy Now",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network('https://picsum.photos/seed/person/200/200', width: 96, height: 96, fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
  }
}
