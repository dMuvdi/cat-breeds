import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/cats_bloc.dart';
import '../../../src/router/app_router.dart';
import '../widgets/cat_card.dart';
import '../widgets/search_box.dart';

class CatsPage extends StatefulWidget {
  const CatsPage({super.key});

  @override
  State<CatsPage> createState() => _CatsPageState();
}

class _CatsPageState extends State<CatsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load cats if not already loaded
    final catsState = context.read<CatsBloc>().state;
    if (catsState is CatsInitial) {
      context.read<CatsBloc>().add(LoadCats());
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    context.read<CatsBloc>().add(SearchCats(query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CatBreeds'),
        backgroundColor: Colors.orange.shade100,
        foregroundColor: Colors.orange.shade800,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBox(
              controller: _searchController,
              onChanged: _onSearchChanged,
              hintText: 'Search cats by name...',
            ),
          ),
          Expanded(
            child: BlocBuilder<CatsBloc, CatsState>(
              builder: (context, state) {
                if (state is CatsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    ),
                  );
                } else if (state is CatsLoaded) {
                  if (state.filteredCats.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.searchQuery != null
                                ? 'No cats found for "${state.searchQuery}"'
                                : 'No cats available',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemExtent: 400,
                    itemCount: state.filteredCats.length,
                    itemBuilder: (context, index) {
                      final cat = state.filteredCats[index];
                      return CatCard(
                        cat: cat,
                        onTap: () {
                          context.go('${AppRouter.catDetail}/${cat.id}');
                        },
                      );
                    },
                  );
                } else if (state is CatsError) {
                  return Center(
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
                            context.read<CatsBloc>().add(LoadCats());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
