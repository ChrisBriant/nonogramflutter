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
            ? Column(
              children: [
                const Text(
                  '3 Letter Words',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                WordListDisplay(wordList: wordResults.firstWhere((element) => element.numLetters == 3).scoredWords)
              ],
            )
            : const SizedBox.shrink(),
            !wordResults.firstWhere((element) => element.numLetters == 4).scoredWords.isEmpty
            ? Column(
              children: [
                const Text(
                  '4 Letter Words',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                
                ),
                WordListDisplay(wordList: wordResults.firstWhere((element) => element.numLetters ==4).scoredWords)
              ],
            )
            : const SizedBox.shrink(),
            !wordResults.firstWhere((element) => element.numLetters == 5).scoredWords.isEmpty
            ? Column(
              children: [
                const Text('5 Letter Words'),
                WordListDisplay(wordList: wordResults.firstWhere((element) => element.numLetters == 5).scoredWords)
              ],
            )
            : const SizedBox.shrink(),
                        !wordResults.firstWhere((element) => element.numLetters == 6).scoredWords.isEmpty
            ? Column(
              children: [
                const Text('6 Letter Words'),
                WordListDisplay(wordList: wordResults.firstWhere((element) => element.numLetters == 6).scoredWords)
              ],
            )
            : const SizedBox.shrink(),
            !wordResults.firstWhere((element) => element.numLetters == 7).scoredWords.isEmpty
            ? Column(
              children: [
                const Text('7 Letter Words'),
                WordListDisplay(wordList: wordResults.firstWhere((element) => element.numLetters == 7).scoredWords)
              ],
            )
            : const SizedBox.shrink(),
                        !wordResults.firstWhere((element) => element.numLetters == 8).scoredWords.isEmpty
            ? Column(
              children: [
                const Text('8 Letter Words'),
                WordListDisplay(wordList: wordResults.firstWhere((element) => element.numLetters == 8).scoredWords)
              ],
            )
            : const SizedBox.shrink(),
            !wordResults.firstWhere((element) => element.numLetters == 9).scoredWords.isEmpty
            ? Column(
              children: [
                const Text('9 Letter Words'),
                WordListDisplay(wordList: wordResults.firstWhere((element) => element.numLetters == 9).scoredWords)
              ],
            )
            : const SizedBox.shrink(),

          ],
        ),
      )
    );
  }
}