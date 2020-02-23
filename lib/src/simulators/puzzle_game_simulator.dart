import 'generators/puzzle_generator.dart';
import '../state/game_state.dart';

import 'game_simulator.dart';

class PuzzleGameSimulator extends GameSimulator<GameState>
    with PuzzleGenerator {}
