import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
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
                    Image.asset(
                      'assets/ic_logo.png',
                      width: 120, // Adjust the width as needed
                    ),
                    SizedBox(height: 16), // Add spacing between logo and text
                    // Typewriter Text
                    Center(
                      child: TypewriterText(
                        text: "3F Oil Palm",
                        color: Color(0xFFCE0E2D),
                      ),
                    ),
                    SizedBox(height: 8), // Add spacing between the two lines
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
