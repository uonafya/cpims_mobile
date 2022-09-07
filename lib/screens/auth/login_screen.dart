import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/screens/auth/widgets/important_links_widget.dart';
import 'package:cpims_mobile/screens/homepage/home_page.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/custom_text_field.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: kSystemPadding,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: kToolbarHeight + 40),
            Text(
              'Department of Children Services\n(DCS)',
              style: GoogleFonts.openSans(
                fontSize: ScreenUtil().setSp(18),
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const Divider(),
            const SizedBox(height: 30),
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
            const CustomTextField(
              hintText: 'Username',
            ),
            const SizedBox(height: 15),
            const Text(
              'Password',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const CustomTextField(
              hintText: 'Password',
            ),
            const SizedBox(height: 15),
            CustomButton(
              text: 'Sign In',
              onTap: () {
                Get.to(() => const Homepage());
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
