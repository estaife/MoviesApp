//
//  Data+Extension.swift
//  Data
//
//  Created by Estaife Lima on 01/03/21.
//

import Foundation

public extension Data {
    func convertToModel<T: Decodable>() -> T? {
       return try? JSONDecoder().decode(T.self, from: self)
    }

    var json: [String: Any]? {
        let json = try? JSONSerialization.jsonObject(with: self, options: .allowFragments)
        return json as? [String: Any]
    }
}
