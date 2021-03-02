//
//  TestFactories+Extension.swift
//  DataTests
//
//  Created by Estaife Lima on 30/05/20.
//  Copyright © 2020 Estaife Lima. All rights reserved.
//

import Foundation

var dataInvalid: Data {
    return .init("Data Invaid".utf8)
}

var dataValid: Data {
    return .init("""
        {
            "page":1,
            "results":[
                {
                    "poster_path":"/gj282Pniaa78ZJfbaixyLXnXEDI.jpg",
                    "adult":false,
                    "overview":"Katniss Everdeen reluctantly becomes the symbol of a mass rebellion against the autocratic Capitol.",
                    "release_date":"2014-11-18",
                    "genre_ids":[
                        878,
                        12,
                        53
                    ],
                    "id":131631,
                    "original_title":"The Hunger Games: Mockingjay - Part 1",
                    "original_language":"en",
                    "title":"The Hunger Games: Mockingjay - Part 1",
                    "backdrop_path":"/83nHcz2KcnEpPXY50Ky2VldewJJ.jpg",
                    "popularity":15.774241,
                    "vote_count":3182,
                    "video":false,
                    "vote_average":6.69
                }
            ],
            "total_results":19629,
            "total_pages":982
        }
        """.utf8)
}

var dataEmpty: Data {
    return .init()
}


func createResponseWith(statusCode: Int) -> HTTPURLResponse {
    return HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}

var url: URL {
    return URL(string: "http://url-mock.com")!
}

var error: Error {
    NSError(domain: "error_any", code: -1, userInfo: [:])
}
