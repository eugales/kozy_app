import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozy_app/blocs/products/products_bloc.dart';
import 'package:kozy_app/cubit/navigation_cubit.dart';
import 'package:kozy_app/models/product.dart';
import 'package:kozy_app/pages/pages/home/products/product_item.dart';

class ProductsPage extends StatefulWidget {
  final List<Product> products = [];
  ProductsPage({Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  Future<void> _refresh(ProductsBloc productsBloc) {
    return Future(() => productsBloc.add(ProductsLoad()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: BlocConsumer<ProductsBloc, ProductsState>(
          builder: (context, state) {
            final productsBloc = context.read<ProductsBloc>();

            if (state is ProductInProgress) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            }

            if (state is ProductsFailure) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Text(state.message),
                  TextButton(
                    child: const Text('Retry'),
                    onPressed: () {
                      productsBloc.add(ProductsLoad());
                    },
                  )
                ],
              );
            }

            if (state is ProductsEmpty) {
              return Container(
                  alignment: Alignment.center,
                  child: TextButton(
                    child: const Text('Add Product'),
                    onPressed: () {
                      BlocProvider.of<NavigationCubit>(context).createNewProduct();
                    },
                  ));
            }

            return RefreshIndicator(
              onRefresh: () => _refresh(productsBloc),
              child: ListView.builder(
                itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  final product = widget.products[index];
                  return Dismissible(
                    key: Key(product.name),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Text(
                        'Delete',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    dismissThresholds: const {DismissDirection.endToStart: 0.6, DismissDirection.startToEnd: 1},
                    confirmDismiss: (DismissDirection direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm"),
                            content: const Text("Are you sure you wish to delete this item?"),
                            actions: <Widget>[
                              ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(true), child: const Text("DELETE")),
                              ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text("CANCEL"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (direction) {
                      productsBloc.add(ProductDeleteEvent(productId: product.id));
                      widget.products.removeAt(index);
                    },
                    child: ProductItem(product: product),
                  );
                },
              ),
            );
          },
          listener: (context, state) {
            if (state is ProductCreateSuccess) {
              widget.products.add(state.product);
            }

            if (state is ProductEditSuccess) {
              final pIndex = widget.products.indexWhere((p) => p.id == state.product.id);
              if (pIndex > -1) {
                widget.products[pIndex] = state.product;
              }
            }

            if (state is ProductDeleteSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Product deleted successfully'),
                    backgroundColor: Colors.green[600],
                  ),
                );
            }

            if (state is ProductsLoaded) {
              widget.products.clear();
              widget.products.addAll(state.products);
            }

            print("${state.runtimeType} ${widget.products.length}");

            context.read<ProductsBloc>().add(ProductsStateReset());
          },
        ));
  }
}
