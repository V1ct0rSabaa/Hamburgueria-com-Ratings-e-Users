class Item {
  final int id;
  final String nome;
  final double nota;
  final String valorMedio;
  final String endereco;
  final String contato;

  const Item({
    required this.id,
    required this.nome,
    required this.nota,
    required this.valorMedio,
    required this.endereco,
    required this.contato,
  });
  Item.fromMap(Map<String, dynamic> map)
    : id = map["id"],
    nome = map["nome"],
    nota = map["nota"],
    valorMedio = map["valorMedio"],
    endereco = map["endereco"],
    contato = map["contato"];
  
  Map<String, dynamic> toMap(){
    return {
      "id" : id,
      "nome" : nome,
      "nota" : nota,
      "valorMedio" : valorMedio,
      "endereco" : endereco,
      "contato" : contato
    };
  }
}
