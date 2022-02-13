part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;

  const ProductsLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class ProductsEmpty extends ProductsState {
  final String message;

  const ProductsEmpty({required this.message});

  @override
  List<Object> get props => [message];
}

class ProductsFailure extends ProductsState {
  final String message;

  const ProductsFailure({required this.message});

  @override
  List<Object> get props => [message];
}



class ProductInProgress extends ProductsState {}

//CREATE

class ProductCreateSuccess extends ProductsState {
  final Product product;

  const ProductCreateSuccess({required this.product});

  @override
  List<Object> get props => [product];
}

class ProductCreateFailure extends ProductsState {
  final String message;

  const ProductCreateFailure({required this.message});

  @override
  List<Object> get props => [message];
}

//EDIT

class ProductEditSuccess extends ProductsState {
  final Product product;

  const ProductEditSuccess({required this.product});

  @override
  List<Object> get props => [product];
}

class ProductEditFailure extends ProductsState {
  final String message;

  const ProductEditFailure({required this.message});

  @override
  List<Object> get props => [message];
}

//DELETE

class ProductDeleteSuccess extends ProductsState {
  final int productId;

  const ProductDeleteSuccess({required this.productId});

  @override
  List<Object> get props => [productId];
}

class ProductDeleteFailure extends ProductsState {
  final String message;

  const ProductDeleteFailure({required this.message});

  @override
  List<Object> get props => [message];
}
