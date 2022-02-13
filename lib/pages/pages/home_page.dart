import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozy_app/blocs/blocs.dart';
import 'package:kozy_app/blocs/home/home_bloc.dart';
import 'package:kozy_app/cubit/navigation_cubit.dart';
import 'package:kozy_app/pages/pages/home/products/products_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late List<AppBar> _appbarOptions;
  late List<Widget> _widgetOptions;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _appbarOptions = <AppBar>[
      AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<NavigationCubit>(context).createNewProduct();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
    ];

    _widgetOptions = <Widget>[
      ProductsPage(),
      const Text('Orders'),
      Column(
        children: [
          const Text('Account'),
          TextButton(
            child: const Text('Sign out'),
            onPressed: () {
              final authBloc = BlocProvider.of<AuthenticationBloc>(context);
              authBloc.add(UserSignedOut());
            },
          )
        ],
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarOptions[_selectedIndex],
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final homeBloc = BlocProvider.of<HomeBloc>(context);

          if (state is HomeLoaded) {
            return SafeArea(
              child: Container(alignment: Alignment.center, child: _widgetOptions[_selectedIndex]),
            );
          }

          if (state is HomeFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(state.message),
                  TextButton(
                    child: const Text('Retry'),
                    onPressed: () {
                      homeBloc.add(HomeLoad());
                    },
                  )
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.dinner_dining), label: 'My Products'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Received Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Account'),
        ],
      ),
    );
  }
}
