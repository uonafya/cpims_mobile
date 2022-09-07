import 'package:cpims_mobile/constants.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key, this.hasPartners = true}) : super(key: key);
  final bool hasPartners;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        const Text(
          '© 2022. All Rights Reserved. Version: 3.0.0',
          style: const TextStyle(color: kTextGrey, fontSize: 12),
        ),
        if (hasPartners)
          const SizedBox(
            height: 10,
          ),
        if (hasPartners)
          Image.asset(
            'assets/images/logo_private.png',
            height: 50,
          ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
