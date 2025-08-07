import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/api_service.dart';
import '../../app/data/datasources/cat_remote_datasource.dart';
import '../../app/data/repositories/cat_repository_impl.dart';
import '../../app/domain/repositories/cat_repository.dart';
import '../../app/domain/usecases/get_cats_usecase.dart';
import '../../app/domain/usecases/get_cat_by_id_usecase.dart';
import '../../app/presentation/blocs/cats_bloc.dart';
import '../../app/presentation/blocs/cat_detail_bloc.dart';

class DependencyInjection {
  static MultiBlocProvider get providers {
    // Services
    final apiService = ApiService();

    // Data Sources
    final catRemoteDataSource = CatRemoteDataSourceImpl(apiService);

    // Repositories
    final CatRepository catRepository = CatRepositoryImpl(catRemoteDataSource);

    // Use Cases
    final getCatsUseCase = GetCatsUseCase(catRepository);
    final getCatByIdUseCase = GetCatByIdUseCase(catRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider<CatsBloc>(
          create: (context) => CatsBloc(getCatsUseCase: getCatsUseCase),
        ),
        BlocProvider<CatDetailBloc>(
          create:
              (context) => CatDetailBloc(getCatByIdUseCase: getCatByIdUseCase),
        ),
      ],
      child: const SizedBox.shrink(), // This will be replaced by the actual app
    );
  }
}
