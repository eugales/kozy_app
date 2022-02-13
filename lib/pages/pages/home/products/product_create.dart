import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozy_app/blocs/products/products_bloc.dart';
import 'package:kozy_app/cubit/navigation_cubit.dart';
import 'package:kozy_app/models/product.dart';
import 'package:kozy_app/pages/widgets/custom_text_field.dart';

class ProductCreatePage extends StatefulWidget {
  const ProductCreatePage({Key? key}) : super(key: key);

  @override
  _ProductCreatePageState createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _productsBloc = BlocProvider.of<ProductsBloc>(context);

    void onProductSavePressed() {
      final name = nameController.value.text;
      final description = descriptionController.value.text;
      final price = int.tryParse(priceController.value.text) ?? 0;

      Map<String, dynamic> newProduct = {
        'name': name,
        'description': description,
        'price': price,
      };

      _productsBloc.add(ProductCreateEvent(newProduct: newProduct));
    }

    void _showError(String error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Edit',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocListener<ProductsBloc, ProductsState>(
        listener: (context, state) {
          if (state is ProductCreateSuccess) {
            BlocProvider.of<NavigationCubit>(context).popToHome();
          }
          if (state is ProductCreateFailure) {
            _showError(state.message);
          }
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            // alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      CustomTextField(
                        labelText: 'Name',
                        hintText: 'Enter product name',
                        controller: nameController,
                      ),
                      CustomTextField(
                        labelText: 'Description',
                        hintText: 'Enter product description',
                        controller: descriptionController,
                      ),
                      CustomTextField(
                        labelText: 'Price',
                        hintText: 'Enter product price',
                        controller: priceController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: onProductSavePressed,
                        height: 45,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Colors.black,
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
