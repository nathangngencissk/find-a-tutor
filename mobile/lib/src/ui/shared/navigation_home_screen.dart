import 'package:find_a_tutor/src/ui/theme/theme.dart';
import 'package:find_a_tutor/src/ui/shared/custom_drawer/drawer_user_controller.dart';
import 'package:find_a_tutor/src/ui/shared/custom_drawer/home_drawer.dart';
import 'package:find_a_tutor/src/ui/views/feedback/feedback_screen.dart';
import 'package:find_a_tutor/src/ui/views/help/help_screen.dart';
import 'package:find_a_tutor/src/ui/views/home/navigationBar.dart';
import 'package:find_a_tutor/src/ui/views/invite_friend/invite_friend_screen.dart';
import 'package:find_a_tutor/src/ui/views/myProfile/profile.dart';
import 'package:flutter/material.dart';

class NavigationHomeScreen extends StatefulWidget {
  final VoidCallback shouldLogOut;

  NavigationHomeScreen({Key key, this.shouldLogOut}) : super(key: key);

  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = MyBottomNavigationBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            shouldLogOut: widget.shouldLogOut,
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          screenView = HelpScreen();
        });
      } else if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = MyBottomNavigationBar();
        });
      } else if (drawerIndex == DrawerIndex.FeedBack) {
        setState(() {
          screenView = FeedbackScreen();
        });
      } else if (drawerIndex == DrawerIndex.Invite) {
        setState(() {
          screenView = InviteFriend();
        });
      } else if (drawerIndex == DrawerIndex.Profile) {
        setState(() {
          screenView = Profile();
        });
      }
    }
  }
}
