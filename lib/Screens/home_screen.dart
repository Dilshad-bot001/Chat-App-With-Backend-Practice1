import 'package:chat_application_with_backend_practice1/Pages/pages.dart';
import 'package:chat_application_with_backend_practice1/Screens/screens.dart';
import 'package:chat_application_with_backend_practice1/Widgets/widget.dart';
import 'package:chat_application_with_backend_practice1/app.dart';
import 'package:chat_application_with_backend_practice1/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // for storing the value of index when tapped
  final ValueNotifier<int> pageIndex = ValueNotifier(0);

  // for storing the value of title on the basis of index when tapped
  final ValueNotifier<String> title = ValueNotifier('Messages');


  // list of pages
  List pages = const [
    MessagesPage(),
    NotificationsPage(),
    CallsPage(),
    ContactsPage()
  ];

  // list of pages titles
  final pageTitles = const [
    "Messages",
    "Notifications",
    "Calls",
    "Contacts",
  ];

  // setting values of tapped index icon and title in the variable created above
  void _onNavigationItemSelected(index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        // appbar designing section
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        elevation: 0.0,

        // setting the values of title of appbar on tha basis of tapped icon/index
        title: Center(
          child: ValueListenableBuilder(
            valueListenable: title,
            builder: (BuildContext context, String value, _) {
              return Text(
                value,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              );
            },
          ),
        ),


        //search icon button section
        leadingWidth: 54.0,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: Icons.search,
            onTap: () {
              'tapped on search button';
            })),


        //avatar on appbar section
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Hero(
              tag: 'hero-profile-picture',
              child: Avatar.small(
                url: context.currentUserImage,
                onTap: (){
                  Navigator.of(context).push(ProfileScreen.route);
                }
              ),
            ),
          )
        ],
      ),


      //body of scaffold
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),

      // bottom navigation bar section and getting the value of tapped index icon
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {

  // valuechanged widget return the values to the upper class after values get changed
  final ValueChanged<int> onItemSelected;

  const _BottomNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;


  // this function sets the value of selected index and onItemSelected to return the values to upper class
  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {


    //bottom navigation bar designing section
    final brightness = Theme.of(context).brightness;
    return Card(
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0.0,
      margin: const EdgeInsets.all(0.0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavigationBarItem(
                  label: "Messages",
                  icon: CupertinoIcons.bubble_left_bubble_right_fill,
                  index: 0,
                  ontap: handleItemSelected,
                  isSelected: (selectedIndex == 0),
                ),
                _NavigationBarItem(
                  label: "Notifications",
                  icon: CupertinoIcons.bell_solid,
                  index: 1,
                  ontap: handleItemSelected,
                  isSelected: (selectedIndex == 1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GlowingActionButton(color: AppColors.secondary, icon: CupertinoIcons.add, onPressed: (){
                    'a new message';
                  }),
                ),
                _NavigationBarItem(
                  label: "Calls",
                  icon: CupertinoIcons.phone_fill,
                  index: 2,
                  ontap: handleItemSelected,
                  isSelected: (selectedIndex == 2),
                ),
                _NavigationBarItem(
                  label: "Contacts",
                  icon: CupertinoIcons.person_2_fill,
                  index: 3,
                  ontap: handleItemSelected,
                  isSelected: (selectedIndex == 3),
                ),
              ],
            ),
        ),
      ),
    );
  }
}


//bottom navigation bar items designing section
class _NavigationBarItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final int index;
  final ValueChanged<int> ontap;
  final bool isSelected;

  const _NavigationBarItem(
      {Key? key,
      required this.label,
      required this.icon,
      required this.index,
      required this.ontap,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        ontap(index);
      },
      child: SizedBox(
        width: 70.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [


            //bottom navigation bar icons section
            Icon(
              icon,
              size: 20.0,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(
              height: 8.0,
            ),


            //bottom navigation bar text section
            Text(
              label,
              style: isSelected
                  ? const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    )
                  : const TextStyle(fontSize: 11),
            )
          ],
        ),
      ),
    );
  }
}
