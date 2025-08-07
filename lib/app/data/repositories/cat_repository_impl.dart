import '../../domain/entities/cat.dart';
import '../../domain/repositories/cat_repository.dart';
import '../datasources/cat_remote_datasource.dart';

class CatRepositoryImpl implements CatRepository {
  final CatRemoteDataSource remoteDataSource;

  CatRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Cat>> getCats() async {
    try {
      final catModels = await remoteDataSource.getCats();
      return catModels;
    } catch (e) {
      throw Exception('Failed to get cats: $e');
    }
  }

  @override
  Future<Cat> getCatById(String id) async {
    try {
      final catModel = await remoteDataSource.getCatById(id);
      return catModel;
    } catch (e) {
      throw Exception('Failed to get cat: $e');
    }
  }
}
