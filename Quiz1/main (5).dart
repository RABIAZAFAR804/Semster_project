import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(DiceApp());
}

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Extended Dice App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
      ),
      home: DiceScreen(),
    );
  }
}

class DiceScreen extends StatefulWidget {
  @override
  _DiceScreenState createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen>
    with SingleTickerProviderStateMixin {
  List<int> diceNumbers = [1];
  int numberOfDice = 1;
  final TextEditingController _guessController = TextEditingController();
  String message = "";
  List<String> rollHistory = [];

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
  }

  void rollDice() {
    _animationController.forward(from: 0.0);
    setState(() {
      diceNumbers = [];
      int sum = 0;
      for (int i = 0; i < numberOfDice; i++) {
        int roll = Random().nextInt(6) + 1;
        diceNumbers.add(roll);
        sum += roll;
      }

      String rollResultString = "You rolled: ${diceNumbers.join(', ')}. Total: $sum";
      rollHistory.insert(0, rollResultString);
      if (rollHistory.length > 10) {
        rollHistory.removeLast();
      }

      if (_guessController.text.isNotEmpty) {
        int? guess = int.tryParse(_guessController.text);
        if (guess != null && guess == sum) {
          message = "🎉 Correct Guess! It's $sum";
        } else {
          message = "❌ Wrong Guess! It's $sum";
        }
      } else {
        message = rollResultString;
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _guessController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.cyan],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "🎲 Dice Roller",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Text("Number of Dice: $numberOfDice",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    Slider(
                      value: numberOfDice.toDouble(),
                      min: 1,
                      max: 6,
                      divisions: 5,
                      label: numberOfDice.toString(),
                      onChanged: (double value) {
                        setState(() {
                          numberOfDice = value.toInt();
                        });
                      },
                      activeColor: Colors.amber,
                      inactiveColor: Colors.white.withOpacity(0.3),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _guessController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelText: "Guess the total sum",
                        labelStyle: TextStyle(color: Colors.white70),
                        prefixIcon: Icon(Icons.casino, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.amber, width: 2),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 40),
                    Wrap(
                      spacing: 16.0,
                      runSpacing: 16.0,
                      alignment: WrapAlignment.center,
                      children: diceNumbers.map((number) {
                        return RotationTransition(
                          turns: _animation,
                          child: Image.asset(
                            "assets/images/$number.png",
                            height: 100,
                            errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.error,
                                color: Colors.white,
                                size: 100),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton.icon(
                      onPressed: rollDice,
                      icon: Icon(Icons.play_arrow, size: 32),
                      label: Text(
                        "Roll Dice",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.teal,
                        backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 10,
                        shadowColor: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Text("Roll History",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListView.builder(
                        itemCount: rollHistory.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              rollHistory[index],
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            leading:
                                Icon(Icons.history, color: Colors.white70),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              diceNumbers = [1];
              numberOfDice = 1;
              message = "";
              _guessController.clear();
              rollHistory.clear();
            });
          },
          child: Icon(Icons.refresh),
          backgroundColor: Colors.amber,
        ),
      ),
    );
  }
}
