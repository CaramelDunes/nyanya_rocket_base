import '../state/game_state.dart';
import 'generators/challenge_generator.dart';
import 'game_simulator.dart';

// Could use inheritance instead of mixins.
class ChallengeGameSimulator extends GameSimulator<GameState>
    with ChallengeGenerator {}
