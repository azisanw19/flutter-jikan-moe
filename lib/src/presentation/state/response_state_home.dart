sealed class ResponseStateHome {}

class ResponseStateNavigationChance extends ResponseStateHome {
  final int index;
  ResponseStateNavigationChance(this.index) : super();
}