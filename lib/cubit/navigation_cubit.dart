import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kozy_app/models/product.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());

  void popToHome() => emit(NavigationInitial());

  void showProductDetails(Product product) => emit(NavigationProductEditPage(product: product));
  void createNewProduct() => emit(NavigationProductCreatePage());
}
