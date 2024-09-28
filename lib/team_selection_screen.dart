import 'package:flutter/material.dart';
import 'package:dominoes_score_calc/history_page.dart';

class ScoreboardPage extends StatefulWidget {
  const ScoreboardPage({super.key});

  @override
  _ScoreboardPageState createState() => _ScoreboardPageState();
}

class _ScoreboardPageState extends State<ScoreboardPage> {
  int teamAScore = 0;
  int teamBScore = 0;
  int teamARounds = 0;
  int teamBRounds = 0;

  List<List<int>> teamAHistory = [];
  List<List<int>> teamBHistory = [];

  final _scoreControllerA = TextEditingController();
  final _scoreControllerB = TextEditingController();
  final _teamNameControllerA = TextEditingController(text: "Team A");
  final _teamNameControllerB = TextEditingController(text: "Team B");

  void _addScore(int score, bool isTeamA) {
    setState(() {
      if (isTeamA) {
        teamAScore += score;
        teamAHistory.add([score]);
        if (teamAScore >= 101) {
          teamARounds++;
          teamAScore = 0;
          teamBScore = 0;
        }
      } else {
        teamBScore += score;
        teamBHistory.add([score]);
        if (teamBScore >= 101) {
          teamBRounds++;
          teamAScore = 0;
          teamBScore = 0;
        }
      }
    });
  }

  void _undoLast(bool isTeamA) {
    setState(() {
      if (isTeamA && teamAHistory.isNotEmpty) {
        int lastScore = teamAHistory.last.first;
        if (teamAScore - lastScore >= 0) {
          teamAScore -= lastScore;
          teamAHistory.removeLast();
        }
      } else if (!isTeamA && teamBHistory.isNotEmpty) {
        int lastScore = teamBHistory.last.first;
        if (teamBScore - lastScore >= 0) {
          teamBScore -= lastScore;
          teamBHistory.removeLast();
        }
      }
    });
  }

  void _resetScores() {
    setState(() {
      teamAScore = 0;
      teamBScore = 0;
      teamARounds = 0;
      teamBRounds = 0;
      teamAHistory.clear();
      teamBHistory.clear();
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  Widget _teamNameInput(TextEditingController controller, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.tealAccent),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(8.0),
          ),
          textAlign: TextAlign.center,
          onChanged: (value) {
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _teamScoreCard(String teamName, int score, int rounds, bool isTeamA) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.tealAccent.shade400, Colors.tealAccent.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(4, 4),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(-4, -4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              teamName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Score: $score',
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _roundsCounter(String teamName, int rounds) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Rounds: $rounds',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _addScoreSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _scoreInput(_scoreControllerA, true),
        _scoreInput(_scoreControllerB, false),
      ],
    );
  }

  Widget _scoreInput(TextEditingController controller, bool isTeamA) {
    return Column(
      children: [
        Container(
          width: 120,
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Enter score',
              labelStyle: TextStyle(color: Colors.tealAccent),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(12.0),
            ),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            if (controller.text.isEmpty) {
              _showError('Please enter a score.');
              return;
            }
            int? score = int.tryParse(controller.text);
            if (score == null || score <= 0) {
              _showError('Please enter a valid positive number.');
              return;
            }
            _addScore(score, isTeamA);
            controller.clear();
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Score'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.tealAccent.shade400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _undoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () => _undoLast(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.tealAccent.shade400,
          ),
          child: const Text('Undo Team A'),
        ),
        ElevatedButton(
          onPressed: () => _undoLast(false),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.tealAccent.shade400,
          ),
          child: const Text('Undo Team B'),
        ),
      ],
    );
  }

  Widget _buildResetButton(Size screenSize) {
    return ElevatedButton(
      onPressed: _resetScores,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(screenSize.width * 0.8, 50),
        backgroundColor: Colors.red,
      ),
      child: const Text(
        'Reset Scores',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Dominoes Score Calculator'),
        backgroundColor: Colors.tealAccent.shade400,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryPage(
                    teamAHistory: teamAHistory,
                    teamBHistory: teamBHistory,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: screenSize.height * 0.02,
          horizontal: screenSize.width * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _teamNameInput(_teamNameControllerA, "Rename Team A"),
                _teamNameInput(_teamNameControllerB, "Rename Team B"),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _teamScoreCard(
                    _teamNameControllerA.text, teamAScore, teamARounds, true),
                _teamScoreCard(
                    _teamNameControllerB.text, teamBScore, teamBRounds, false),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _roundsCounter(_teamNameControllerA.text, teamARounds),
                _roundsCounter(_teamNameControllerB.text, teamBRounds),
              ],
            ),
            const SizedBox(height: 10),
            _addScoreSection(),
            const SizedBox(height: 10),
            _undoSection(),
            const SizedBox(height: 20),
            _buildResetButton(screenSize),
          ],
        ),
      ),
    );
  }
}
