import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../src/utils/formatters.dart';

class CatInfoSection extends StatelessWidget {
  final String title;
  final List<CatInfoItem> items;

  const CatInfoSection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: items.map((item) => item.build(context)).toList(),
          ),
        ),
      ],
    );
  }
}

class CatInfoItem {
  final String label;
  final String value;
  final String? countryCode;
  final String? url;

  const CatInfoItem(this.label, this.value, {this.countryCode, this.url});

  const CatInfoItem.link(this.label, this.url)
    : value = label,
      countryCode = null;

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty) ...[
            SizedBox(
              width: 120,
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child:
                url != null
                    ? InkWell(
                      onTap: () async {
                        try {
                          final uri = Uri.parse(url!);
                          bool result = false;

                          try {
                            if (kIsWeb) {
                              result = await launchUrl(uri);
                            } else {
                              result = await launchUrl(
                                uri,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          } catch (launchError) {
                            // If the first attempt fails, try without mode
                            try {
                              result = await launchUrl(uri);
                            } catch (e) {
                              // If both attempts fail, show error
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error opening link: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                              return;
                            }
                          }

                          if (!result && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Could not open link'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } catch (e) {
                          // Show a snackbar if there's an error
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error opening link: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.open_in_new,
                            size: 16,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    )
                    : countryCode != null && countryCode!.isNotEmpty
                    ? RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(text: value),
                          const TextSpan(text: ' '),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Text(
                              countryCodeToEmoji(countryCode!),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    )
                    : Text(value, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
