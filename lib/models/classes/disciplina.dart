class Disciplina {
  int id;
  String nome;

  Disciplina({
    this.id,
    this.nome,
  });

  factory Disciplina.fromMap(Map<String, dynamic> json) {
    return Disciplina(
      id: json['id'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? 0,
      'nome': nome,
    };
  }

  @override
  String toString() {
    return this.nome;
  }

  bool operator ==(other) {
    if (this.nome == other.nome) {
      return true;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => super.hashCode;
}
