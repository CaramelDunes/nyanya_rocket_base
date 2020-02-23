import '../state/multiplayer_game_state.dart';
import 'generators/multiplayer_generator.dart';
import 'game_simulator.dart';

class MultiplayerGameSimulator extends GameSimulator<MultiplayerGameState>
    with MultiplayerGenerator {}
