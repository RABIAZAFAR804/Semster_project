
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

// --- Constants for Theme and Styling ---
const kBackgroundColor = Color(0xFF0A0B21);
const kCardColor = Color(0xFF1D1E33);
const kInactiveCardColor = Color(0xFF111328);
const kAccentColor = Color(0xFF00E5FF);
const kInactiveColor = Color(0xFF8D8E98);
const kWhiteColor = Colors.white;

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primaryColor: kAccentColor,
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: kWhiteColor),
        ),
        iconTheme: const IconThemeData(color: kWhiteColor),
      ),
      home: const BMICalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  int _height = 170;
  int _weight = 60;
  bool _isMale = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI CALCULATOR',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: kWhiteColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // --- Gender Selection ---
                  Row(
                    children: [
                      Expanded(
                        child: GenderCard(
                          icon: Icons.male,
                          label: 'MALE',
                          isSelected: _isMale,
                          onTap: () => setState(() => _isMale = true),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GenderCard(
                          icon: Icons.female,
                          label: 'FEMALE',
                          isSelected: !_isMale,
                          onTap: () => setState(() => _isMale = false),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // --- Height Selection ---
                  Expanded(
                    child: HeightCard(
                      height: _height,
                      onChanged: (newHeight) =>
                          setState(() => _height = newHeight.toInt()),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // --- Weight Selection ---
                  Expanded(
                    child: WeightCard(
                      weight: _weight,
                      onIncrement: () => setState(() => _weight++),
                      onDecrement: () => setState(() => _weight--),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // --- Calculate Button ---
          CalculateButton(
            onPressed: () {
              final double bmi = _weight / ((_height / 100) * (_height / 100));
              showModalBottomSheet(
                context: context,
                backgroundColor: kCardColor,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0)),
                ),
                builder: (context) => ResultSheet(bmi: bmi),
              );
            },
          ),
        ],
      ),
    );
  }
}

// --- Reusable Widgets ---

class GenderCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderCard({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? kCardColor : kInactiveCardColor,
          borderRadius: BorderRadius.circular(15),
          border: isSelected
              ? Border.all(color: kAccentColor, width: 2)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: isSelected ? kAccentColor : kInactiveColor),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isSelected ? kAccentColor : kInactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeightCard extends StatelessWidget {
  final int height;
  final ValueChanged<double> onChanged;

  const HeightCard({super.key, required this.height, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'HEIGHT',
            style: GoogleFonts.poppins(
                fontSize: 20,
                color: kInactiveColor,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                height.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: kWhiteColor,
                ),
              ),
              Text(
                'cm',
                style: GoogleFonts.poppins(fontSize: 18, color: kInactiveColor),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: kAccentColor,
              inactiveTrackColor: kInactiveColor,
              thumbColor: kAccentColor,
              overlayColor: kAccentColor.withAlpha(0x29),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15.0),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 30.0),
            ),
            child: Slider(
              value: height.toDouble(),
              min: 100,
              max: 220,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class WeightCard extends StatelessWidget {
  final int weight;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const WeightCard(
      {super.key,
      required this.weight,
      required this.onIncrement,
      required this.onDecrement});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'WEIGHT',
            style: GoogleFonts.poppins(
                fontSize: 20,
                color: kInactiveColor,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            weight.toString(),
            style: GoogleFonts.poppins(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: kWhiteColor,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundIconButton(icon: Icons.remove, onPressed: onDecrement),
              const SizedBox(width: 16),
              RoundIconButton(icon: Icons.add, onPressed: onIncrement),
            ],
          ),
        ],
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const RoundIconButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 6.0,
      constraints: const BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: const CircleBorder(),
      fillColor: const Color(0xFF4C4F5E),
      child: Icon(icon, size: 30),
    );
  }
}

class CalculateButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CalculateButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 70,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: kAccentColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Center(
          child: Text(
            'CALCULATE YOUR BMI',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}


class ResultSheet extends StatelessWidget {
  final double bmi;

  const ResultSheet({super.key, required this.bmi});

  String _getMessage(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  Color _getColor(double bmi) {
    if (bmi < 18.5) return Colors.blue.shade300;
    if (bmi < 25) return Colors.green.shade400;
    if (bmi < 30) return Colors.orange.shade400;
    return Colors.red.shade500;
  }

  @override
  Widget build(BuildContext context) {
    final message = _getMessage(bmi);
    final color = _getColor(bmi);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message.toUpperCase(),
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 10,
                  maximum: 40,
                  showLabels: false,
                  showTicks: false,
                  axisLineStyle: const AxisLineStyle(
                    thickness: 0.2,
                    cornerStyle: CornerStyle.bothCurve,
                    color: kInactiveCardColor,
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: bmi,
                      cornerStyle: CornerStyle.bothCurve,
                      width: 0.2,
                      sizeUnit: GaugeSizeUnit.factor,
                      color: color,
                    ),
                    MarkerPointer(
                      value: bmi,
                      markerType: MarkerType.circle,
                      color: kAccentColor,
                      markerHeight: 25,
                      markerWidth: 25,
                      borderWidth: 2,
                      borderColor: kWhiteColor,
                    )
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            bmi.toStringAsFixed(1),
                            style: GoogleFonts.poppins(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: kWhiteColor,
                            ),
                          ),
                          Text(
                            'BMI',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: kInactiveColor,
                            ),
                          ),
                        ],
                      ),
                      angle: 90,
                      positionFactor: 0.1,
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "CLOSE",
              style: GoogleFonts.poppins(
                color: kAccentColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}

