import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:horloge/ecrans/myhomepage.dart';

class Chrono extends StatefulWidget {
  const Chrono({super.key, required this.title});

  final String title;
  @override
  State<Chrono> createState() => _ChronoState();
}

class _ChronoState extends State<Chrono> {
  int heure = 1;
  int minutes = 0;
  int secondes = 0;
  int millisecondes = 99;

  bool chrono = false;
  Icon iconStart = const Icon(Icons.play_arrow);
  bool add = false;

  final _formKey = GlobalKey<FormState>();

  List<int> ajoutChrono = [];

  String _valeurSaisie = "";

  Future<void> _selectMyChrono() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Ajout d'un chrono"),
        content: SingleChildScrollView(
          child:  Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator: (valeur) {
                            if (valeur == null || valeur.isEmpty) {
                              return 'Please enter some text';
                            } else {
                              _valeurSaisie = valeur.toString();
                            }
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8)),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator: (valeur) {
                            if (valeur == null || valeur.isEmpty) {
                              return 'Please enter some text';
                            } else {
                              _valeurSaisie = valeur.toString();
                            }
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8)),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          validator: (valeur) {
                            if (valeur == null || valeur.isEmpty) {
                              return 'Please enter some text';
                            } else {
                              _valeurSaisie = valeur.toString();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

           /* ListBody(
            children: <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ), */
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  decrementHours() async {
    if (!chrono) {
      chrono = true;
      setState(() {
        iconStart = const Icon(Icons.pause);
      });
      while (chrono) {
        millisecondes--;
        await Future.delayed(const Duration(milliseconds: 5));
        if(millisecondes <= 1){
          secondes--;
          millisecondes = 99;
          if(secondes < 1){
            secondes = 59;
            minutes--;
          }
          if(minutes < 1){
            if(heure > 1){
              minutes = 59;
              heure--;
            } else {
              minutes = 0;
              heure = 0;
            }
          }
          if(heure == 0 && minutes == 0){
            if(secondes <= 1){
              secondes = 0;
            }
            if(secondes == 0 && millisecondes == 0){
              millisecondes = 0;
            }
          }
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
          IconButton(
            onPressed: (){
              add = true;
              _selectMyChrono();
            }, 
            icon: const Icon(Icons.add)
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: iconStart,
                onPressed: () {
                  decrementHours();
                },
              ),
              IconButton(
                icon: const Icon(Icons.stop),
                onPressed: () {
                  setState(() {
                    heure = 2;
                    secondes = 2;
                    minutes = 2;
                    millisecondes = 99;
                    chrono = false;
                  });
                }
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "Chrono increment"))) , 
        label: const Text("Chrono increment")
      ),
    );
  }
}