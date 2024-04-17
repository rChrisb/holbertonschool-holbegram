import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../widgets/utility/global_variable.dart';

class Responsivelayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const Responsivelayout({
    Key? key,
    required this.webScreenLayout,
    required this.mobileScreenLayout,
  }) : super(key: key);

  @override
  State<Responsivelayout> createState() => _ResponsivelayoutState();
}

class _ResponsivelayoutState extends State<Responsivelayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  // store the user data in the provider
  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= webScreenWidth) {
            return widget.webScreenLayout;
          } else {
            return widget.mobileScreenLayout;
          }
        }
    );
  }
}
