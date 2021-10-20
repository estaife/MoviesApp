//
//  ModelToData.swift
//  Data
//
//  Created by Estaife Lima on 01/03/21.
//

import Foundation

public extension Data {
    func convertToModel<T: Decodable>() -> T? {
       return try? JSONDecoder().decode(T.self, from: self)
    }
}
