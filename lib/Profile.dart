import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';
import '../models/User.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);
  static String routeName = 'MyProfileScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          InkWell(
            onTap: () {
              // Envoyer un rapport à la direction de l'école si vous souhaitez apporter des modifications à votre profil
            },
            child: Container(
              padding: EdgeInsets.only(right: kDefaultPadding / 2),
              child: Row(
                children: [
                  Icon(Icons.report_gmailerrorred_outlined),
                  kHalfWidthSizedBox,
                  Text(
                    'Report',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: kOtherColor,
        child: Column(
          children: [
            Container(
              width: 100.w,
              height: SizerUtil.deviceType == DeviceType.tablet ? 19.h : 15.h,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: kBottomBorderRadius,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: SizerUtil.deviceType == DeviceType.tablet
                        ? 12.w
                        : 13.w,
                    backgroundColor: kSecondaryColor,
                    backgroundImage: AssetImage('images/profile.png'),
                  ),
                  kWidthSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user.nom,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium,
                      ),
                    ],
                  )
                ],
              ),
            ),
            sizedBox,
            ProfileDetailColumn(
              title: 'Carte d identité ',
              value: user.cin,
            ),
            sizedBox,
            ProfileDetailColumn(
              title: 'Email',
              value: user.email,
            ),
            ProfileDetailColumn(
              title: 'Name',
              value: user.nom,
            ),
            ProfileDetailColumn(
              title: 'Etat',
              value: user.isActive.toString(),
            ),
            ProfileDetailColumn(
              title: 'Phone Number',
              value: user.phone,
            ),


          ],
        ),
      ),
    );
  }

}





class ProfileDetailColumn extends StatelessWidget {
  final String title;
  final String value;

  const ProfileDetailColumn({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: kTextBlackColor,
                  fontSize: SizerUtil.deviceType == DeviceType.tablet ? 7.sp : 11.sp,
                ),
              ),
              kHalfSizedBox,
              Text(value, style: Theme.of(context).textTheme.caption),
              kHalfSizedBox,
              SizedBox(
                width: 92.w,
                child: Divider(
                  thickness: 1.0,
                ),
              )
            ],
          ),
          Icon(
            Icons.lock_outline,
            size: 10.sp,
          ),
        ],
      ),
    );
  }
}
