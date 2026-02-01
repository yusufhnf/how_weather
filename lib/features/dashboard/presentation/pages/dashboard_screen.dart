import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HowWeather')),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.wb_sunny),
            title: Text('Sunny'),
            subtitle: Text('25°C, Clear Sky'),
          ),
          // Expanded with GridView Weather by Location
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 3 / 2,
              ),
              itemCount: 6, // Example count
              itemBuilder: (context, index) {
                return Card(
                  child: Center(
                    child: Text(
                      'Location ${index + 1}\n20°C, Cloudy',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
