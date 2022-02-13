import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kozy_app/exceptions/authorization_exception.dart';
import 'package:kozy_app/exceptions/product_exception.dart';
import 'package:kozy_app/models/models.dart';
import 'package:kozy_app/repositories/product_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository _repository;

  ProductsBloc(ProductRepository repository)
      : _repository = repository,
        super(ProductsInitial()) {
    on<ProductsLoad>(
      (event, emit) async {
        emit.call(ProductsLoading());
        try {
          List<Product> products = await _repository.getMyProducts();
          if (products.isNotEmpty) {
            emit.call(ProductsLoaded(products: products));
          } else {
            emit.call(const ProductsEmpty(message: 'no products found'));
          }
        } on AuthorizationException catch (e) {
          emit.call(ProductsFailure(message: e.message));
        } catch (e) {
          emit.call(const ProductsFailure(message: 'An unknown error occured'));
        }
      },
    );

    on<ProductCreateEvent>((event, emit) async {
      emit.call(ProductInProgress());
      try {
        Product? newProduct = await _repository.createProduct(event.newProduct);
        if (newProduct != null) {
          emit.call(ProductCreateSuccess(product: newProduct));
        } else {
          emit.call(const ProductCreateFailure(message: 'product create error'));
        }
      } on ProductException catch (e) {
        emit.call(ProductCreateFailure(message: e.message));
      } catch (e) {
        emit.call(ProductCreateFailure(message: e.toString()));
      } 

    });

    on<ProductEditEvent>((event, emit) async {
      emit.call(ProductInProgress());
      try {
        Product? editedProduct = await _repository.editProduct(event.product);
        if (editedProduct != null) {
          emit.call(ProductEditSuccess(product: editedProduct));
        } else {
          emit.call(const ProductEditFailure(message: 'product edit error'));
        }
      } catch (e) {
        emit.call(ProductEditFailure(message: e.toString()));
      }
    });

    on<ProductDeleteEvent>((event, emit) async {
      emit.call(ProductInProgress());
      try {
        bool result = await _repository.deleteProduct(event.productId);
        if (result) {
          emit.call(ProductDeleteSuccess(productId: event.productId));
        } else {
          emit.call(const ProductDeleteFailure(message: 'product edit error'));
        }
      } catch (e) {
        emit.call(ProductDeleteFailure(message: e.toString()));
      }
    });

    on<ProductsStateReset>((event, emit) => emit(ProductsInitial()));
  }
}
