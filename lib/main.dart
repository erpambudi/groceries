import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/common/styles/theme.dart';
import 'package:groceries/presentation/bloc/account_bloc.dart';
import 'package:groceries/presentation/bloc/cart_bloc.dart';
import 'package:groceries/presentation/pages/main_page.dart';
import '../injection.dart' as di;
import 'presentation/bloc/fruit_status_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<AccountBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<CartBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<FruitStatusCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Groceries',
        theme: MyTheme.light(),
        home: const MainPage(),
      ),
    );
  }
}
