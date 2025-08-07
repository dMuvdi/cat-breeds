import '../entities/cat.dart';
import '../repositories/cat_repository.dart';

class GetCatByIdUseCase {
  final CatRepository repository;

  GetCatByIdUseCase(this.repository);

  Future<Cat> call(String id) async {
    return await repository.getCatById(id);
  }
}
