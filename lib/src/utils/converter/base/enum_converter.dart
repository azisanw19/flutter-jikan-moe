/// [T] decode to [R]
abstract class EnumConverter<T, R> {

  T encode(R from);

  R decode(T from);

}