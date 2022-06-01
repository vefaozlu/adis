part of 'sentence_cubit.dart';

@immutable
class SentenceState extends Equatable {
  const SentenceState(this.sentence);
  final String sentence;

  @override
  List<Object> get props => [sentence];
}
