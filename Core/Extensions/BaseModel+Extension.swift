//
//  BaseModel+Extension.swift
//  Domain
//
//  Created by Estaife Lima on 01/03/21.
//

import Foundation

public protocol BaseModel: Codable, Equatable { }

public extension BaseModel {
    var data: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: [String: Any]? {
        guard let json = self.data?.json else {
            return nil
        }
        return json
    }
}
