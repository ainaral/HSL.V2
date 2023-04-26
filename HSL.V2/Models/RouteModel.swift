//
//  RouteModel.swift
//  HSL.V2
//
//  Created by 张嬴 on 14.4.2023.
//


import Foundation

struct Route: Decodable {
    let gtfsId: String
    let shortName: String
    let stops: [Stop]
    let patterns: [Pattern]

    enum CodingKeys: String, CodingKey {
        case gtfsId
        case shortName
        case stops
        case patterns
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        gtfsId = try container.decode(String.self, forKey: .gtfsId)
        shortName = try container.decode(String.self, forKey: .shortName)
        stops = try container.decode([Stop].self, forKey: .stops)
        patterns = try container.decode([Pattern].self, forKey: .patterns)
    }
}

struct Stop: Decodable {
    let name: String
    let lat: Double
    let lon: Double

    enum CodingKeys: String, CodingKey {
        case name
        case lat
        case lon
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        lat = try container.decode(Double.self, forKey: .lat)
        lon = try container.decode(Double.self, forKey: .lon)
    }
}

struct Pattern: Decodable {
    let name: String
    let patternGeometry: PatternGeometry
    
    enum CodingKeys: String, CodingKey {
        case name, patternGeometry
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        patternGeometry = try container.decode(PatternGeometry.self, forKey: .patternGeometry)
    }
}

struct PatternGeometry: Decodable {
    let points: String
    
    enum CodingKeys: String, CodingKey {
        case points
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        points = try container.decode(String.self, forKey: .points)
    }
}
