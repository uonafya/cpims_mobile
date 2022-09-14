import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/auth/widgets/important_links_widget.dart';
import 'package:cpims_mobile/screens/homepage/home_page.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import '../../services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = "";
  String _password = "";


  loginuser() async {
    // var box = await Hive.openBox("cpims");
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();


    // print(_username+"\n"+_password);
    if(_username.isEmpty) {
      errorSnackBar(context, "User name cannot be empty.");
    }else if(_password.isEmpty) {
      errorSnackBar(context, "Password cannot be empty.");
    }else{
      http.Response response = await AuthService.login(_password, _username);
      Map responseMap = jsonDecode(response.body);
      if(response.statusCode==200){
        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Homepage()));
        // print(responseMap["token"]);

        // await box.put("token", responseMap['token']);
        // print(box.get("token"));
        // Save an integer value to 'counter' key.
        await prefs.setString('authenticated', responseMap['token']);

        Get.to(() => const Homepage());
      }
      else{
        errorSnackBar(context, responseMap.values.first[0]);
      }

    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: kSystemPadding,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: kToolbarHeight),
            Text(
              'Login',
              style: GoogleFonts.openSans(
                fontSize: ScreenUtil().setSp(28),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            // const SizedBox(height: kToolbarHeight + 40),
            // const Divider(),
            Text(
              'Department of Children Services (DCS)',
              style: GoogleFonts.openSans(
                fontSize: ScreenUtil().setSp(12),
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              'Provide the required details to log in',
              style: TextStyle(color: kTextGrey),
            ),
            const SizedBox(height: 15),
            const Text(
              'Username',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: 'Username',
              onChanged: (value){
                _username = value;
              },
            ),
            const SizedBox(height: 15),
            const Text(
              'Password',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: 'Password',
              onChanged: (value){
                _password = value;
              },
            ),
            const SizedBox(height: 15),
            CustomButton(
              text: 'Sign In',
              onTap: () {
                loginuser();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: const TextSpan(
                  text: 'Not registered yet? Click ',
                  style: TextStyle(fontSize: 13, color: kTextGrey),
                  children: [
                    TextSpan(
                      text: 'here',
                      style: TextStyle(
                        color: kPrimaryColor,
                      ),
                    ),
                    TextSpan(
                      text: ' to request for access',
                    )
                  ]),
            ),
            const SizedBox(
              height: 8,
            ),
            RichText(
              text: const TextSpan(
                  text: 'Forgot password? Click ',
                  style: TextStyle(fontSize: 13, color: kTextGrey),
                  children: [
                    TextSpan(
                      text: 'here',
                      style: TextStyle(
                        color: kPrimaryColor,
                      ),
                    ),
                    TextSpan(
                      text: ' to change password',
                    )
                  ]),
            ),
            const SizedBox(
              height: 30,
            ),
            const Center(
              child: Text(
                'Important Links',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                ImportantLinksWidget(
                  title: 'Status Page',
                  assetLink: 'assets/images/statuspage.jpg',
                ),
                ImportantLinksWidget(
                  title: 'CPIMS Docs',
                  assetLink: 'assets/images/cpimsdocs.png',
                ),
                ImportantLinksWidget(
                  title: 'DCS Instance',
                  assetLink: 'assets/images/reports.png',
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Center(
              child: Text(
                'Partners',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Image.asset(
              'assets/images/logo_public.jpg',
              height: 80,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Image.asset(
                'assets/images/healthit.jpg',
                height: 60,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Footer(
              hasPartners: false,
            ),
          ]),
        ),
      ),
    );
  }
}
