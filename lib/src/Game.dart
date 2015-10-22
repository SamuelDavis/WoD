library wodClient.Game;
import 'package:wodClient/src/Systems.dart';
import 'package:wodClient/src/Client.dart';
import 'dart:async';

class Game {
  static const Duration UPDATE_SLEEP = const Duration(milliseconds: 100);
  ClientInterface _clientInterface;

  Game() {
    _clientInterface = new ClientInterface(this);
  }

  registerClient(Client client) => _clientInterface.addClient(client);

  addCommand(ClientCommand command) => _clientInterface.handleCommand(command);

  update() {
    ClientData clientData = new ClientData(new DateTime.now());
    _clientInterface.update(clientData);
  }

  void start() {
    new Timer.periodic(UPDATE_SLEEP, (Timer t) => update());
  }
}
