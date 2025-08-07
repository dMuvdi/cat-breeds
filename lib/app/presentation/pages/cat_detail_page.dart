import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../blocs/cat_detail_bloc.dart';
import '../widgets/cat_info_section.dart';

class CatDetailPage extends StatefulWidget {
  final String catId;

  const CatDetailPage({super.key, required this.catId});

  @override
  State<CatDetailPage> createState() => _CatDetailPageState();
}

class _CatDetailPageState extends State<CatDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<CatDetailBloc>().add(LoadCatDetail(widget.catId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CatDetailBloc, CatDetailState>(
        builder: (context, state) {
          if (state is CatDetailLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              ),
            );
          } else if (state is CatDetailLoaded) {
            final cat = state.cat;
            return Scaffold(
              body: Column(
                children: [
                  // Fixed App Bar with back button and cat name
                  AppBar(
                    title: Text(cat.name),
                    backgroundColor: Colors.orange.shade100,
                    foregroundColor: Colors.orange.shade800,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => context.go('/cats'),
                    ),
                  ),
                  // Fixed Image Section
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child:
                        cat.image?.url != null
                            ? CachedNetworkImage(
                              imageUrl: cat.image!.url,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => Container(
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
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
                                size: 100,
                                color: Colors.grey,
                              ),
                            ),
                  ),
                  // Scrollable content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Basic Information
                          CatInfoSection(
                            title: 'Basic Information',
                            items: [
                              if (cat.origin != null && cat.origin!.isNotEmpty)
                                CatInfoItem('Origin', cat.origin!),
                              if (cat.lifeSpan != null &&
                                  cat.lifeSpan!.isNotEmpty)
                                CatInfoItem('Life Span', cat.lifeSpan!),
                              if (cat.weight != null)
                                CatInfoItem(
                                  'Weight',
                                  '${cat.weight!.imperial} lbs (${cat.weight!.metric} kg)',
                                ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Description
                          if (cat.description != null &&
                              cat.description!.isNotEmpty)
                            CatInfoSection(
                              title: 'Description',
                              items: [CatInfoItem('', cat.description!)],
                            ),
                          const SizedBox(height: 24),

                          // Temperament
                          if (cat.temperament != null &&
                              cat.temperament!.isNotEmpty)
                            CatInfoSection(
                              title: 'Temperament',
                              items: [CatInfoItem('', cat.temperament!)],
                            ),
                          const SizedBox(height: 24),

                          // Characteristics
                          CatInfoSection(
                            title: 'Characteristics',
                            items: [
                              if (cat.adaptability != null)
                                CatInfoItem(
                                  'Adaptability',
                                  '${cat.adaptability}/5',
                                ),
                              if (cat.affectionLevel != null)
                                CatInfoItem(
                                  'Affection Level',
                                  '${cat.affectionLevel}/5',
                                ),
                              if (cat.childFriendly != null)
                                CatInfoItem(
                                  'Child Friendly',
                                  '${cat.childFriendly}/5',
                                ),
                              if (cat.dogFriendly != null)
                                CatInfoItem(
                                  'Dog Friendly',
                                  '${cat.dogFriendly}/5',
                                ),
                              if (cat.energyLevel != null)
                                CatInfoItem(
                                  'Energy Level',
                                  '${cat.energyLevel}/5',
                                ),
                              if (cat.grooming != null)
                                CatInfoItem('Grooming', '${cat.grooming}/5'),
                              if (cat.healthIssues != null)
                                CatInfoItem(
                                  'Health Issues',
                                  '${cat.healthIssues}/5',
                                ),
                              if (cat.intelligence != null)
                                CatInfoItem(
                                  'Intelligence',
                                  '${cat.intelligence}/5',
                                ),
                              if (cat.sheddingLevel != null)
                                CatInfoItem(
                                  'Shedding Level',
                                  '${cat.sheddingLevel}/5',
                                ),
                              if (cat.socialNeeds != null)
                                CatInfoItem(
                                  'Social Needs',
                                  '${cat.socialNeeds}/5',
                                ),
                              if (cat.strangerFriendly != null)
                                CatInfoItem(
                                  'Stranger Friendly',
                                  '${cat.strangerFriendly}/5',
                                ),
                              if (cat.vocalisation != null)
                                CatInfoItem(
                                  'Vocalisation',
                                  '${cat.vocalisation}/5',
                                ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Additional Information
                          CatInfoSection(
                            title: 'Additional Information',
                            items: [
                              if (cat.indoor != null)
                                CatInfoItem(
                                  'Indoor',
                                  cat.indoor == 1 ? 'Yes' : 'No',
                                ),
                              if (cat.lap != null)
                                CatInfoItem(
                                  'Lap Cat',
                                  cat.lap == 1 ? 'Yes' : 'No',
                                ),
                              if (cat.hypoallergenic != null)
                                CatInfoItem(
                                  'Hypoallergenic',
                                  cat.hypoallergenic == 1 ? 'Yes' : 'No',
                                ),
                              if (cat.natural != null)
                                CatInfoItem(
                                  'Natural Breed',
                                  cat.natural == 1 ? 'Yes' : 'No',
                                ),
                              if (cat.rare != null)
                                CatInfoItem(
                                  'Rare',
                                  cat.rare == 1 ? 'Yes' : 'No',
                                ),
                              if (cat.rex != null)
                                CatInfoItem('Rex', cat.rex == 1 ? 'Yes' : 'No'),
                              if (cat.suppressedTail != null)
                                CatInfoItem(
                                  'Suppressed Tail',
                                  cat.suppressedTail == 1 ? 'Yes' : 'No',
                                ),
                              if (cat.shortLegs != null)
                                CatInfoItem(
                                  'Short Legs',
                                  cat.shortLegs == 1 ? 'Yes' : 'No',
                                ),
                              if (cat.hairless != null)
                                CatInfoItem(
                                  'Hairless',
                                  cat.hairless == 1 ? 'Yes' : 'No',
                                ),
                              if (cat.experimental != null)
                                CatInfoItem(
                                  'Experimental',
                                  cat.experimental == 1 ? 'Yes' : 'No',
                                ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Links
                          if (cat.wikipediaUrl != null ||
                              cat.cfaUrl != null ||
                              cat.vetstreetUrl != null)
                            CatInfoSection(
                              title: 'Links',
                              items: [
                                if (cat.wikipediaUrl != null)
                                  CatInfoItem('Wikipedia', cat.wikipediaUrl!),
                                if (cat.cfaUrl != null)
                                  CatInfoItem('CFA', cat.cfaUrl!),
                                if (cat.vetstreetUrl != null)
                                  CatInfoItem('Vetstreet', cat.vetstreetUrl!),
                              ],
                            ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CatDetailError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Cat Details'),
                backgroundColor: Colors.orange.shade100,
                foregroundColor: Colors.orange.shade800,
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${state.message}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CatDetailBloc>().add(
                          LoadCatDetail(widget.catId),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          return const Scaffold(body: Center(child: Text('Unknown state')));
        },
      ),
    );
  }
}
