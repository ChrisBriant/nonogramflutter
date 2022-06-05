import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/wordlistdisplay.dart';
import '../providers/nonogram_provider.dart';

class ResultsScreen extends StatelessWidget {
  static String routeName = '/results'; 
  
  const ResultsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _nonogramProvider = Provider.of<NonogramProvider>(context,listen: false);
    final List<WordScore> wordResults = _nonogramProvider.result.wordScore;
    final List<WordScore> wordSolutions = _nonogramProvider.solution.wordScore;

    return Scaffold(
      appBar: AppBar(title: const Text('Score')),
      body: SingleChildScrollView(
        child:Column(
          children: [
            const Text(
              'Score',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              'Congratulations! you have scored ${_nonogramProvider.result.totalScore} out of ${_nonogramProvider.solution.totalScore}.',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10,),
            !wordResults.firstWhere((element) => element.numLetters == 3).scoredWords.isEmpty
            ? ResultDisplay(letterCount: 3, wordScore: wordResults.firstWhere((element) => element.numLetters == 3))
            : const SizedBox.shrink(),
            !wordResults.firstWhere((element) => element.numLetters == 4).scoredWords.isEmpty
            ? ResultDisplay(letterCount: 4, wordScore: wordResults.firstWhere((element) => element.numLetters == 4))
            : const SizedBox.shrink(),
            !wordResults.firstWhere((element) => element.numLetters == 5).scoredWords.isEmpty
            ? ResultDisplay(letterCount: 5, wordScore: wordResults.firstWhere((element) => element.numLetters == 5))
            : const SizedBox.shrink(),
            !wordResults.firstWhere((element) => element.numLetters == 6).scoredWords.isEmpty
            ? ResultDisplay(letterCount: 6, wordScore: wordResults.firstWhere((element) => element.numLetters == 6))
            : const SizedBox.shrink(),
            !wordResults.firstWhere((element) => element.numLetters == 7).scoredWords.isEmpty
            ? ResultDisplay(letterCount: 7, wordScore: wordResults.firstWhere((element) => element.numLetters == 7))
            : const SizedBox.shrink(),
            !wordResults.firstWhere((element) => element.numLetters == 8).scoredWords.isEmpty
            ? ResultDisplay(letterCount: 8, wordScore: wordResults.firstWhere((element) => element.numLetters == 8))
            : const SizedBox.shrink(),
            !wordResults.firstWhere((element) => element.numLetters == 9).scoredWords.isEmpty
            ? ResultDisplay(letterCount: 9, wordScore: wordResults.firstWhere((element) => element.numLetters == 9))
            : const SizedBox.shrink(),

          ],
        ),
      )
    );
  }
}


class ResultDisplay extends StatelessWidget {
  final int letterCount;
  final WordScore wordScore;

  const ResultDisplay({
    required this.letterCount,
    required this.wordScore, 
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            '${letterCount.toString()} Letter Words',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              const Text(
                'Score: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              Text('${wordScore.score}')
            ],
          ),
          WordListDisplay(wordList: wordScore.scoredWords)
        ],
      ),
    );
  }
}