import 'package:cpims_mobile/widgets/app_bar.dart';
import 'package:cpims_mobile/widgets/custom_card.dart';
import 'package:cpims_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Image.network(
              "",
              width: double.infinity,
              fit: BoxFit.fitWidth,
              errorBuilder:
                  (BuildContext context, Object exception, StackTrace? stackTrace) {
                return const Image(
                    image: AssetImage('assets/images/user-2.jpg'));
              },
            ),
            const SizedBox(height: 10,),
            const CustomCard(title: "ACCOUNT DETAILS", children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Username:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 10,),
                  Flexible(child: Text("Someusername")),
                ],
              ),
              SizedBox(height: 4,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CPIMS ID:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 10,),
                  Flexible(child: Text("123134973"))
                ],
              ),
              SizedBox(height: 4,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email Address:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 10,),
                  Flexible(child: Text("test@gmail.com")),
                ],
              ),
              SizedBox(height: 4,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sub-county:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 10,),
                  Flexible(child: Text("Madaraka")),
                ],
              ),
              SizedBox(height: 4,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ward:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 10,),
                  Flexible(child: Text("Madaraka")),
                ],
              ),
              SizedBox(height: 4,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Organization Unit(s):",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 10,),
                  Flexible(child: Text("MAKADARA SUB COUNTY CHILDREN OFFICE")),
                  // Text("MAKADARA SUB COUNTY CHILDREN OFFICE")
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
