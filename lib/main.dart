import 'package:apac_e_commerce/src/cart/presentation/bloc/cart_event.dart';
import 'package:apac_e_commerce/src/producs_list/data/data_source/product_list_data_source.dart';
import 'package:apac_e_commerce/src/producs_list/data/repository/product_list_respostory.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'core/utils/go_router.dart';
import 'network/api_helper.dart';
import 'src/cart/presentation/bloc/cart_bloc.dart';
import 'src/producs_list/presentation/bloc/product_listing_bloc.dart';
import 'src/producs_list/presentation/bloc/product_listing_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final APIHelper apiHelper = APIHelper();
  final connectivityResult = await Connectivity().checkConnectivity();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ProductListingBloc(
          ProductListRespostory(
            productListDataSource: ProductListDataSource(
              apiHelper,
            ),
            connectivityResult: connectivityResult,
          ),
        )..add(LoadProducts()),
      ),
      BlocProvider(create: (context) => CartBloc()..add(LoadCart())),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: MyRouter.router,
    );
  }
}
