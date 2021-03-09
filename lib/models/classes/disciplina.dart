
class Disciplina {
  int id;
  String nome;

  Disciplina(
    this.id,
    this.nome,
  );

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
