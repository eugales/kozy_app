part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class ProductsStateReset extends ProductsEvent {}

class ProductsLoad extends ProductsEvent {}

class ProductCreateEvent extends ProductsEvent {
  final Map<String, dynamic> newProduct;

  const ProductCreateEvent({required this.newProduct});

  @override
  List<Object> get props => [newProduct];
}

class ProductEditEvent extends ProductsEvent {
  final Product product;

  const ProductEditEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class ProductDeleteEvent extends ProductsEvent {
  final int productId;

  const ProductDeleteEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}
