import 'package:flutter/material.dart';
import 'package:horloge/ecrans/chrono.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int heure = 0;
  int minutes = 0;
  int secondes = 0;
  int millisecondes = 0;

  bool chrono = false;
  Icon iconStart = const Icon(Icons.play_arrow);

  incrementHours() async {
    if (!chrono) {
      chrono = true;
      setState(() {
        iconStart = const Icon(Icons.pause);
      });
      while (chrono) {
        millisecondes++;
        if(millisecondes >= 100){
          secondes++;
          millisecondes = 0;
        }
        await Future.delayed(const Duration(milliseconds: 10));
        //secondes++;
        if (secondes >= 60) {
          minutes++;
          secondes = 0;
        }
        if(minutes >= 60){
          heure++;
          minutes = 0;
        }
        setState(() {});
      }
    }else{
      chrono = false;
      setState(() {
        iconStart = const Icon(Icons.play_arrow);
      });

    }
  }

  String hourString() {
    String cmisec = "";
    if(millisecondes < 10){
      cmisec = "0$millisecondes";
    } else {
      cmisec = millisecondes.toString();
    }
    String csec = "";
    if (secondes < 10) {
      csec = "0$secondes";
    } else {
      csec = secondes.toString();
    }
    String cmin = "";
    if (minutes < 10) {
      cmin = "0$minutes";
    } else {
      cmin = minutes.toString();
    }
    String cheure = "";
    if(heure < 10){
      cheure = "0$heure";
    } else {
      cheure = heure.toString();
    }
    return "$cheure:$cmin:$csec:$cmisec";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(hourString(), style: const TextStyle(fontSize: 50.0),),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: iconStart,
                  onPressed: () {
                    incrementHours();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.stop),
                  onPressed: () {
                    setState(() {
                      heure = 0;
                      secondes = 0;
                      minutes = 0;
                      millisecondes = 0;
                      chrono = false;
                    });
                  }
                ),
              ]
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Chrono(title: "Chrono decrement"))), 
        label: Text("Chrono decrement")
      ),
    );
  }
}