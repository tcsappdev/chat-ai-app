import 'package:flutter/material.dart';

import '../models/message_models.dart';
import 'message_container.dart';

class MessagesList extends StatelessWidget {
  /// El componente recibirá una lista de mensajes
  final List<Message> messages;

  const MessagesList({
    Key? key,

    /// Le indicamos al componente que la lista estará vacía en
    /// caso de que no se le pase como argumento alguna otra lista
    this.messages = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Regresaremos una [ListView] con el constructor [separated]
    /// para que después de cada elemento agregue un espacio
    return ListView.separated(
      /// Indicamos el número de items que tendrá
      itemCount: messages.length,

      /// Agregamos espaciado
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),

      /// Indicamos que agregue un espacio entre cada elemento
      separatorBuilder: (_, i) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        var obj = messages[messages.length - 1 - i];
        return MessageContainer(
          /// Cambiamos el orden por el cuál iterará en los mensajes
          /// de nuestra lista de atrás hacia adelante
          message: obj.text,
          isUserMessage: obj.isSendByMe,
        );
      },
      reverse: true,
    );
  }
}