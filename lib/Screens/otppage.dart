import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vrep/Core/theme.dart';

class OtpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: MyTheme.padding_horizontal,
                vertical: MyTheme.padding_vertical),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'Confirm verification code',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  onChanged: (String pincode) {},
                  backgroundColor: Colors.transparent,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        "Didn't receive a message? Resend verification code",
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      InkWell(
                        child: Text(
                          'Confirm',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/initialdetails', (route) => false);
                        },
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                /* Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Privacy Policy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ), */
              ],
            ),
          ),
        ),
      ),
    );
  }
}
