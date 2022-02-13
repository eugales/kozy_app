import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozy_app/blocs/products/products_bloc.dart';
import 'package:kozy_app/cubit/navigation_cubit.dart';
import 'package:kozy_app/models/product.dart';
import 'package:kozy_app/pages/pages/home/products/product_edit.dart';

class ProductItem extends StatelessWidget {
  final Product _product;
  const ProductItem({Key? key, required Product product})
      : _product = product,
        super(key: key);

  Widget getImage(String url) {
    try {
      final image = Image.network(
        url,
        fit: BoxFit.fill,
        alignment: Alignment.center,
        height: 100,
        width: 100,
      );
      return image;
    } on Exception catch (e) {
      return const Icon(Icons.hide_image);
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = _product.name;
    String subtitle = _product.description;
    IconData icon = Icons.restaurant;
    int price = _product.price;
    String imageUrl1 = 'https://upload.wikimedia.org/wikipedia/commons/4/4b/Uyghur_Lagman.jpg';
    String imageUrl2 = 'https://foodnerdy.com//cdn/recipes/Screenshot_92.jpg';
    String imageUrl3 = 'https://foodnerdy.com//cdn/recipes/Screenshot_3431.jpg';
    // final PageController controller = PageController();

    final _productsBloc = BlocProvider.of<ProductsBloc>(context);

    final imageList = <Widget>[
      getImage(imageUrl1),
      getImage(imageUrl2),
      getImage(imageUrl3),
      getImage(imageUrl1),
      getImage(imageUrl2),
      getImage(imageUrl3),
    ];
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CarouselSlider(
              items: imageList,
              options: CarouselOptions(
                height: 100,
                initialPage: 1,
                viewportFraction: 0.3,
                enableInfiniteScroll: false,
              ),
            ),
            ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Edit'),
                  onPressed: () {
                    BlocProvider.of<NavigationCubit>(context).showProductDetails(_product);
                  },
                ),
                Text(
                  '₸ ${price.toString()}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
