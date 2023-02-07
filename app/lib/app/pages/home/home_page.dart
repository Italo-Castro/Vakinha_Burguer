import 'package:delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:delivery_app/app/core/ui/helpers/loader.dart';
import 'package:delivery_app/app/core/ui/helpers/messages.dart';
import 'package:delivery_app/app/core/ui/widgtes/delivery_app_bar.dart';
import 'package:delivery_app/app/models/product_model.dart';
import 'package:delivery_app/app/pages/home/widgtes/delivery_product_tile.dart';
import 'package:delivery_app/app/pages/home/widgtes/home_controller.dart';
import 'package:delivery_app/app/pages/home/widgtes/home_state.dart';
import 'package:delivery_app/app/pages/home/widgtes/shoppng_bag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() {
    controller.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: BlocConsumer<HomeController, HomeState>(
          listener: (context, state) {
            state.status.matchAny(
              any: () => hideLoader(),
              loading: () => showLoader(),
              error: () {
                hideLoader();
                showError(state.errorMessage ?? 'Erro não informado');
              },
            );
          },
          buildWhen: (previous, current) => current.status.matchAny(
              // quando o flutter deve buildar a tela/lista novamente
              any: () => false,
              initial: () => true,
              loaded: () => true),
          builder: (context, state) {
            return Column(
              children: [
                Text(state.shoppingBag.length.toString()),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      final orders = state.shoppingBag
                          .where((element) => element.product == product);
                      return DeliveryProductTile(
                        product: product,
                        orderProductDto:
                            orders.isNotEmpty ? orders.first : null,
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: state.shoppingBag.isNotEmpty,
                  child: ShoppingBagWidget(bag: state.shoppingBag),
                ),
              ],
            );
          }),
    );
  }
}
