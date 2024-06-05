import 'package:flutter/material.dart';

class BmiCategories extends StatefulWidget {
  @override
  _BmiCategories createState() => _BmiCategories();
}

class _BmiCategories extends State<BmiCategories> {
  final List<Map<String, String>> bmiCategores = [
    {
      'title': 'Untergewicht',
      'desc': 'BMI weniger als 18.5',
      'long': 'Ein BMI von weniger als 18,5 gilt als untergewichtig. Dies kann auf Mangelernährung, gesundheitliche Probleme oder einen sehr aktiven Stoffwechsel hinweisen. Untergewicht kann das Immunsystem schwächen und zu weiteren gesundheitlichen Komplikationen führen.',
    },
    {
      'title': 'Normalgewicht',
      'desc': 'BMI 18.5 - 24.9',
      'long': 'Ein BMI zwischen 18,5 und 24,9 gilt als normalgewichtig. Personen in dieser Kategorie haben in der Regel ein geringeres Risiko für Herz-Kreislauf-Erkrankungen und andere gesundheitliche Probleme im Vergleich zu denjenigen, die unter- oder übergewichtig sind. Es ist wichtig, eine ausgewogene Ernährung und regelmäßige Bewegung beizubehalten, um in diesem Bereich zu bleiben.',
    },
    {
      'title': 'Übergewicht',
      'desc': 'BMI 25 - 29.9',
      'long': 'Ein BMI zwischen 25 und 29,9 gilt als übergewichtig. Übergewicht kann das Risiko für verschiedene gesundheitliche Probleme wie Bluthochdruck, Diabetes Typ 2 und Herzkrankheiten erhöhen. Eine Kombination aus gesunder Ernährung und regelmäßiger körperlicher Aktivität kann helfen, das Gewicht zu reduzieren und die Gesundheit zu verbessern.',
    },
    {
      'title': 'Adipositas (Obese)',
      'desc': 'BMI 30 oder grösser',
      'long': 'Ein BMI von 30 oder mehr gilt als adipös. Adipositas ist mit einem hohen Risiko für ernsthafte gesundheitliche Probleme verbunden, einschließlich Herzkrankheiten, Schlaganfall, Diabetes Typ 2 und bestimmten Krebsarten. Es ist wichtig, professionelle Hilfe zu suchen, um eine geeignete Gewichtsmanagement-Strategie zu entwickeln, die Diät, Bewegung und möglicherweise medizinische Eingriffe umfasst.',
    },
  ];

  void _showInfoDialog(String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Info'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'BMI Kategorien (für mehr Infos, antippen.)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0, // Adjust this value to make the text larger or smaller
              ),
            ),
          ),
          Expanded (
            child: ListView.builder(
              itemCount: bmiCategores.length,
              itemBuilder: (context, index) {
                final category = bmiCategores[index];
                return ListTile(
                  title: Text(category['title']!),
                  subtitle: Text(category['desc']!),
                  onTap: () {
                    _showInfoDialog(category['title']!, category['long']!);
                  },
                );
              }
            ),
          ),
        ]
      ),
    );
  }
}