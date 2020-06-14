import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kulina_submission_test/bloc/bloc_state.dart';
import 'package:kulina_submission_test/bloc/product_list_event.dart';
import 'package:kulina_submission_test/models/product_model.dart';
import 'package:kulina_submission_test/services/local_storage.dart';
import 'package:kulina_submission_test/services/product_service.dart';
import 'package:kulina_submission_test/models/cart.dart';

class ProductListBloc extends Bloc<ProductListEvent, BlocState> {
  @override
  BlocState get initialState => Idle();

  @override
  Stream<BlocState> mapEventToState(ProductListEvent event) async* {
    // This return the product list
    if (event is RequestProduct) {
      yield Waiting();
      try {
        final List<Product> products = await ProductService().fetchAllProduct();

        yield Success(data: products, event: RequestProduct());
      } catch (e) {
        // A Customized error message to help debugging in runtime.
        yield Error(error: "X001");
      }
    } else if (event is AddProductToCart) {
      yield Waiting();
      try {
        await LocalStorage().addProductToCart(event.productId);
        final Cart item =
            await LocalStorage().fetchSingleCartContent(event.productId);

        yield Success(data: item, event: AddProductToCart());
      } catch (e) {
        yield Error(error: "X002");
      }
    } else if (event is FindItemInCart) {
      yield Waiting();
      try {
        final Cart item =
            await LocalStorage().fetchSingleCartContent(event.itemId);
        if (item != null) {
          yield Success(data: item, event: FindItemInCart());
        } else {
          yield Idle(data: item, event: FindItemInCart());
        }
      } catch (e) {
        yield Error(error: "X003");
      }
    } else if (event is AddQuantity) {
      yield Waiting();
      try {
        await LocalStorage().addQuantity(event.cart);
        final Cart item = await LocalStorage()
            .fetchSingleCartContent(event.cart.orderedItemId);

        yield Success(data: item, event: AddQuantity());
      } catch (e) {
        yield Error(error: "X004");
      }
    } else if (event is SubtractQuantity) {
      yield Waiting();
      try {
        final Map<String, dynamic> status =
            await LocalStorage().subtractQuantity(event.cart);

        if (status['status'] == 'delete') {
          yield Idle(data: status, event: SubtractQuantity());
        } else {
          final Cart item = await LocalStorage()
              .fetchSingleCartContent(event.cart.orderedItemId);
          yield Success(data: item, event: SubtractQuantity());
        }
      } catch (e) {
        yield Error(error: "X005");
      }
    }
  }
}
