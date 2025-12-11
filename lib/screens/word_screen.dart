import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/word_detail.dart';
import '../models/audio_info.dart';
import '../services/api_service.dart';
import '../utils/theme.dart';
import 'package:audioplayers/audioplayers.dart';

class WordScreen extends StatefulWidget {
  final String w;

  const WordScreen({super.key, required this.w});

  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  final ApiService _apiService = ApiService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  WordDetailResponse? _wordDetail;
  AudioResponse? _audioResponse;
  bool _isLoading = true;
  bool _isLoadingAudio = false;
  bool _isPlaying = false;
  String? _error;
  String? _currentAudioUrl;

  @override
  void initState() {
    super.initState();
    _fetchWordDetail();

    // 监听音频播放状态
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _fetchWordDetail() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final detail = await _apiService.fetchWordDetail(widget.w);
      setState(() {
        _wordDetail = detail;
        _isLoading = false;
      });

      // 自动获取音频信息
      if (detail.seedict.pronPrimary.isNotEmpty) {
        _fetchAudioInfo(detail.seedict.pronPrimary);
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchAudioInfo(String yngping) async {
    setState(() {
      _isLoadingAudio = true;
    });

    try {
      final audioInfo = await _apiService.fetchAudioInfo(yngping);
      setState(() {
        _audioResponse = audioInfo;
        _isLoadingAudio = false;

        // 设置默认音频 URL（优先使用第一个）
        if (audioInfo.results.isNotEmpty) {
          final firstAudio = audioInfo.results.first;
          _currentAudioUrl = _apiService.getAudioUrl(
            firstAudio.speaker,
            firstAudio.md5,
          );
        }
      });
    } catch (e) {
      setState(() {
        _isLoadingAudio = false;
      });
      // 音频加载失败不影响主要功能，只记录日志
      debugPrint('Failed to load audio: $e');
    }
  }

  Future<void> _playAudio() async {
    if (_currentAudioUrl == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('暂无音频')),
        );
      }
      return;
    }

    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play(UrlSource(_currentAudioUrl!));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('播放失败: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_wordDetail?.seedict.text ?? '词汇详情'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppTheme.rosyBrown600,
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppTheme.rosyBrown400,
            ),
            const SizedBox(height: 16),
            Text(
              '加载失败',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              _error!,
              style: const TextStyle(color: AppTheme.rosyBrown400),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchWordDetail,
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (_wordDetail == null) {
      return const Center(
        child: Text('未找到词汇'),
      );
    }

    final detail = _wordDetail!.seedict;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Word header
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              detail.text,
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.rosyBrown800,
                              ),
                            ),
                            if (detail.pronPrimary.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                detail.pronPrimary,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: AppTheme.rosyBrown600,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      // Audio button (only show when loading or audio available)
                      if (_isLoadingAudio || _currentAudioUrl != null)
                        _isLoadingAudio
                            ? const SizedBox(
                                width: 32,
                                height: 32,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppTheme.rosyBrown600,
                                ),
                              )
                            : IconButton(
                                icon: Icon(
                                  _isPlaying
                                      ? Icons.pause_circle
                                      : Icons.volume_up,
                                ),
                                color: AppTheme.rosyBrown600,
                                iconSize: 32,
                                onPressed: _playAudio,
                                tooltip: _isPlaying ? '暂停' : '播放',
                              ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Explanations (only show if there's actual content)
          if (_hasExplanationContent(detail)) ...[
            _buildSectionTitle('本站释义'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var expl in detail.expls)
                      if (expl.expl != null && expl.expl!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (expl.pos != null && expl.pos!.isNotEmpty)
                                Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.rosyBrown700,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    expl.pos!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              Expanded(
                                child: Text(
                                  expl.expl!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppTheme.rosyBrown800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    if (detail.commentExpl != null) ...[
                      const Divider(),
                      Text(
                        '注释：${detail.commentExpl}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.rosyBrown600,
                        ),
                      ),
                    ],
                    if (detail.synonym != null || detail.antonym != null) ...[
                      const Divider(),
                      if (detail.synonym != null)
                        Text(
                          '近义词：${detail.synonym}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.rosyBrown600,
                          ),
                        ),
                      if (detail.antonym != null)
                        Text(
                          '反义词：${detail.antonym}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.rosyBrown600,
                          ),
                        ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Dictionary References (辞书释义)
          if (_wordDetail!.fengs.isNotEmpty ||
              _wordDetail!.ciklings.isNotEmpty) ...[
            _buildSectionTitle('辞书释义'),

            // Feng Dictionary (冯爱珍词典)
            for (var feng in _wordDetail!.fengs) _buildFengCard(feng),

            // CikLing Dictionary (戚林八音)
            if (_wordDetail!.ciklings.isNotEmpty)
              _buildCikLingCard(_wordDetail!.ciklings),

            const SizedBox(height: 16),
          ],

          // Pronunciations
          if (detail.prons.isNotEmpty) ...[
            _buildSectionTitle('各地方音'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Table(
                  border: TableBorder.all(color: AppTheme.wheat200),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(
                      decoration:
                          const BoxDecoration(color: AppTheme.rosyBrown300),
                      children: [
                        _buildTableHeader('读音'),
                        _buildTableHeader('连读'),
                        _buildTableHeader('地区'),
                      ],
                    ),
                    for (var pron in detail.prons)
                      TableRow(
                        children: [
                          _buildTableCell(pron.pron),
                          _buildTableCell(pron.isSandhi ? '连读音' : '本字音'),
                          _buildTableCell(
                              pron.location.isEmpty ? '市区' : pron.location),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Glyphs
          if (detail.glyphs.isNotEmpty) ...[
            _buildSectionTitle('用字一览'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Table(
                  border: TableBorder.all(color: AppTheme.wheat200),
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(
                      decoration:
                          const BoxDecoration(color: AppTheme.rosyBrown300),
                      children: [
                        _buildTableHeader('用字'),
                        _buildTableHeader('类别'),
                      ],
                    ),
                    for (var glyph in detail.glyphs)
                      TableRow(
                        children: [
                          _buildTableCell(glyph.glyph),
                          _buildTableCell(glyph.category ?? 'N/A'),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppTheme.rosyBrown800,
        ),
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          color: AppTheme.rosyBrown800,
        ),
      ),
    );
  }

  /// 检查是否有本站释义内容
  bool _hasExplanationContent(WordDetail detail) {
    // 检查是否有非空的释义
    final hasExpls =
        detail.expls.any((expl) => expl.expl != null && expl.expl!.isNotEmpty);

    // 检查是否有注释、近义词或反义词
    final hasOtherContent = detail.commentExpl != null ||
        detail.synonym != null ||
        detail.antonym != null;

    return hasExpls || hasOtherContent;
  }

  /// 构建冯爱珍词典卡片
  Widget _buildFengCard(WordFeng feng) {
    return Card(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 词条和读音
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Flexible(
                  child: Text(
                    feng.text,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.rosyBrown800,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    '/${feng.pronLiteral}/ → /${feng.pronSandhi}/',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppTheme.rosyBrown500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 释义
            _buildFengExplanations(feng.expls),

            // 注释
            if (feng.comment != null && feng.comment!.isNotEmpty) ...[
              const Divider(),
              Text(
                '注释：${feng.comment}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.rosyBrown600,
                ),
              ),
            ],

            // 参考文献
            const SizedBox(height: 12),
            Text(
              feng.refPage != null
                  ? '冯爱珍. 福州方言词典. 南京: 江苏教育出版社, 1998: ${feng.refPage}.'
                  : '冯爱珍. 福州方言词典. 南京: 江苏教育出版社, 1998.',
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.rosyBrown200,
              ),
              textAlign: TextAlign.right,
            ),

            // 校注
            if (feng.correction != null && feng.correction!.isNotEmpty) ...[
              const Divider(),
              Text(
                '校注：${feng.correction}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.rosyBrown600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// 构建冯爱珍词典释义
  Widget _buildFengExplanations(List<FengExplNode> expls, {int level = 0}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var expl in expls) ...[
          if (expl.expl != null && expl.expl!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: level * 16.0, bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (expl.lexical != null && expl.lexical!.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.rosyBrown700,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        expl.lexical!,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  Expanded(
                    child: Text(
                      expl.expl!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.rosyBrown800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (expl.sent != null && expl.sent!.isNotEmpty)
            for (var sentence in expl.sent!)
              Padding(
                padding: EdgeInsets.only(left: (level + 1) * 16.0, bottom: 2),
                child: Text(
                  '• $sentence',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.rosyBrown600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          if (expl.node != null && expl.node!.isNotEmpty)
            _buildFengExplanations(expl.node!, level: level + 1),
        ],
      ],
    );
  }

  /// 构建戚林八音卡片
  Widget _buildCikLingCard(List<WordCikLing> ciklings) {
    return Card(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 条目列表
            for (var cikling in ciklings) ...[
              _buildCikLingEntry(cikling),
              const SizedBox(height: 8),
            ],

            // 参考文献
            const SizedBox(height: 8),
            const Text(
              '李如龙, 王升魁. 戚林八音校注. 福州: 福建人民出版社, 2001.',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.rosyBrown200,
              ),
              textAlign: TextAlign.right,
            ),

            // 校注（如果有）
            if (ciklings
                .any((c) => c.comment != null && c.comment!.isNotEmpty)) ...[
              const Divider(),
              for (var cikling in ciklings)
                if (cikling.comment != null && cikling.comment!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '校注：${cikling.comment}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.rosyBrown600,
                      ),
                    ),
                  ),
            ],
          ],
        ),
      ),
    );
  }

  /// 构建单个戚林八音条目
  Widget _buildCikLingEntry(WordCikLing cikling) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.wheat50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 词条
          Text(
            cikling.text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.rosyBrown800,
            ),
          ),
          const SizedBox(height: 8),

          // 戚林信息
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '戚: ${cikling.cikInitial}${cikling.cikFinal}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.rosyBrown700,
                      ),
                    ),
                    if (cikling.cikAnnotation != null &&
                        cikling.cikAnnotation!.isNotEmpty)
                      Text(
                        cikling.cikAnnotation!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.rosyBrown500,
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '林: ${cikling.lingInitial}${cikling.lingFinal}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.rosyBrown700,
                      ),
                    ),
                    if (cikling.lingAnnotation != null &&
                        cikling.lingAnnotation!.isNotEmpty)
                      Text(
                        cikling.lingAnnotation!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.rosyBrown500,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
