import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:max_food_delivery_app/bloc/blocs.dart';
import 'package:max_food_delivery_app/models/models.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final VoucherBloc _voucherBloc;
  late StreamSubscription _voucherSubscription;

  BasketBloc({
    required VoucherBloc voucherBloc,
  })  : _voucherBloc = voucherBloc,
        super(BasketLoading()) {
    // BasketBloc() : super(BasketLoading()) {
    on<StartBasket>(_onStartBasket);
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
    on<RemoveAllProducts>(_onRemoveAllProducts);
    on<ToggleSwitch>(_onToggleSwitch);
    on<ApplyVoucher>(_onApplyVoucher);
    on<SelectDeliveryTime>(_onSelectDeliveryTime);

    _voucherSubscription = voucherBloc.stream.listen((state) {
      if (state is VoucherSelected) {
        add(
          ApplyVoucher(state.voucher),
        );
      }
    });
  }

  // @override
  // Stream<BasketState> mapEventToState(
  //   BasketEvent event,
  // ) async* {
  //   if (event is StartBasket) {
  //     yield* _mapStartBasketToState();
  //   } else if (event is AddItem) {
  //     yield* _mapAddItemToState(event, state);
  //   }
  // }

  void _onStartBasket(
    StartBasket event,
    Emitter<BasketState> emit,
  ) async {
    emit(BasketLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(
        const BasketLoaded(
          basket: Basket(),
        ),
      );
    } catch (_) {}
  }

  // Stream<BasketState> _mapStartBasketToState() async* {
  //   yield BasketLoading();
  //   try {
  //     await Future<void>.delayed(const Duration(seconds: 1));
  //     yield BasketLoaded(basket: Basket());
  //   } catch (_) {}
  // }

  void _onAddProduct(
    AddProduct event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(
              products: List.from(state.basket.products)..add(event.product),
            ),
          ),
        );
      } catch (_) {}
    }
  }

  void _onRemoveProduct(
    RemoveProduct event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(
              products: List.from(state.basket.products)..remove(event.product),
            ),
          ),
        );
      } catch (_) {}
    }
  }

  void _onRemoveAllProducts(
    RemoveAllProducts event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(
              products: List.from(state.basket.products)
                ..removeWhere((product) => product == event.product),
            ),
          ),
        );
      } catch (_) {}
    }
  }

  void _onToggleSwitch(
    ToggleSwitch event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(
              cutlery: !state.basket.cutlery,
            ),
          ),
        );
      } catch (_) {}
    }
  }

  void _onApplyVoucher(
    ApplyVoucher event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(
              voucher: event.voucher,
            ),
          ),
        );
      } catch (_) {}
    }
  }

  void _onSelectDeliveryTime(
    SelectDeliveryTime event,
    Emitter<BasketState> emit,
  ) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        emit(
          BasketLoaded(
            basket: state.basket.copyWith(
              deliveryTime: event.deliveryTime,
            ),
          ),
        );
      } catch (_) {}
    }
  }
}
