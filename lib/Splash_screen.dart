import 'dart:async';
import 'package:akshayaflutter/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CommonUtils/Constants.dart';
import 'homepage.dart';


class  SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen>   with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isLogin = false;
  bool welcome = false;
  int langID = 0;
  @override
  void initState() {
    super.initState();
    loadData();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (isLogin) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => homepage(),
          ));
        } else {
          if (welcome) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => login(),
            ));
          }

          else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => login(),
            ));
          }
        }
      }
      });


    _animationController.forward();
  }
  void navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => login()),
    );
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height, // Set container height to the screen height
          child: Stack(
            children: [
              // Background Image
              Image.asset(
                'assets/appbg.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              // Background Color with Opacity
              Container(
                color: Color(0x8D000000), // Background color with opacity
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (BuildContext context, Widget? child) {
                        return Transform.scale(
                          scale: _animation.value,
                          child: Image.asset(
                            'assets/ic_logo.png',
                            width: 200,
                            height: 200,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16), // Add spacing between logo and text
                    // Typewriter Text
                    Center(
                      child: TypewriterText(
                        text: "3F Oil Palm",
                        color: Color(0xFFCE0E2D),
                      ),
                    ),
                   // Add spacing between the two lines
                    Center(
                      child: TypewriterText(
                        text: "Sowing for a Better Future",
                        color: Color(0xFFe86100),
                      ),
                    ),
                  ],
                ),
              ),
            ],



          ),
        ),
      ),
    );
  }
    Future<void> loadData() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        isLogin = prefs.getBool(Constants.IS_LOGIN) ?? false;
        welcome = prefs.getBool(Constants.WELCOME) ?? false;
        langID = prefs.getInt("lang") ?? 0;
      });
    }
}


class TypewriterText extends StatefulWidget {
  final String text;
  final Color color;

  TypewriterText({
    required this.text,
    required this.color,
  });

  @override
  _TypewriterTextState createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _text = ""; // Initial empty text
  int _index = 0;   // Index for tracking characters

  @override
  void initState() {
    super.initState();
    // Start the typewriter animation
    _startTypewriterAnimation();
  }

  void _startTypewriterAnimation() {
    const Duration duration = const Duration(milliseconds: 100);

    Timer.periodic(duration, (Timer timer) {
      if (_index < widget.text.length) {
        setState(() {
          _text += widget.text[_index];
          _index++;
        });
      } else {
        // Text animation completed, cancel the timer
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Center(
          child: Text(
            _text,
            style: TextStyle(
              fontSize: 24,  // Adjust the font size as needed
              color: widget.color, // Use the provided text color
            ),
          ),
        ),
      ],
    );
  }
}
