import '../models/cat_model.dart';
import '../../../src/services/api_service.dart';

abstract class CatRemoteDataSource {
  Future<List<CatModel>> getCats();
  Future<CatModel> getCatById(String id);
}

class CatRemoteDataSourceImpl implements CatRemoteDataSource {
  final ApiService apiService;

  CatRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<CatModel>> getCats() async {
    try {
      final response = await apiService.get('/breeds');
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => CatModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load cats: $e');
    }
  }

  @override
  Future<CatModel> getCatById(String id) async {
    try {
      final response = await apiService.get('/images/search?limit=1&breed_ids=$id');
      return CatModel.fromJsonIndividual(response.data[0]);
    } catch (e) {
      throw Exception('Failed to load cat: $e');
    }
  }
}
