//
//  RouteModel.swift
//  HSL.V2
//
//  Created by 张嬴 on 14.4.2023.
//


import Foundation

//struct Route: Decodable {
//    let gtfsID, shortName: String
//    let stops: [Stop]
//}

struct Route: Decodable {
    let gtfsId: String
    let shortName: String
    let longName: String
    let trips: [Trip]

    enum CodingKeys: String, CodingKey {
        case gtfsId
        case shortName
        case longName
        case trips
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        gtfsId = try container.decode(String.self, forKey: .gtfsId)
        shortName = try container.decode(String.self, forKey: .shortName)
        longName = try container.decode(String.self, forKey: .longName)
        trips = try container.decode([Trip].self, forKey: .trips)
    }
}

struct Trip: Decodable {
    let stoptimes: [StopTime]

    enum CodingKeys: String, CodingKey {
        case stoptimes
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        stoptimes = try container.decode([StopTime].self, forKey: .stoptimes)
    }
}

struct StopTime: Decodable {
    let stop: Stop
    let realtimeArrival: Int

    enum CodingKeys: String, CodingKey {
        case stop
        case realtimeArrival
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        stop = try container.decode(Stop.self, forKey: .stop)
        realtimeArrival = try container.decode(Int.self, forKey: .realtimeArrival)
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
