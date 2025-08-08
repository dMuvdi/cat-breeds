import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../src/utils/formatters.dart';
import '../../domain/entities/cat.dart';

class CatCard extends StatelessWidget {
  final Cat cat;
  final VoidCallback onTap;

  const CatCard({super.key, required this.cat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child:
                    cat.image?.url != null
                        ? CachedNetworkImage(
                          imageUrl: cat.image!.url,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          placeholder:
                              (context, url) => Container(
                                color: Colors.grey.shade200,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.orange,
                                    ),
                                  ),
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => Container(
                                color: Colors.grey.shade200,
                                child: const Icon(
                                  Icons.error,
                                  color: Colors.grey,
                                ),
                              ),
                        )
                        : Container(
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.pets,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cat.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (cat.origin != null && cat.origin!.isNotEmpty)
                          RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                              children: [
                                TextSpan(text: 'Origin: ${cat.origin!} '),
                                if (cat.countryCode != null &&
                                    cat.countryCode!.isNotEmpty)
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Text(
                                      countryCodeToEmoji(cat.countryCode!),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        if (cat.intelligence != null)
                          Text(
                            'Intelligence: ${cat.intelligence.toString()}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade100,
                        foregroundColor: Colors.orange.shade800,
                      ),
                      child: Text(
                        'See more...',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.orange.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
