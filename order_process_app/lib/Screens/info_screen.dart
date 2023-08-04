import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info!'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 200.0, horizontal: 30.0),
        child: Column(
          children: [
            const Text(
                'This app is a demo app created by Aashish Batra using Flutter '
                'Thank you for using this app please also checkout my other projects '
                'as well on my website just click on button below:'
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(onPressed: (){
                launch("https://aashish-portfolio-website.netlify.app/");
              },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 100.0,right: 100.0),
                    child: Text('URL'),
                  )
              ),
            )
          ],

        ),
      ),
    );
  }
}
