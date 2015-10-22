library wodClient.Systems;
import 'package:wodClient/src/Client.dart';
import 'dart:collection';
import 'package:wodClient/src/Game.dart';

abstract class GameSystem {
  void update(ClientData data);
}

class ClientInterface extends GameSystem {
  Queue<ClientCommand> _commands = new Queue();
  List<Client> _clients = new List();
  final Game _game;
  ClientData _clientData;

  ClientInterface(this._game);

  void update(ClientData data) {
    _clientData = data;

    while (_commands.isNotEmpty) {
      _handleCommand(_commands.removeFirst());
    }
    _clients.forEach((Client client) => client.update(_clientData));
  }

  void _handleCommand(ClientCommand command) {
    switch (command.runtimeType) {
      case SpawnCommand:
        _clientData.events.add(new SpawnPlayerEvent());
        break;
    }
  }

  handleCommand(ClientCommand command) => _commands.add(command);

  addClient(Client client) => _clients.add(client);
}
