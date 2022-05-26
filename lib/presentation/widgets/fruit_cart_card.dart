import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/presentation/bloc/cart_bloc.dart';
import 'package:intl/intl.dart';

import '../../common/styles/colors.dart';
import '../../data/models/fruit.dart';

class FruitCartCard extends StatefulWidget {
  final Fruit fruit;
  const FruitCartCard({Key? key, required this.fruit}) : super(key: key);

  @override
  State<FruitCartCard> createState() => _FruitCartCardState();
}

class _FruitCartCardState extends State<FruitCartCard> {
  int quantity = 0;

  @override
  void initState() {
    setState(() {
      quantity = widget.fruit.totalInCart;
    });
    super.initState();
  }

  _onAddQuantity() {
    setState(() {
      quantity = quantity + 1;
    });
    context.read<CartBloc>().add(UpdateCartFruitEvent(widget.fruit, quantity));
    context.read<CartBloc>().add(GetCartsEvent());
  }

  _onReduceQuantity() {
    if (quantity == 1) {
      _onRemoveItem();
    } else {
      setState(() {
        quantity = quantity - 1;
      });
      context
          .read<CartBloc>()
          .add(UpdateCartFruitEvent(widget.fruit, quantity));
      context.read<CartBloc>().add(GetCartsEvent());
    }
  }

  _onRemoveItem() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Remove ${widget.fruit.name}',
            style: const TextStyle(
              color: MyColor.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: Text(
              'Are you sure you want to remove ${widget.fruit.name} from cart?'),
          actions: [
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: MyColor.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Remove',
                style: TextStyle(
                  color: MyColor.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                context
                    .read<CartBloc>()
                    .add(RemoveCartFruitEvent(widget.fruit));
                context.read<CartBloc>().add(GetCartsEvent());
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
      padding: const EdgeInsets.fromLTRB(14, 19, 14, 23),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: MyColor.greySoftColor,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.fruit.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MyColor.blackTextColor,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
              InkWell(
                onTap: _onRemoveItem,
                child: Image.asset(
                  'assets/icons/icon_close.png',
                  width: 28,
                  height: 28,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 21,
          ),
          Row(
            children: [
              Container(
                height: 58,
                width: 58,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: const BoxDecoration(
                  color: MyColor.greySoftColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Image.asset(
                    widget.fruit.imageUrl,
                  ),
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${NumberFormat.currency(
                              locale: "id-ID",
                              symbol: "Rp ",
                              decimalDigits: 0,
                            ).format(widget.fruit.price)}/kg',
                            style: const TextStyle(
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
                              itemCount: widget.fruit.rating,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: _onReduceQuantity,
                          child: Container(
                            width: 30,
                            height: 24,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF5BB98B),
                                width: 2,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                '-',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          quantity.toString(),
                          style: TextStyle(
                            color: MyColor.blackTextColor,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: _onAddQuantity,
                          child: Container(
                            width: 30,
                            height: 24,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF5BB98B),
                                width: 2,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                '+',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
