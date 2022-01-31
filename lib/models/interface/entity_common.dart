abstract class EntityCommon<T> extends Comparable<T> {
  late int id;

  Map<String, dynamic> toMap();

  @override
  int compareTo(T other);
}
