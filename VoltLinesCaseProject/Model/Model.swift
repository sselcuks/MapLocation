//
//  Model.swift
//  VoltLinesCaseProject
//
//  Created by Selcuk on 2.01.2022.
//

import Foundation

//MARK: Location Data
struct Location: Codable {
    let centerCoordinates: String
    let id: Int
    let name: String
    let trips: [Trip]
    let tripsCount: Int

    enum CodingKeys: String, CodingKey {
        //case centerCoordinates = centerCoordinates.components(separatedBy: ",")
        case centerCoordinates = "center_coordinates"
        case id, name, trips
        case tripsCount = "trips_count"
    }
}

// MARK: - Trip Data
struct Trip: Codable {
    let busName: String
    let id: Int
    let time: String

    enum CodingKeys: String, CodingKey {
        case busName = "bus_name"
        case id, time
    }
}
