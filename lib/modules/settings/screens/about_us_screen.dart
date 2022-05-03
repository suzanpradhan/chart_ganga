import 'package:flutter/material.dart';

import '../../../constants/custom_colors.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        title: Text(
          "About Us",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: Image.asset(
                    "assets/images/icon.png",
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Chart Ganga",
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '''E-mail - chartganga@gmail.com
address - At post khed dist Ratnagiri
Tole - Khed 415709
State- Maharashtra 

Any kind of objection  and help and support
please reach out to us on 
Email - chartganga@gmail.com
''',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
