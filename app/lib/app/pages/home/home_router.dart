import 'package:delivery_app/app/pages/home/home_page.dart';
import 'package:delivery_app/app/pages/home/widgtes/home_controller.dart';
import 'package:delivery_app/app/repositories/products/products_repository.dart';
import 'package:delivery_app/app/repositories/products/products_repository_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<ProductRepository>(
            create: (context) => ProductRepositoryImpl(
              dio: context.read(),
            ),
          ),
          Provider(
            create: (context) => HomeController(context.read()),
          ),
        ],
        child: HomePage(),
      );
}
