class Frequencia {
  int id;
  String frequencia;

  Frequencia({
    this.id,
    this.frequencia,
  });

  factory Frequencia.fromMap(Map<String, dynamic> json) {
    return Frequencia(
      id: json['id'],
      frequencia: json['nome'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? 0,
      'frequencia': frequencia,
    };
  }

  @override
  String toString() {
    return this.frequencia;
  }
}
