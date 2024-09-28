import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<List<int>> teamAHistory;
  final List<List<int>> teamBHistory;

  const HistoryPage({
    super.key,
    required this.teamAHistory,
    required this.teamBHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score History'),
        backgroundColor: Colors.tealAccent.shade400,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Team A Scores:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.tealAccent,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: teamAHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title:
                      Text('Round ${index + 1}: ${teamAHistory[index].first}'),
                  tileColor: Colors.tealAccent.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  trailing: const Icon(Icons.check_circle, color: Colors.green),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Team B Scores:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.tealAccent,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: teamBHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title:
                      Text('Round ${index + 1}: ${teamBHistory[index].first}'),
                  tileColor: Colors.tealAccent.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  trailing: const Icon(Icons.check_circle, color: Colors.green),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
