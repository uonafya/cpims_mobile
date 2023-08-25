import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/auth_provider.dart';
import 'package:cpims_mobile/screens/auth/widgets/important_links_widget.dart';
import 'package:cpims_mobile/widgets/custom_button.dart';
import 'package:cpims_mobile/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isloading = false;

  void loginuser({
    required String username,
    required String password,
  }) async {
    setState(() {
      _isloading = true;
    });

    try {
      await Provider.of<AuthProvider>(context, listen: false).login(
        context: context,
        password: password,
        username: username,
      );
      setState(() {
        _isloading = false;
      });
    } catch (e) {
      setState(() {
        _isloading = false;
      });
    }
  }

  final auth = LocalAuthentication();
  String authorized = " not authorized";

  Future<void> _authenticate() async {
    bool authenticated = false;

    try {
      authenticated = await auth.authenticate(
        localizedReason: "Scan your finger to authenticate",
      );
    } on PlatformException catch (e) {
      errorSnackBar(context, e.message);
    }

    setState(() {
      authorized =
          authenticated ? "Authorized success" : "Failed to authenticate";
      successSnackBar(context, 'Auth success');
    });
    final prefs = await SharedPreferences.getInstance();

    final username = prefs.getString('username');
    final password = prefs.getString('password');

    if (username != null && password != null) {
      loginuser(username: username, password: password);
    } else {
      if (context.mounted) {
        errorSnackBar(context, 'Please login with your credentials first');
      }
    }
  }

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;

    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (_) {
      if (context.mounted) {
        errorSnackBar(context, 'Unable to check biometrics');
      }
    }

    if (!mounted) return;

    setState(() {});
  }

  Future _getAvailableBiometric() async {
    List<BiometricType> availableBiometric = [];

    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (_) {
      if (context.mounted) {
        errorSnackBar(context, 'Unable to get available biometrics');
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await _checkBiometric();
      await _getAvailableBiometric();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: kSystemPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kToolbarHeight),
                  Text(
                    'Login',
                    style: GoogleFonts.openSans(
                      fontSize: ScreenUtil().setSp(28),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Directorate of Children Services (DCS)',
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
                    controller: userNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                        labelText: "Enter Username here..."),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.deny(
                        RegExp(
                          r'\s',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Password',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: _isObscure,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                      labelText: "Enter password here...",
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                    onChanged: (value) {
                      passwordController.text = value;
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
                            loginuser(
                              username: userNameController.text,
                              password: passwordController.text,
                            );
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
                      ],
                    ),
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: _authenticate,
                    child: const SizedBox(
                      height: 80,
                      width: 80,
                      child: Card(
                        child: Icon(
                          Icons.fingerprint,
                          size: 50,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
              const Footer(
                hasPartners: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
