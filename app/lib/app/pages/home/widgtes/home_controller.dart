import 'dart:developer';

import 'package:bloc/bloc.dart';
import '../../../repositories/products/products_repository.dart';
import 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final ProductRepository _productsRepository;

  HomeController(this._productsRepository) : super(const HomeState.initial());

  Future<void> loadProducts() async {
    emit(state.copyWhit(status: HomeStateStatus.loading));

    try {
      final products = await _productsRepository.findAllProducts();

      emit(state.copyWhit(status: HomeStateStatus.loaded, products: products));
    } on Exception catch (e, s) {
      log('Erro ao buscar produtos.', error: e, stackTrace: s);
      emit(
        state.copyWhit(
            status: HomeStateStatus.error,
            errorMessage: 'Erro ao buscar produtos'),
      );
    }
  }
}
