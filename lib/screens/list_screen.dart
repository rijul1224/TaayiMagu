import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class Patient {
  final String name;
  final DateTime LastAppoitment;
  final double hb;
  final int pulse;
  final int spo2;
  final int gluc;
  final int fhr;

  Patient(this.name, this.LastAppoitment,this.hb,this.pulse,this.spo2,this.gluc,this.fhr);
}

class _ListScreenState extends State<ListScreen> {
  final List<Patient> patients = [
    Patient('Expectant Mother 1', DateTime.parse('2023-08-15 15:30:00'),10.0,75,98,90,140),
    Patient('Expectant Mother 2', DateTime.parse('2023-08-20 10:15:00'),13.6,85,98,90,140),
    Patient('Expectant Mother 3', DateTime.parse('2023-08-25 14:00:00'),12.9,95,93,90,140),
    Patient('Expectant Mother 4', DateTime.parse('2023-09-01 11:30:00'),13.2,90,98,160,140),
    Patient('Expectant Mother 5', DateTime.parse('2023-09-05 10:15:00'),14.5,105,98,90,110),
    Patient('Expectant Mother 6', DateTime.parse('2023-09-07 16:30:00'),15.1,65,98,90,100),
    Patient('Expectant Mother 7', DateTime.parse('2023-09-10 12:15:00'),15.5,96,97,90,150),
    Patient('Expectant Mother 8', DateTime.parse('2023-09-13 15:10:00'),16.2,97,99,80,140),
    Patient('Expectant Mother 9', DateTime.parse('2023-09-14 13:01:00'),13.6,98,98,99,144),
    Patient('Expectant Mother 10', DateTime.parse('2023-09-30 11:35:00'),12.9,99,99,70,157),
    Patient('Expectant Mother 11', DateTime.parse('2023-10-02 15:05:00'),0.0,90,95,78,141),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Expected Mothers",
          style: theme.textTheme.headlineMedium,
          textAlign: TextAlign.left,
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              Icons.person,
             color: _getPatientColor(patients[index]),
            ),
            title: Text(
              patients[index].name,
              style: TextStyle(
                color: _getPatientColor(patients[index]),
              ),
            ),
            subtitle: Text(
              'Last Appointment Date: ${DateFormat('dd-MMM-yyyy').format(patients[index].LastAppoitment)}',
            ),
            onTap: () {
              _showAlert(context, patients[index]);
            },
          );
        },
      ),
    );
  }

  Color _getPatientColor(Patient patient) {
    return const Color.fromARGB(255, 235, 114, 154);
  }

  void _showAlert(BuildContext context, Patient patient) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          )
        ],
        title: const Text('Details:'),
        contentPadding: const EdgeInsets.all(20),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Patient: ${patient.name}'),
            const SizedBox(height: 10),
            if (patient.hb == 0.0)
            const Text('Warning! Haemoglobin not entered',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
            else
            Text('Haemoglobin (Hb): ${patient.hb}'),
            Text('Pulse: ${patient.pulse}'),
            Text('SpO2: ${patient.spo2}'),
            Text('Glucose: ${patient.gluc}'),
            Text('Fetal Heart Rate (FHR): ${patient.fhr}'),
            const SizedBox(height: 10),
            Text('Last Appointment: ${DateFormat('dd-MMM-yyyy').format(patient.LastAppoitment)}'),
          ],
        ),
      ),
    );
  }
}