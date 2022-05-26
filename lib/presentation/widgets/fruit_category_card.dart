import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groceries/presentation/bloc/fruit_status_cubit.dart';
import 'package:intl/intl.dart';

import '../../common/styles/colors.dart';
import '../../data/models/fruit.dart';
import '../bloc/cart_bloc.dart';

class FruitCategoryCard extends StatelessWidget {
  final Fruit fruit;
  const FruitCategoryCard({Key? key, required this.fruit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(8, 14, 8, 14),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: MyColor.greySoftColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 78,
                  width: 78,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: const BoxDecoration(
                    color: MyColor.greySoftColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Image.asset(
                      fruit.imageUrl,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fruit.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColor.blackTextColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${NumberFormat.currency(
                          locale: "id-ID",
                          symbol: "Rp ",
                          decimalDigits: 0,
                        ).format(fruit.price)}/kg',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7D7777),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        height: 18,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Image.asset(
                              'assets/icons/icon_star.png',
                              height: 17,
                            );
                          },
                          itemCount: fruit.rating,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () async {
                final Fruit? result = await context
                    .read<FruitStatusCubit>()
                    .getFruitById(fruit.id);

                if (result == null) {
                  // ignore: use_build_context_synchronously
                  context.read<CartBloc>().add(SaveCartFruitEvent(fruit));

                  Fluttertoast.showToast(
                    msg: 'Added to cart',
                    backgroundColor: MyColor.yellowColor,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: '${result.name} Already in cart',
                    backgroundColor: MyColor.primaryColor,
                  );
                }
              },
              child: Container(
                height: 35,
                width: 73,
                decoration: BoxDecoration(
                  color: MyColor.primaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  border: Border.all(
                    color: MyColor.greySoftColor.withOpacity(0.63),
                    width: 1,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Buy',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
