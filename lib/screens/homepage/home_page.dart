import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/homepage/widgets/graph_widget.dart';
import 'package:cpims_mobile/screens/homepage/widgets/homepage_card.dart';
import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(height: 20),
          const Text('4THE CHILD - Dashboard',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 5),
          const Text(
            'Application data and usage summary',
            style: TextStyle(color: kTextGrey),
          ),
          const SizedBox(height: 10),
          ...List.generate(
            homeCardsTitles.length,
            (index) => HomepageCard(
              data: homeCardsTitles[index],
            ),
          ),
          // ...List.generate(
          //     5,
          //     (index) => GraphWidget(
          //           title: graphTitles[index],
          //         )),
        ],
      ),
    );
  }
}
