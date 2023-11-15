sealed class RequestStateHome {}

class RequestStateNavigationChance extends RequestStateHome {
  final int index;
  RequestStateNavigationChance(this.index) : super();
}