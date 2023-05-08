import 'package:flutter/material.dart';

class MessageContainer extends StatelessWidget {
  final String? message;
  final bool isUserMessage;

  const MessageContainer({
    Key? key,

    /// Indicamos que siempre se debe mandar un mensaje
    @required this.message,
    this.isUserMessage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      /// Cambia el lugar del mensaje
      mainAxisAlignment:
      isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          /// Limita nuestro contenedor a un ancho máximo de 250
          constraints: BoxConstraints(maxWidth: 250),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: isUserMessage == false
                      ? Radius.circular(15)
                      : Radius.circular(0),
                  topLeft: isUserMessage == true
                      ? Radius.circular(15)
                      : Radius.circular(0),
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),

              /// Cambia el color del contenedor del mensaje
              color: (isUserMessage == false
                  ? Colors.grey.shade200
                  : Colors.indigo[400]),
            ),

            /// Espaciado
            padding: const EdgeInsets.all(10),
            child: Text(
              /// Obtenemos el texto del mensaje y lo pintamos.
              /// Si es nulo, enviamos un string vacío.
              message!,
              style: TextStyle(
                  color: isUserMessage == true ? Colors.white : Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}