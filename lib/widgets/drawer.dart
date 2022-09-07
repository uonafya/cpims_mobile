import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final drawerProvider = Provider.of<UIProvider>(context);
    return ListView(padding: EdgeInsets.zero, children: [
      const SizedBox(
        height: kToolbarHeight + 10,
      ),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/logo_gok.png',
              height: 30,
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          const Text('Navigation')
        ],
      ),
      const SizedBox(
        height: 6,
      ),
      const Divider(
        height: 1,
      ),
      ...List.generate(
        drawerOptions.length,
        (index) => GestureDetector(
          onTap: () {
            drawerProvider.changeDrawerOption(index);
          },
          child: index == 0
              ? homeWidget(drawerOptions[0],
                  drawerProvider.selectedDrawerOption == index, () {
                  drawerProvider.changeDrawerOption(index);
                })
              : drawerOption(drawerOptions[index],
                  index == drawerProvider.selectedDrawerOption, (val) {
                  drawerProvider.changeDrawerOption(index);
                }),
        ),
      ),
    ]);
  }

  Widget homeWidget(
      Map<String, dynamic> data, bool isSelected, Function onTap) {
    return Container(
      color: isSelected ? const Color(0xff707478) : null,
      child: ListTile(
        leading: Icon(
          data['icon'],
          size: 18,
          color: isSelected ? Colors.white : Colors.black,
        ),
        title: Text(
          data['title'],
          style: TextStyle(
              fontSize: 14, color: isSelected ? Colors.white : Colors.black),
        ),
        onTap: () {
          onTap();
          data['onTap']();
        },
      ),
    );
  }

  Widget drawerOption(
    Map<String, dynamic> data,
    bool isSelected,
    Function(bool val) onTap,
  ) {
    return Container(
      color: isSelected ? const Color(0xff707478) : null,
      child: ExpansionTile(
        iconColor: isSelected ? Colors.white : Colors.grey,
        leading: Icon(
          data['icon'],
          size: 18,
          color: isSelected ? Colors.white : Colors.black,
        ),
        trailing: Icon(
          Icons.arrow_drop_down,
          color: isSelected ? Colors.white : Colors.grey,
        ),
        title: Text(
          data['title'],
          style: TextStyle(
              fontSize: 14, color: isSelected ? Colors.white : Colors.black),
        ),
        onExpansionChanged: (value) {
          onTap(value);
        },
        initiallyExpanded: isSelected,
        children: List.generate(data['children'].length, (index) {
          return Container(
            color: isSelected ? Colors.grey[300] : null,
            child: ListTile(
              leading: Container(
                height: 40,
                width: 5,
                color: Colors.grey,
              ),
              title: Text(
                data['children'][index]['title'],
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
              onTap: () {
                data['children'][index]['onTap']();
              },
            ),
          );
        }),
      ),
    );
  }
}
