import '../../domain/entities/cat.dart';

class CatModel extends Cat {
  const CatModel({
    required super.id,
    required super.name,
    super.cfaUrl,
    super.vetstreetUrl,
    super.vcahospitalsUrl,
    super.temperament,
    super.origin,
    super.countryCodes,
    super.countryCode,
    super.description,
    super.lifeSpan,
    super.indoor,
    super.lap,
    super.altNames,
    super.adaptability,
    super.affectionLevel,
    super.childFriendly,
    super.dogFriendly,
    super.energyLevel,
    super.grooming,
    super.healthIssues,
    super.intelligence,
    super.sheddingLevel,
    super.socialNeeds,
    super.strangerFriendly,
    super.vocalisation,
    super.experimental,
    super.hairless,
    super.natural,
    super.rare,
    super.rex,
    super.suppressedTail,
    super.shortLegs,
    super.wikipediaUrl,
    super.hypoallergenic,
    super.referenceImageId,
    super.image,
    super.weight,
  });

  factory CatModel.fromJson(Map<String, dynamic> json) {
    return CatModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      cfaUrl: json['cfa_url'],
      vetstreetUrl: json['vetstreet_url'],
      vcahospitalsUrl: json['vcahospitals_url'],
      temperament: json['temperament'],
      origin: json['origin'],
      countryCodes: json['country_codes'],
      countryCode: json['country_code'],
      description: json['description'],
      lifeSpan: json['life_span'],
      indoor: json['indoor'],
      lap: json['lap'],
      altNames: json['alt_names'],
      adaptability: json['adaptability'],
      affectionLevel: json['affection_level'],
      childFriendly: json['child_friendly'],
      dogFriendly: json['dog_friendly'],
      energyLevel: json['energy_level'],
      grooming: json['grooming'],
      healthIssues: json['health_issues'],
      intelligence: json['intelligence'],
      sheddingLevel: json['shedding_level'],
      socialNeeds: json['social_needs'],
      strangerFriendly: json['stranger_friendly'],
      vocalisation: json['vocalisation'],
      experimental: json['experimental'],
      hairless: json['hairless'],
      natural: json['natural'],
      rare: json['rare'],
      rex: json['rex'],
      suppressedTail: json['suppressed_tail'],
      shortLegs: json['short_legs'],
      wikipediaUrl: json['wikipedia_url'],
      hypoallergenic: json['hypoallergenic'],
      referenceImageId: json['reference_image_id'],
      image:
          json['image'] != null ? CatImageModel.fromJson(json['image']) : null,
      weight:
          json['weight'] != null
              ? CatWeightModel.fromJson(json['weight'])
              : null,
    );
  }

  factory CatModel.fromJsonIndividual(Map<String, dynamic> json) {
    return CatModel(
      id: json['breeds'][0]['id'] ?? '',
      name: json['breeds'][0]['name'] ?? '',
      cfaUrl: json['breeds'][0]['cfa_url'],
      vetstreetUrl: json['breeds'][0]['vetstreet_url'],
      vcahospitalsUrl: json['breeds'][0]['vcahospitals_url'],
      temperament: json['breeds'][0]['temperament'],
      origin: json['breeds'][0]['origin'],
      countryCodes: json['breeds'][0]['country_codes'],
      countryCode: json['breeds'][0]['country_code'],
      description: json['breeds'][0]['description'],
      lifeSpan: json['breeds'][0]['life_span'],
      indoor: json['breeds'][0]['indoor'],
      lap: json['breeds'][0]['lap'],
      altNames: json['breeds'][0]['alt_names'],
      adaptability: json['breeds'][0]['adaptability'],
      affectionLevel: json['breeds'][0]['affection_level'],
      childFriendly: json['breeds'][0]['child_friendly'],
      dogFriendly: json['breeds'][0]['dog_friendly'],
      energyLevel: json['breeds'][0]['energy_level'],
      grooming: json['breeds'][0]['grooming'],
      healthIssues: json['breeds'][0]['health_issues'],
      intelligence: json['breeds'][0]['intelligence'],
      sheddingLevel: json['breeds'][0]['shedding_level'],
      socialNeeds: json['breeds'][0]['social_needs'],
      strangerFriendly: json['breeds'][0]['stranger_friendly'],
      vocalisation: json['breeds'][0]['vocalisation'],
      experimental: json['breeds'][0]['experimental'],
      hairless: json['breeds'][0]['hairless'],
      natural: json['breeds'][0]['natural'],
      rare: json['breeds'][0]['rare'],
      rex: json['breeds'][0]['rex'],
      suppressedTail: json['breeds'][0]['suppressed_tail'],
      shortLegs: json['breeds'][0]['short_legs'],
      wikipediaUrl: json['breeds'][0]['wikipedia_url'],
      hypoallergenic: json['breeds'][0]['hypoallergenic'],
      referenceImageId: json['breeds'][0]['reference_image_id'],
      image:
          json['url']!= null ? CatImageModel.fromJson(json) : null,
      weight:
          json['breeds'][0]['weight'] != null
              ? CatWeightModel.fromJson(json['breeds'][0]['weight'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cfa_url': cfaUrl,
      'vetstreet_url': vetstreetUrl,
      'vcahospitals_url': vcahospitalsUrl,
      'temperament': temperament,
      'origin': origin,
      'country_codes': countryCodes,
      'country_code': countryCode,
      'description': description,
      'life_span': lifeSpan,
      'indoor': indoor,
      'lap': lap,
      'alt_names': altNames,
      'adaptability': adaptability,
      'affection_level': affectionLevel,
      'child_friendly': childFriendly,
      'dog_friendly': dogFriendly,
      'energy_level': energyLevel,
      'grooming': grooming,
      'health_issues': healthIssues,
      'intelligence': intelligence,
      'shedding_level': sheddingLevel,
      'social_needs': socialNeeds,
      'stranger_friendly': strangerFriendly,
      'vocalisation': vocalisation,
      'experimental': experimental,
      'hairless': hairless,
      'natural': natural,
      'rare': rare,
      'rex': rex,
      'suppressed_tail': suppressedTail,
      'short_legs': shortLegs,
      'wikipedia_url': wikipediaUrl,
      'hypoallergenic': hypoallergenic,
      'reference_image_id': referenceImageId,
      'image': image != null ? (image as CatImageModel).toJson() : null,
      'weight': weight != null ? (weight as CatWeightModel).toJson() : null,
    };
  }
}

class CatImageModel extends CatImage {
  const CatImageModel({
    required super.id,
    required super.width,
    required super.height,
    required super.url,
  });

  factory CatImageModel.fromJson(Map<String, dynamic> json) {
    return CatImageModel(
      id: json['id'] ?? '',
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      url: json['url'] ?? '',
    );
  }
  

  Map<String, dynamic> toJson() {
    return {'id': id, 'width': width, 'height': height, 'url': url};
  }
}

class CatWeightModel extends CatWeight {
  const CatWeightModel({required super.imperial, required super.metric});

  factory CatWeightModel.fromJson(Map<String, dynamic> json) {
    return CatWeightModel(
      imperial: json['imperial'] ?? '',
      metric: json['metric'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'imperial': imperial, 'metric': metric};
  }
}
