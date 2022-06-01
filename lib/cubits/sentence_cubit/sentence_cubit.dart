import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'sentence_state.dart';

class SentenceCubit extends Cubit<SentenceState> {
  SentenceCubit() : super(const SentenceState(''));

  void addAWord(String word) {
    var sentence = state.sentence;
    sentence += ' $word';
    emit(SentenceState(sentence));
  }

  void clearSentence() {
    emit(const SentenceState(''));
  }
}
