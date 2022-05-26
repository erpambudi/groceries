import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/common/styles/colors.dart';
import 'package:groceries/domain/entities/account.dart';
import 'package:groceries/presentation/bloc/account_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget _accountPhoto(Account account) {
    return Column(
      children: [
        SizedBox(
          height: 270,
          child: Stack(
            children: [
              Container(
                height: 193,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF3F6).withOpacity(0.48),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 160,
                      width: 160,
                      child: Stack(
                        children: [
                          const SizedBox(
                            height: 160,
                            width: 160,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              height: 140,
                              width: 140,
                              child: CircleAvatar(
                                backgroundColor: MyColor.greySoftColor,
                                backgroundImage: NetworkImage(
                                  account.picture.large,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${account.name.first} ${account.name.last}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 56,
        ),
      ],
    );
  }

  Widget _accountDetail(Account account) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.fromLTRB(42, 52, 42, 42),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFEFF3F6).withOpacity(0.48),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(50),
            ),
          ),
          child: Column(
            children: [
              _accountDescItem(
                  'assets/icons/icon_id_card.png', account.login.username),
              _accountDescItem('assets/icons/icon_email.png', account.email),
              _accountDescItem('assets/icons/icon_phone.png', account.phone),
              _accountDescItem('assets/icons/icon_location.png',
                  '${account.location.state} - ${account.location.country}',
                  subtitle:
                      '${account.location.street.name} - ${account.location.street.number}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _accountDescItem(String iconPath, String title, {String? subtitle}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: MyColor.borderColor,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            height: 29,
            width: 29,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: MyColor.blackTextColor,
                  ),
                ),
                subtitle != null
                    ? Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: MyColor.blackTextColor,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
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
          'Profile',
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
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AccountHasData) {
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      _accountPhoto(state.result),
                    ],
                  ),
                ),
                _accountDetail(state.result),
              ],
            );
          }
          if (state is AccountError) {
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
