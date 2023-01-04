// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'dart:math';

import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  const Jogo({super.key});

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _imagemApp = AssetImage("assets/images/padrao.png");
  var _mensagem = "Escolha uma opção abaixo:";

  int _placarUser = 0;
  int _placarApp = 0;

  void _reset() {
    setState(() {
      _placarApp = 0;
      _placarUser = 0;
      _mensagem = "Escolha uma opção abaixo:";
      _imagemApp = AssetImage("assets/images/padrao.png");
    });
  }

  void _opcaoSelecionada(String escolhaUsuario) {
    var opcoes = ["pedra", "papel", "tesoura"];
    var numero = Random().nextInt(opcoes.length);
    var escolhaApp = opcoes[numero];

    switch (escolhaApp) {
      case "pedra":
        setState(() {
          _imagemApp = AssetImage("assets/images/pedra.png");
        });
        break;

      case "papel":
        setState(() {
          _imagemApp = AssetImage("assets/images/papel.png");
        });
        break;

      case "tesoura":
        setState(() {
          _imagemApp = AssetImage("assets/images/tesoura.png");
        });
        break;
    }

    if ((escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
        (escolhaUsuario == "tesoura" && escolhaApp == "papel") ||
        (escolhaUsuario == "papel" && escolhaApp == "pedra")) {
      _mensagem = "Você Ganhou!";
      _placarUser++;
    }

    if ((escolhaApp == "pedra" && escolhaUsuario == "tesoura") ||
        (escolhaApp == "tesoura" && escolhaUsuario == "papel") ||
        (escolhaApp == "papel" && escolhaUsuario == "pedra")) {
      _mensagem = "Você Perdeu!";
      _placarApp++;
    }

    if ((escolhaApp == "pedra" && escolhaUsuario == "pedra") ||
        (escolhaApp == "tesoura" && escolhaUsuario == "tesoura") ||
        (escolhaApp == "papel" && escolhaUsuario == "papel")) {
      _mensagem = "Empate!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JokenPo"),

      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 32, bottom: 15),
              child: Text.rich(
                TextSpan(
                  text: 'Usuário: $_placarUser',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: (_placarApp == 0 && _placarUser == 0) 
                          ? Color.fromARGB(255, 5, 5, 5)
                          : (_placarUser > _placarApp)
                          ? Color.fromARGB(255, 2, 136, 254)
                          : (_placarUser < _placarApp )
                          ? Color.fromARGB(255, 5, 5, 5)
                          : Color.fromARGB(255, 255, 111, 1)
                          ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '  App: $_placarApp',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (_placarApp == 0 && _placarUser == 0) 
                              ? Color.fromARGB(255, 5, 5, 5)
                              : (_placarApp > _placarUser)
                              ? Color.fromARGB(255, 255, 4, 4)
                              : (_placarApp < _placarUser)
                              ? Color.fromARGB(255, 5, 5, 5)
                              : Color.fromARGB(255, 255, 111, 1)
                              ),
                    )
                  ],
                ),
              ),
            ),
            Image(image: _imagemApp),
            Padding(
              padding: EdgeInsets.only(top: 32, bottom: 50),
              child: Text(
                _mensagem,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: (_mensagem == "Escolha uma opção abaixo:")
                        ? Color.fromARGB(255, 4, 4, 4)
                        : (_mensagem == "Você Ganhou!")
                            ? Color.fromARGB(255, 2, 136, 254)
                            : (_mensagem == "Empate!")
                                ? Color.fromARGB(255, 255, 134, 4)
                                : Color.fromARGB(255, 255, 4, 4)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _opcaoSelecionada("papel"),
                  child: Image.asset(
                    "assets/images/papel.png",
                    height: 100,
                  ),
                ),
                GestureDetector(
                  onTap: () => _opcaoSelecionada("pedra"),
                  child: Image.asset(
                    "assets/images/pedra.png",
                    height: 100,
                  ),
                ),
                GestureDetector(
                  onTap: () => _opcaoSelecionada("tesoura"),
                  child: Image.asset(
                    "assets/images/tesoura.png",
                    height: 100,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 100),
              child: ElevatedButton(
                  onPressed: () => _reset(),
                  style: ElevatedButton.styleFrom(
                    
                    minimumSize: const Size(200, 50),
                    maximumSize: const Size(200, 50)
                  ),
                  child: Text("Resetar Placar"),

                ),
            )
          ]),
    );
  }
}
