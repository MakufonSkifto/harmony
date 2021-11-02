import 'package:flutter/material.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/utilites/page_enum.dart';
import 'package:harmony/widgets/general_use/harmony_bottom_navigation_bar.dart';


class AccountPage extends StatefulWidget {

  final HarmonyUser user;
  const AccountPage(this.user, {Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: Image.asset("assets/images/dummy-profile-pic.png", scale: 3),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text("Emir Sürmen", style: TextStyle(fontSize: 20)),
              )
            ],
          ),
        )
      ),
      bottomNavigationBar: HarmonyBottomNavigationBar(
          PAGE_ENUM.ACCOUNT_PAGE
      ),
    );
  }
}

