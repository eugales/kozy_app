import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozy_app/app_navigator.dart';
import 'package:kozy_app/blocs/authentication/authentication_bloc.dart';
import 'package:kozy_app/blocs/home/home_bloc.dart';
import 'package:kozy_app/blocs/products/products_bloc.dart';
import 'package:kozy_app/cubit/navigation_cubit.dart';
import 'package:kozy_app/models/user.dart';
import 'package:kozy_app/pages/pages/home_page.dart';
import 'package:kozy_app/pages/pages/sign_in_page.dart';
import 'package:kozy_app/repositories/authentication_repository.dart';
import 'package:kozy_app/repositories/product_repository.dart';

void main() {
  runApp(
    RepositoryProvider<AuthenticationRepository>(
      create: (_) => MainAuthenticationRepository(),
      child: BlocProvider<AuthenticationBloc>(
        create: (context) {
          final repository = RepositoryProvider.of<AuthenticationRepository>(context);
          return AuthenticationBloc(repository)..add(AppLoaded());
        },
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kozy',
      theme: ThemeData(primarySwatch: Colors.primaries.first),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
             return MultiRepositoryProvider(
              providers: [
                RepositoryProvider<ProductRepository>(create: (_) => MainProductRepository()),
              ],
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<NavigationCubit>(create: (_) => NavigationCubit()),
                  BlocProvider<ProductsBloc>(
                    create: (context) {
                      final repository = RepositoryProvider.of<ProductRepository>(context);
                      return ProductsBloc(repository);
                    },
                  ),
                ],
                child: BlocProvider<HomeBloc>(
                  create: (context) {
                    final productsBloc = RepositoryProvider.of<ProductsBloc>(context);
                    return HomeBloc(productsBloc)..add(HomeLoad());
                  },
                  child: const AppNavigator(),
                ),
              ),
            );
          }
          // otherwise show login page
          return const SignInPage();
        },
      ),
    );
  }
}
