part of 'navigation_cubit.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NavigationInitial extends NavigationState {}

class NavigationSignInPage extends NavigationState {}

class NavigationSignUpPage extends NavigationState {}

class NavigationProductsPage extends NavigationState {
  final List<Product> products;
  const NavigationProductsPage({required this.products});

  @override
  List<Object> get props => [products];
}

class NavigationProductCreatePage extends NavigationState {}

class NavigationProductEditPage extends NavigationState {
  final Product product;
  const NavigationProductEditPage({required this.product});

  @override
  List<Object> get props => [product];
}
