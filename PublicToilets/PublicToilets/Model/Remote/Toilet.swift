//
//  Toilet.swift
//  PublicToilets
//
//  Created by Ahmed Atia on 29/09/2022.
//

import Foundation

// MARK: - Toilet

struct Toilet: Codable {
    let nhits: Int?
    let parameters: Parameters?
    let records: [Record]
}

// MARK: - Parameters

struct Parameters: Codable {
    let dataset: Dataset?
    let rows, start: Int?
    let format, timezone: String?
}

// MARK: - Dataset

enum Dataset: String, Codable {
    case sanisettesparis2011
}

// MARK: - Record

struct Record: Codable {
    let datasetid: Dataset?
    let recordid: String?
    let fields: Fields
    let geometry: Geometry?
    let recordTimestamp: RecordTimestamp?

    enum CodingKeys: String, CodingKey {
        case datasetid
        case recordid
        case fields
        case geometry
        case recordTimestamp = "record_timestamp"
    }
}

// MARK: - Fields

struct Fields: Codable {
    let complementAdresse: ComplementAdresse?
    let geoShape: GeoShape?
    let horaire: Horaire?
    let accesPmr: AccesPmr?
    let arrondissement: Int?
    let geoPoint2D: [Double]
    let source: String?
    let gestionnaire: Gestionnaire?
    let adresse: String?
    let type: FieldsType?
    let urlFicheEquipement: String?
    let relaisBebe: AccesPmr?

    enum CodingKeys: String, CodingKey {
        case complementAdresse = "complement_adresse"
        case geoShape = "geo_shape"
        case horaire
        case accesPmr = "acces_pmr"
        case arrondissement
        case geoPoint2D = "geo_point_2d"
        case source, gestionnaire, adresse, type
        case urlFicheEquipement = "url_fiche_equipement"
        case relaisBebe = "relais_bebe"
    }
}

// MARK: - AccesPmr

enum AccesPmr: String, Codable {
    case non = "Non"
    case oui = "Oui"
}

// MARK: - ComplementAdresse

enum ComplementAdresse: String, Codable {
    case numeroDeVoieNomDeVoie = "numero_de_voie nom_de_voie"
}

// MARK: - GeoShape

struct GeoShape: Codable {
    let coordinates: [[Double]]?
    let type: GeoShapeType?
}

// MARK: - GeoShapeType

enum GeoShapeType: String, Codable {
    case multiPoint = "MultiPoint"
}

// MARK: - Gestionnaire

enum Gestionnaire: String, Codable {
    case toilettePubliqueDeLaVilleDeParis = "Toilette publique de la Ville de Paris"
}

// MARK: - Horaire

enum Horaire: String, Codable {
    case the24H24 = "24 h / 24"
    case the6H1H = "6 h - 1 h"
    case the6H22H = "6 h - 22 h"
    case voirFicheÉquipement = "Voir fiche équipement"
}

// MARK: - FieldsType

enum FieldsType: String, Codable {
    case lavatory = "LAVATORY"
    case sanisette = "SANISETTE"
    case toilettes = "TOILETTES"
    case urinoir = "URINOIR"
    case urinoirFemme = "URINOIR FEMME"
    case wcPublicsPermanents = "WC PUBLICS PERMANENTS"
}

// MARK: - Geometry

struct Geometry: Codable {
    let type: GeometryType?
    let coordinates: [Double]?
}

// MARK: - GeometryType

enum GeometryType: String, Codable {
    case point = "Point"
}

// MARK: - RecordTimestamp

enum RecordTimestamp: String, Codable {
    case the20221004T041200432Z = "2022-10-04T04:12:00.432Z"
}
