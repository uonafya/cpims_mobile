import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/Dashboard/dash_service.dart';
import 'package:cpims_mobile/screens/auth/widgets/important_links_widget.dart';
import 'package:cpims_mobile/screens/homepage/home_page.dart';
import 'package:cpims_mobile/services/api_service.dart';
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

import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = "";
  String _password = "";
  bool _isObscure = true;
  bool _isloading = false;

  loginuser() async {
    setState(() {
      _isloading = true;
    });

    // var box = await Hive.openBox("cpims");
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

    // print(_username+"\n"+_password);
    if (_username.isEmpty) {
      errorSnackBar(context, "User name cannot be empty.");
      setState(() {
        _isloading = false;
      });
    } else if (_password.isEmpty) {
      errorSnackBar(context, "Password cannot be empty.");
      setState(() {
        _isloading = false;
      });
    } else {
      http.Response response = await AuthService.login(_password, _username);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Homepage()));
        print(responseMap.toString());

        // print(">>>>>>>>>> dash data" + DashService().getDashData().toString());
        // Save an integer value to 'counter' key.
        await prefs.setString('access_token', responseMap['access']);
        await prefs.setString('refresh_token', responseMap['refresh']);
        // await prefs.setString('dash_data', DashService().getDashData());

        Future.delayed(Duration(seconds: 3), () {
          setState(() {
            _isloading = false;
          });

          Get.off(() => const Homepage(),
              transition: Transition.fadeIn, duration: Duration(seconds: 1));
        });

        successSnackBar(context, "Login was successfull");
      } else {
        errorSnackBar(context, responseMap.values.first[0]);
        setState(() {
          _isloading = false;
        });
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
            TextFormField(
              // hintText: 'Username',
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                  labelText: "Enter Username here..."),
              onChanged: (value) {
                _username = value;
              },
            ),
            const SizedBox(height: 15),
            const Text(
              'Password',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              obscureText: _isObscure,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                  labelText: "Enter password here...",
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )),
              onChanged: (value) {
                _password = value;
              },
            ),
            const SizedBox(height: 15),
            _isloading
                ? SpinKitFadingCircle(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: index.isEven ? Colors.red : Colors.green,
                        ),
                      );
                    },
                  )
                : CustomButton(
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
