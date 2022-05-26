import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/common/styles/colors.dart';

import '../../data/models/fruit.dart';
import '../bloc/account_bloc.dart';
import '../widgets/fruit_category_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FruitCategories _selectedCategory = FruitCategories.apple;
  final List<Fruit> _fruitsByCategory = [];

  _updateFruitsByCategory() {
    _fruitsByCategory.clear();
    _fruitsByCategory.addAll(
        fruitData.where((element) => element.category == _selectedCategory));
  }

  @override
  void initState() {
    super.initState();
    _updateFruitsByCategory();
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: const [
                Text(
                  'Find',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: MyColor.yellowColor,
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  'Fresh Groceries',
                  style: TextStyle(
                    fontSize: 24,
                    color: MyColor.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state is AccountHasData) {
                return SizedBox(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                    backgroundColor: MyColor.greySoftColor,
                    backgroundImage: NetworkImage(
                      state.result.picture.large,
                    ),
                  ),
                );
              } else {
                return const SizedBox(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                    backgroundColor: MyColor.greySoftColor,
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
      child: TextField(
        style: TextStyle(
          color: MyColor.blackTextColor,
        ),
        cursorColor: MyColor.primaryColor,
        decoration: InputDecoration(
          hintText: 'Search Groceries',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: MyColor.greyTextColor,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14),
            child: SizedBox(
              width: 18,
              height: 18,
              child: Image.asset(
                'assets/icons/icon_search.png',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _categoryItem(FruitCategories e) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedCategory = e;
            _updateFruitsByCategory();
          });
        },
        child: Container(
          height: 39,
          margin: EdgeInsets.only(
            right: e == FruitCategories.values.first ? 16 : 0,
            left: e == FruitCategories.values.last ? 16 : 0,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: e == _selectedCategory
                ? MyColor.primaryColor
                : MyColor.greySoftColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(
            child: Text(
              e.name[0].toUpperCase() + e.name.substring(1),
              style: TextStyle(
                color: e != _selectedCategory
                    ? const Color(0xFFA09B9B)
                    : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _categories() {
    return Container(
      margin: const EdgeInsets.fromLTRB(38, 21, 38, 21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColor.blackTextColor,
            ),
          ),
          const SizedBox(
            height: 21,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: FruitCategories.values
                  .map(
                    (e) => _categoryItem(e),
                  )
                  .toList()),
          const SizedBox(
            height: 17,
          ),
          Column(
            children: _fruitsByCategory
                .map((e) => FruitCategoryCard(fruit: e))
                .toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: false,
            toolbarHeight: 90,
            elevation: 0,
            titleSpacing: 0,
            backgroundColor: Colors.white,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            title: _header(),
            bottom: AppBar(
              elevation: 0,
              titleSpacing: 0,
              toolbarHeight: 86,
              backgroundColor: Colors.white,
              title: _searchBar(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _categories(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
