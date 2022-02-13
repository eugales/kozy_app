import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozy_app/cubit/navigation_cubit.dart';
import 'package:kozy_app/pages/pages/home/products/product_create.dart';
import 'package:kozy_app/pages/pages/home/products/product_edit.dart';
import 'package:kozy_app/pages/pages/home_page.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(builder: (context, state) {
      return Navigator(
        pages: [
          const MaterialPage(child: HomePage()),
          if (state is NavigationProductCreatePage) const MaterialPage(child: ProductCreatePage()),
          if (state is NavigationProductEditPage) MaterialPage(child: ProductEditPage(product: state.product))
        ],
        onPopPage: (route, state) {
          BlocProvider.of<NavigationCubit>(context).popToHome();
          return route.didPop(state);
        },
      );
    });
  }
}
