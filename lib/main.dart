import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/router/app_router.dart';
import 'src/services/api_service.dart';
import 'app/data/datasources/cat_remote_datasource.dart';
import 'app/data/repositories/cat_repository_impl.dart';
import 'app/domain/usecases/get_cats_usecase.dart';
import 'app/domain/usecases/get_cat_by_id_usecase.dart';
import 'app/presentation/blocs/cats_bloc.dart';
import 'app/presentation/blocs/cat_detail_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CatsBloc>(
          create:
              (context) => CatsBloc(
                getCatsUseCase: GetCatsUseCase(
                  CatRepositoryImpl(CatRemoteDataSourceImpl(ApiService())),
                ),
              ),
        ),
        BlocProvider<CatDetailBloc>(
          create:
              (context) => CatDetailBloc(
                getCatByIdUseCase: GetCatByIdUseCase(
                  CatRepositoryImpl(CatRemoteDataSourceImpl(ApiService())),
                ),
              ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Cats App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
