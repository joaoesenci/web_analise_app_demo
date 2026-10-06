import 'package:web_analise_app/core/domain/entities/picture_entity.dart';

final class PictureModel extends PictureEntity {
  const PictureModel({super.id, super.path, super.url});

  factory PictureModel.fromMap(Map<String, dynamic> map) {
    return PictureModel(id: map['nome-do-campo'], url: map['nome-do-campo'], path: '');
  }
}

// Está como 'nome do campo' para proteger o arquivo json real no portfólio, mantendo a segurança.