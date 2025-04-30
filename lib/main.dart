import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_markdown/flutter_markdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guia de Sustentabilidade',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Guia de Sustentabilidade'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text = "";
  List<Map<String, String>> _messages = [];
  String _initialPrompt =
      "Você é um assistente especializado em sustentabilidade que sugere práticas sustentáveis realistas e seguras para o dia a dia, adaptadas ao estilo de vida do usuário. Antes de responder, verifique se a entrada do usuário está relacionada a temas de sustentabilidade, como práticas ambientais, consumo consciente, mobilidade sustentável, energia, resíduos, hábitos ecológicos ou qualquer outro assunto vinculado à sustentabilidade. Caso esteja relacionada, prossiga normalmente com a sugestão de práticas sustentáveis personalizadas. Caso não esteja relacionada, responda corretamente à pergunta com base no seu conhecimento geral, mas informe de forma educada no início da resposta que sua especialidade é sustentabilidade e que você pode não oferecer o melhor desempenho fora desse tema.Quando a entrada for relevante para sustentabilidade, leve em consideração o contexto cultural, econômico e social do usuário com base nas informações fornecidas. Priorize recomendações éticas, seguras, acessíveis e viáveis dentro de uma rotina comum. Evite sugestões radicais, ilegais ou que possam comprometer a saúde, o bem-estar ou os direitos do usuário e de outras pessoas. Fundamente suas sugestões em boas práticas reconhecidas e, sempre que possível, aponte brevemente o benefício ambiental de cada uma.A resposta deve começar com um resumo do estilo de vida do usuário em até duas frases, seguido de três a cinco sugestões personalizadas, cada uma acompanhada de uma explicação concisa sobre o motivo da recomendação.Texto de entrada do usuário:";
  bool _isLoading = false;
  String? _lastPrompt;

  Future<void> _fetchSuggestions({String? prompt}) async {
    final currentPrompt = prompt ?? _text;
    setState(() {
      _isLoading = true;
      _lastPrompt = currentPrompt;
      _messages.add({"sender": "Você", "text": currentPrompt});
    });

    final response = await http.post(
      Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyCfp6t-IUAB1EocOafy5MyUEtndXZXUw0c',
      ),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": _initialPrompt + currentPrompt},
            ],
          },
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final text =
          data['candidates']?[0]?['content']?['parts']?[0]?['text'] ??
          "Resposta não encontrada";
      setState(() {
        _messages.add({"sender": "Resposta", "text": text});
      });
    } else {
      final error = jsonDecode(response.body)['error'];
      final errorMessage = error?['message'] ?? "Erro desconhecido";
      setState(() {
        _messages.add({"sender": "Erro", "text": "Erro: $errorMessage"});
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                final isUser = message["sender"] == "Você";
                final isError = message["sender"] == "Erro";
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment:
                        isUser
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          isUser ? "Você" : "Rodolfo",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:
                                    isUser
                                        ? Colors.blue[100]
                                        : Colors.green[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: MarkdownBody(
                                data: message["text"] ?? "",
                                styleSheet: MarkdownStyleSheet(
                                  p: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          if (isError && _lastPrompt != null)
                            IconButton(
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.red,
                              ),
                              onPressed:
                                  () => _fetchSuggestions(prompt: _lastPrompt),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _text = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Digite sua mensagem',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _fetchSuggestions,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
