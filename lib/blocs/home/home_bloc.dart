import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kozy_app/blocs/products/products_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductsBloc _productBloc;

  HomeBloc(ProductsBloc productBloc)
      : _productBloc = productBloc,
        super(HomeInitial()) {
    on<HomeLoad>((event, emit) {
      emit.call(HomeLoading());
      _productBloc.add(ProductsLoad());
      emit.call(HomeLoaded());
    });
  }
}
