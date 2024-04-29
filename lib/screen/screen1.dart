import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:otp_provider_21_03_24/provider/provider.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class HomepageOne extends StatefulWidget {
  const HomepageOne({super.key});

  @override
  State<HomepageOne> createState() => _HomepageOneState();
}

class _HomepageOneState extends State<HomepageOne> {
  TextEditingController number = TextEditingController();
  TextEditingController numberone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var obj = Provider.of<OtpProvider>(context, listen: false);
    return Scaffold(
      body: Consumer<OtpProvider>(
        builder: (a,b,c) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (obj.otpsend == false)
                  TextField(
                    controller: number,
                    decoration: InputDecoration(
                        hintText: 'ENTER YOUR NUMBER',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40))),
                  ),
                if (obj.otpsend == true)
                  Pinput(
                    controller: numberone,
                    length: 6,
                  ),
                Gap(25),
                ElevatedButton(
                    onPressed: () {
                      if (obj.otpsend) {
                        obj.verifyId(numberone.text, context);
                      } else {
                        obj.sendOtp('+91${number.text}', context);
                        number.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 15)),
                    child: Text('S U B M I T'))
              ],
            ),
          );
        }
      ),
    );
  }
}
