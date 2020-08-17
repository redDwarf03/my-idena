import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/pages/myIdena_home.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 14.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    const pageDecorationDisclaimer = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 14.0, color: Colors.red),
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "my Idena mobile app",
          body:
              "Welcome to \"my Idena\" !\n\nThis application is an application currently under development.\nYou use it at your own risk. In any case, the owner of this application can't be held responsible for problems related to use or bugs.\n\nIn case of bugs, please notify them on the project's Github page (see \"About\" page).\nThe Idena core team is not participating in the development of this application",
          image: Align(
            child: Image.asset('assets/images/icon.png', width: 250.0),
            alignment: Alignment.bottomCenter,
          ),
          decoration: pageDecorationDisclaimer,
          footer: Text(campaign,
              style: TextStyle(fontSize: 14.0, color: Colors.red)),
        ),
        PageViewModel(
          title: "Configuration",
          body:
              "To configure the application, you must:\n\n\nFor a Windows PC:\n* execute 'idena-go.exe' with '--rpcaddr {ip_address} --rpcport {port_number}' (don't run the windows client application)\n* in the first launch, go to 'Parameters' page\n* type 'http://{ip_address}:{port_number}' to connect to your node\n* type the api.key (cf '%appdata%\Idena\node\datadir\api.key')\n\nFor a remote server and Android phone:\n\n* install Termux or equivalent on your Android phone\n* install ssh 'pkg install openssh -y'\n* setup tunnel connection using ssh 'ssh -L 9999:localhost:9009 YOUR_VPS_IP'\n* open 'my_idena', go to 'Parameters' page and type 'http://localhost:9999' and your api key in the following file './datadir/api.key'\n",
          image: Align(
            child:
                Image.asset('assets/images/parameters-node.png', width: 345.0),
            alignment: Alignment.bottomCenter,
          ),
          decoration: pageDecoration,
          footer: Text(campaign,
              style: TextStyle(fontSize: 14.0, color: Colors.red)),
        ),
        PageViewModel(
          title: "Features to test for this version",
          body:
              "- UI & UX\n- Display your informations\n- Activate/Desactivate mining\nDonations... if you want but it would be appreciated :)\n-Simulation mode : unused",
          image: Align(
            child: Image.asset('assets/images/functionnalities-review.png',
                width: 342.0),
            alignment: Alignment.bottomCenter,
          ),
          decoration: pageDecoration,
          footer: Text(campaign,
              style: TextStyle(fontSize: 14.0, color: Colors.red)),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.grey,
        activeColor: Colors.black,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
