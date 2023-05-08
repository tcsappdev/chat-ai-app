import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/message_models.dart';
import '../widgets/message_list_widget.dart';
import '../widgets/typing_indicator_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _msgUserCtrl = TextEditingController();

  List<Message> messages = [];

  Map<String, String> body = {'message': ''};

  String myVar = '';

  bool isTyping = true;

  @override
  void initState() {
    // TODO: implement initState

    sonciChatService('quien eres?');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IA conversacional'),
        backgroundColor: Colors.indigo[400],
      ),
      body: Column(
        children: [
          /// Esta parte se asegura que la caja de texto se posicione hasta abajo de la pantalla
          Expanded(
            child: MessagesList(
              messages: messages,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: TypingIndicator(
              showIndicator: isTyping,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            color: Colors.indigo[400],
            child: Row(
              children: [
                /// El Widget [Expanded] se asegura que el campo de texto ocupe
                /// toda la pantalla menos el ancho del [IconButton]
                Expanded(
                  child: TextField(
                    controller: _msgUserCtrl,
                    decoration: InputDecoration(
                      hintText: "¿que infomación desea solicitar?",
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_msgUserCtrl.text != "") {
                      messages.add(Message(
                          text: _msgUserCtrl.text,
                          date: DateTime.now(),
                          isSendByMe: true));
                      body['message'] = _msgUserCtrl.text;
                      myVar = _msgUserCtrl.text;
                      _msgUserCtrl.clear();
                      isTyping = true;
                      setState(() {});
                      sonciChatService(myVar);
                    }
                    /// Limpiamos nuestro campo de texto
                    _msgUserCtrl.clear();
                  },
                ),
              ],
            ), // Fin de la fila
          ),
          // Fin del contenedor
        ],
      ),
    );
  }

  Future<Map<String, dynamic>?> sonciChatService(String requestMsg) async {
    final Map<String, dynamic> decodedResp;

    String rout = "http://172.16.90.55:4000/api/";

    var url = '${rout}chatSonic/';

    Map<String, String> header = {
      "apikey": "123456",
    };

    try {
      final http.Response resp = await http.post(Uri.parse(url),
          body: {'message': requestMsg}, headers: header);
      decodedResp = jsonDecode(resp.body);
      messages.add(Message(
          text: decodedResp['data']['message'],
          date: DateTime.now().subtract(Duration(minutes: 1)),
          isSendByMe: false));

      isTyping = false;
      setState(() {});

      print(decodedResp);
      return decodedResp;
    } catch (err) {}
  }
}






