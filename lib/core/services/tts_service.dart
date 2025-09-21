import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  static final TTSService _instance = TTSService._internal();
  factory TTSService() => _instance;
  TTSService._internal();

  late FlutterTts _flutterTts;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    _flutterTts = FlutterTts();
    
    await _configureTTS();
    _isInitialized = true;
  }

  Future<void> _configureTTS() async {
    try {
      await _flutterTts.setLanguage('en-US');
      await _flutterTts.setSpeechRate(0.6);
      await _flutterTts.setVolume(0.8);
      await _flutterTts.setPitch(1.0);
      
      await _flutterTts.awaitSpeakCompletion(true);
    } catch (e) {
      print('Error configuring TTS: $e');
    }
  }

  Future<void> speak(String text) async {
    if (!_isInitialized) {
      await initialize();
    }

    if (text.isEmpty) return;

    try {
      await _flutterTts.speak(text);
    } catch (e) {
      print('Error speaking text: $e');
    }
  }

  Future<void> stop() async {
    if (!_isInitialized) return;
    
    try {
      await _flutterTts.stop();
    } catch (e) {
      print('Error stopping TTS: $e');
    }
  }

  Future<void> pause() async {
    if (!_isInitialized) return;
    
    try {
      await _flutterTts.pause();
    } catch (e) {
      print('Error pausing TTS: $e');
    }
  }

  Future<void> setSpeechRate(double rate) async {
    if (!_isInitialized) await initialize();
    
    try {
      await _flutterTts.setSpeechRate(rate.clamp(0.1, 2.0));
    } catch (e) {
      print('Error setting speech rate: $e');
    }
  }

  Future<void> setVolume(double volume) async {
    if (!_isInitialized) await initialize();
    
    try {
      await _flutterTts.setVolume(volume.clamp(0.0, 1.0));
    } catch (e) {
      print('Error setting volume: $e');
    }
  }

  Future<void> setPitch(double pitch) async {
    if (!_isInitialized) await initialize();
    
    try {
      await _flutterTts.setPitch(pitch.clamp(0.5, 2.0));
    } catch (e) {
      print('Error setting pitch: $e');
    }
  }

  Future<void> setLanguage(String language) async {
    if (!_isInitialized) await initialize();
    
    try {
      await _flutterTts.setLanguage(language);
    } catch (e) {
      print('Error setting language: $e');
    }
  }

  Future<List<dynamic>> getLanguages() async {
    if (!_isInitialized) await initialize();
    
    try {
      return await _flutterTts.getLanguages;
    } catch (e) {
      print('Error getting languages: $e');
      return [];
    }
  }

  Future<List<dynamic>> getVoices() async {
    if (!_isInitialized) await initialize();
    
    try {
      return await _flutterTts.getVoices;
    } catch (e) {
      print('Error getting voices: $e');
      return [];
    }
  }

  Future<bool> get isPlaying async {
    if (!_isInitialized) return false;
    
    try {
      return await _flutterTts.isLanguageAvailable('en-US');
    } catch (e) {
      return false;
    }
  }

  void dispose() {
    if (_isInitialized) {
      _flutterTts.stop();
    }
  }
}