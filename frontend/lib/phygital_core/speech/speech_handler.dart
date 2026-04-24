import 'dart:js_interop';
import 'package:web/web.dart' as web;

class SpeechHandler {
  final Function(String) onCommand;
  late web.SpeechRecognition _recognition;

  SpeechHandler({required this.onCommand});

  void start() {
    _recognition = web.SpeechRecognition();
    _recognition.lang = 'ru-RU';
    _recognition.interimResults = false;
    _recognition.maxAlternatives = 1;

    _recognition.onresult = ((web.Event event) {
      final speechEvent = event as web.SpeechRecognitionEvent;
      final results = speechEvent.results;
      if (results.length > 0) {
        final transcript = results.item(0).item(0).transcript;
        if (transcript.isNotEmpty) {
          onCommand(transcript);
        }
      }
    }).toJS;

    _recognition.start();
  }

  void stop() {
    _recognition.stop();
  }
}