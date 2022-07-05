import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/common/styles/colors.dart';
import 'package:groceries/presentation/widgets/fruit_cart_card.dart';
import 'package:intl/intl.dart';

import '../bloc/cart_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<CartBloc>().add(GetCartsEvent()));
  }

  Widget _checkoutButton(int totalItems, int totalPrice) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 12, 24, 12),
      margin: const EdgeInsets.fromLTRB(30, 14, 30, 23),
      decoration: const BoxDecoration(
        color: MyColor.primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total $totalItems Item',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  height: 2,
                  width: 87,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  NumberFormat.currency(
                    locale: "id-ID",
                    symbol: "Rp ",
                    decimalDigits: 0,
                  ).format(totalPrice),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            'Checkout',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Cart Product',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: MyColor.primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartStateLoaded) {
            if (state.fruits.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.shopping_cart,
                      size: 100,
                      color: MyColor.greySoftColor,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'No fruits in cart',
                      style: TextStyle(
                        fontSize: 20,
                        color: MyColor.greyTextColor,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      key: const PageStorageKey('fruits'),
                      itemBuilder: (context, i) {
                        if (i < state.fruits.length) {
                          return Padding(
                            padding: EdgeInsets.only(
                              top: (state.fruits[i] == state.fruits.first
                                  ? 38
                                  : 0),
                            ),
                            child: FruitCartCard(fruit: state.fruits[i]),
                          );
                        } else {
                          return _checkoutButton(
                              state.totalItems, state.totalPrice);
                        }
                      },
                      itemCount: state.fruits.length + 1,
                    ),
                  ),
                ],
              );
            }
          } else if (state is CartStateError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
