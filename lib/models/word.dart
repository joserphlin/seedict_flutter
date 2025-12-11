class Word {
  final String w;
  final String text;
  final String pron;
  final String expl;

  Word({
    required this.w,
    required this.text,
    required this.pron,
    required this.expl,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      w: json['w'] ?? '',
      text: json['text'] ?? '',
      pron: json['pron'] ?? '',
      expl: json['expl'] is List
          ? (json['expl'] as List).join('；')
          : json['expl']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'w': w,
      'text': text,
      'pron': pron,
      'expl': expl,
    };
  }
}
