/// Tracks experiences where returning to the app must never show an ad.
/// Owners make route replacement safe: disposing an old game cannot clear
/// the protection registered by a newly opened game.
abstract final class GameplayActivity {
  static final Set<Object> _owners = {};

  static bool get isPlaying => _owners.isNotEmpty;

  static void begin(Object owner) => _owners.add(owner);

  static void end(Object owner) => _owners.remove(owner);
}
