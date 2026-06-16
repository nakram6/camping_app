import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
const WeatherScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.blue[50],


  appBar: AppBar(
    title: const Text("Weather"),
    centerTitle: true,
  ),

  body: Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
              colors: [
                Colors.blue,
                Colors.lightBlueAccent,
              ],
            ),
          ),
          child: const Column(
            children: [
              Icon(
                Icons.wb_sunny,
                size: 80,
                color: Colors.white,
              ),

              SizedBox(height: 15),

              Text(
                "24°C",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              Text(
                "Partly Cloudy",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "Windsor, ON",
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        Card(
          child: ListTile(
            leading: Icon(Icons.water_drop),
            title: Text("Humidity"),
            trailing: Text("55%"),
          ),
        ),

        Card(
          child: ListTile(
            leading: Icon(Icons.air),
            title: Text("Wind"),
            trailing: Text("12 km/h"),
          ),
        ),

        Card(
          child: ListTile(
            leading: Icon(Icons.visibility),
            title: Text("Visibility"),
            trailing: Text("10 km"),
          ),
        ),
      ],
    ),
  ),
);


}
}
