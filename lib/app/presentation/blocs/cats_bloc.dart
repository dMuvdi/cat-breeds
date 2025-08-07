import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/cat.dart';
import '../../domain/usecases/get_cats_usecase.dart';

// Events
abstract class CatsEvent extends Equatable {
  const CatsEvent();

  @override
  List<Object?> get props => [];
}

class LoadCats extends CatsEvent {}

class SearchCats extends CatsEvent {
  final String query;

  const SearchCats(this.query);

  @override
  List<Object?> get props => [query];
}

// States
abstract class CatsState extends Equatable {
  const CatsState();

  @override
  List<Object?> get props => [];
}

class CatsInitial extends CatsState {}

class CatsLoading extends CatsState {}

class CatsLoaded extends CatsState {
  final List<Cat> cats;
  final List<Cat> filteredCats;
  final String? searchQuery;

  const CatsLoaded({
    required this.cats,
    required this.filteredCats,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [cats, filteredCats, searchQuery];

  CatsLoaded copyWith({
    List<Cat>? cats,
    List<Cat>? filteredCats,
    String? searchQuery,
  }) {
    return CatsLoaded(
      cats: cats ?? this.cats,
      filteredCats: filteredCats ?? this.filteredCats,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class CatsError extends CatsState {
  final String message;

  const CatsError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class CatsBloc extends Bloc<CatsEvent, CatsState> {
  final GetCatsUseCase getCatsUseCase;

  CatsBloc({required this.getCatsUseCase}) : super(CatsInitial()) {
    on<LoadCats>(_onLoadCats);
    on<SearchCats>(_onSearchCats);
  }

  Future<void> _onLoadCats(LoadCats event, Emitter<CatsState> emit) async {
    emit(CatsLoading());
    try {
      final cats = await getCatsUseCase();
      emit(CatsLoaded(cats: cats, filteredCats: cats));
    } catch (e) {
      emit(CatsError(e.toString()));
    }
  }

  void _onSearchCats(SearchCats event, Emitter<CatsState> emit) {
    if (state is CatsLoaded) {
      final currentState = state as CatsLoaded;
      final query = event.query.toLowerCase();

      if (query.isEmpty) {
        emit(
          currentState.copyWith(
            filteredCats: currentState.cats,
            searchQuery: null,
          ),
        );
      } else {
        final filteredCats =
            currentState.cats
                .where((cat) => cat.name.toLowerCase().contains(query))
                .toList();
        emit(
          currentState.copyWith(filteredCats: filteredCats, searchQuery: query),
        );
      }
    }
  }
}
