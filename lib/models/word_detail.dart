class WordDetail {
  final String text;
  final String pronPrimary;
  final List<Explanation> expls;
  final List<Pronunciation> prons;
  final List<Glyph> glyphs;
  final Phonetics? phonetics;
  final String? commentExpl;
  final String? commentPron;
  final String? commentGlyph;
  final String? synonym;
  final String? antonym;

  WordDetail({
    required this.text,
    required this.pronPrimary,
    required this.expls,
    required this.prons,
    required this.glyphs,
    this.phonetics,
    this.commentExpl,
    this.commentPron,
    this.commentGlyph,
    this.synonym,
    this.antonym,
  });

  factory WordDetail.fromJson(Map<String, dynamic> json) {
    return WordDetail(
      text: json['text'] ?? '',
      pronPrimary: json['pronPrimary'] ?? '',
      expls: json['expls'] != null
          ? (json['expls'] as List)
              .map((item) => Explanation.fromJson(item))
              .toList()
          : [],
      prons: json['prons'] != null
          ? (json['prons'] as List)
              .map((item) => Pronunciation.fromJson(item))
              .toList()
          : [],
      glyphs: json['glyphs'] != null
          ? (json['glyphs'] as List)
              .map((item) => Glyph.fromJson(item))
              .toList()
          : [],
      phonetics: json['phonetics'] != null
          ? Phonetics.fromJson(json['phonetics'])
          : null,
      commentExpl: json['commentExpl'],
      commentPron: json['commentPron'],
      commentGlyph: json['commentGlyph'],
      synonym: json['synonym'],
      antonym: json['antonym'],
    );
  }
}

class Explanation {
  final String? pos;
  final String? expl;

  Explanation({this.pos, this.expl});

  factory Explanation.fromJson(Map<String, dynamic> json) {
    return Explanation(
      pos: json['pos'],
      expl: json['expl'],
    );
  }
}

class Pronunciation {
  final String pron;
  final String location;
  final bool isSandhi;

  Pronunciation({
    required this.pron,
    required this.location,
    this.isSandhi = false,
  });

  factory Pronunciation.fromJson(Map<String, dynamic> json) {
    return Pronunciation(
      pron: json['pron'] ?? '',
      location: json['location'] ?? '',
      isSandhi: json['isSandhi'] ?? false,
    );
  }
}

class Glyph {
  final String glyph;
  final String? category;

  Glyph({required this.glyph, this.category});

  factory Glyph.fromJson(Map<String, dynamic> json) {
    return Glyph(
      glyph: json['glyph'] ?? '',
      category: json['category'],
    );
  }
}

class Phonetics {
  final String yngping;

  Phonetics({required this.yngping});

  factory Phonetics.fromJson(Map<String, dynamic> json) {
    return Phonetics(
      yngping: json['yngping'] ?? '',
    );
  }
}

/// 冯爱珍词典条目
class WordFeng {
  final String text;
  final String pronLiteral;
  final String pronSandhi;
  final List<FengExplNode> expls;
  final String? comment;
  final String? correction;
  final int? refPage;

  WordFeng({
    required this.text,
    required this.pronLiteral,
    required this.pronSandhi,
    required this.expls,
    this.comment,
    this.correction,
    this.refPage,
  });

  factory WordFeng.fromJson(Map<String, dynamic> json) {
    return WordFeng(
      text: json['text'] ?? '',
      pronLiteral: json['pronLiteral'] ?? '',
      pronSandhi: json['pronSandhi'] ?? '',
      expls: json['expls'] != null
          ? (json['expls'] as List)
              .map((item) => FengExplNode.fromJson(item))
              .toList()
          : [],
      comment: json['comment'],
      correction: json['correction'],
      refPage: json['refPage'],
    );
  }
}

/// 冯爱珍词典释义节点
class FengExplNode {
  final String? expl;
  final List<String>? sent;
  final String? lexical;
  final List<FengExplNode>? node;

  FengExplNode({
    this.expl,
    this.sent,
    this.lexical,
    this.node,
  });

  factory FengExplNode.fromJson(Map<String, dynamic> json) {
    return FengExplNode(
      expl: json['expl'],
      sent: json['sent'] != null ? List<String>.from(json['sent']) : null,
      lexical: json['lexical'],
      node: json['node'] != null
          ? (json['node'] as List)
              .map((item) => FengExplNode.fromJson(item))
              .toList()
          : null,
    );
  }
}

/// 戚林八音条目
class WordCikLing {
  final String text;
  final String tone;
  final String cikFinal;
  final String cikInitial;
  final String? cikAnnotation;
  final String? liAnnotateCik;
  final int? liAnnotateCikOrder;
  final String lingFinal;
  final String lingInitial;
  final String? lingAnnotation;
  final String? liAnnotateLing;
  final int? liAnnotateLingOrder;
  final String? comment;

  WordCikLing({
    required this.text,
    required this.tone,
    required this.cikFinal,
    required this.cikInitial,
    this.cikAnnotation,
    this.liAnnotateCik,
    this.liAnnotateCikOrder,
    required this.lingFinal,
    required this.lingInitial,
    this.lingAnnotation,
    this.liAnnotateLing,
    this.liAnnotateLingOrder,
    this.comment,
  });

  factory WordCikLing.fromJson(Map<String, dynamic> json) {
    return WordCikLing(
      text: json['text'] ?? '',
      tone: json['tone'] ?? '',
      cikFinal: json['cikFinal'] ?? '',
      cikInitial: json['cikInitial'] ?? '',
      cikAnnotation: json['cikAnnotation'],
      liAnnotateCik: json['liAnnotateCik'],
      liAnnotateCikOrder: json['liAnnotateCikOrder'],
      lingFinal: json['lingFinal'] ?? '',
      lingInitial: json['lingInitial'] ?? '',
      lingAnnotation: json['lingAnnotation'],
      liAnnotateLing: json['liAnnotateLing'],
      liAnnotateLingOrder: json['liAnnotateLingOrder'],
      comment: json['comment'],
    );
  }
}

class WordDetailResponse {
  final String w;
  final WordDetail seedict;
  final List<WordFeng> fengs;
  final List<WordCikLing> ciklings;

  WordDetailResponse({
    required this.w,
    required this.seedict,
    required this.fengs,
    required this.ciklings,
  });

  factory WordDetailResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final result = data['result'] ?? {};
    return WordDetailResponse(
      w: data['w'] ?? '',
      seedict: WordDetail.fromJson(result['seedict'] ?? {}),
      fengs: result['fengs'] != null
          ? (result['fengs'] as List)
              .map((item) => WordFeng.fromJson(item))
              .toList()
          : [],
      ciklings: result['ciklings'] != null
          ? (result['ciklings'] as List)
              .map((item) => WordCikLing.fromJson(item))
              .toList()
          : [],
    );
  }
}
