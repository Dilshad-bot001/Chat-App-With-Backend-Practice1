import 'package:chat_application_with_backend_practice1/Pages/calls_page.dart';
import 'package:chat_application_with_backend_practice1/Pages/contacts_page.dart';
import 'package:chat_application_with_backend_practice1/Pages/messages_page.dart';
import 'package:chat_application_with_backend_practice1/Pages/notifications_page.dart';
import 'package:chat_application_with_backend_practice1/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({ Key? key }) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);

  List pages = const [
    MessagesPage(),
    NotificationsPage(),
    CallsPage(),
    ContactsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _){
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: (index){
          pageIndex.value = index;
        },
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  
  final ValueChanged<int> onItemSelected;
  
  const _BottomNavigationBar({
    Key? key, required this.onItemSelected,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavigationBarItem(label: "Messages", icon: CupertinoIcons.bubble_left_bubble_right_fill, index: 0, ontap: onItemSelected,),
          _NavigationBarItem(label: "Notifications", icon: CupertinoIcons.bell_solid, index: 1, ontap: onItemSelected,),
          _NavigationBarItem(label: "Calls", icon: CupertinoIcons.phone_fill, index: 2, ontap: onItemSelected,),
          _NavigationBarItem(label: "Contacts", icon: CupertinoIcons.person_2_fill, index: 3, ontap: onItemSelected,),
          
        ],
      )
    );
  }
}

class _NavigationBarItem extends StatelessWidget {

  final String label;
  final IconData icon;
  final int index;
  final ValueChanged<int> ontap;

  const _NavigationBarItem({ Key? key, required this.label, required this.icon, required this.index, required this.ontap }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        ontap(index);
      },
      child: SizedBox(
        height: 70.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20.0,
            ),
            const SizedBox(height: 8.0,),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11
              ),
            )
          ],
        ),
      ),
    );
  }
}