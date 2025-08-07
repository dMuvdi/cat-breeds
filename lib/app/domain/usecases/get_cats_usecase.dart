import '../entities/cat.dart';
import '../repositories/cat_repository.dart';

class GetCatsUseCase {
  final CatRepository repository;

  GetCatsUseCase(this.repository);

  Future<List<Cat>> call() async {
    return await repository.getCats();
  }
}
