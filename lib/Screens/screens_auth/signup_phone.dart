import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:vrep/Core/theme.dart';

class PhoneSignUpPage extends StatelessWidget {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.keyboard_arrow_left),
                    ),
                    Text(
                      'Registration',
                      textAlign: TextAlign.center,
                    ),
                    Icon(Icons.info_outline)
                  ],
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        'Add your phone number',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      Text(
                        'We will send a verification code to your phone number to verify you are a real person. You will also use this phone number to sign in.',
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                //Text('Phone number'),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: CountryCodePicker(
                        initialSelection: 'HU',
                        onChanged: (CountryCode code) {},
                        textStyle: TextStyle(fontSize: 18),
                        flagWidth: 32,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Text(
                          'Continue',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(context, '/otpverificationpage', (Route<dynamic> route) => false);
                        },
                      ),
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
