//
//  BusModel.swift
//  HSL.V2
//
//  Created by 张嬴 on 17.4.2023.
//

import Foundation

struct Bus: Decodable {
    let gtfsId: String
    let shortName: String
    let longName: String
    let mode: String
}
