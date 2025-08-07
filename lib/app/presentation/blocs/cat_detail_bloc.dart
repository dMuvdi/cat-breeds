import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/cat.dart';
import '../../domain/usecases/get_cat_by_id_usecase.dart';

// Events
abstract class CatDetailEvent extends Equatable {
  const CatDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadCatDetail extends CatDetailEvent {
  final String catId;

  const LoadCatDetail(this.catId);

  @override
  List<Object?> get props => [catId];
}

// States
abstract class CatDetailState extends Equatable {
  const CatDetailState();

  @override
  List<Object?> get props => [];
}

class CatDetailInitial extends CatDetailState {}

class CatDetailLoading extends CatDetailState {}

class CatDetailLoaded extends CatDetailState {
  final Cat cat;

  const CatDetailLoaded(this.cat);

  @override
  List<Object?> get props => [cat];
}

class CatDetailError extends CatDetailState {
  final String message;

  const CatDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class CatDetailBloc extends Bloc<CatDetailEvent, CatDetailState> {
  final GetCatByIdUseCase getCatByIdUseCase;

  CatDetailBloc({required this.getCatByIdUseCase}) : super(CatDetailInitial()) {
    on<LoadCatDetail>(_onLoadCatDetail);
  }

  Future<void> _onLoadCatDetail(
    LoadCatDetail event,
    Emitter<CatDetailState> emit,
  ) async {
    emit(CatDetailLoading());
    try {
      final cat = await getCatByIdUseCase(event.catId);
      emit(CatDetailLoaded(cat));
    } catch (e) {
      emit(CatDetailError(e.toString()));
    }
  }
}
