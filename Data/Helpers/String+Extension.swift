//
//  String+Extension.swift
//  Domain
//
//  Created by Estaife Lima on 20/10/21.
//

import Domain

public extension String {
    func dateFormated(format: DateFormatter.Style) -> String {
        let dateFormatterDate = DateFormatter()
        dateFormatterDate.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatterDate.date(from: self) else { return "" }
        let dateFormatterString = DateFormatter()
        dateFormatterString.dateStyle = format
        return dateFormatterString.string(from: date)
    }
}

public extension String {
    func makeUrlImage(_ quality: QualityImage) -> URL? {
        let urlString = "\(Environment().baseImageURLString)\(quality.rawValue)\(self)"
        if let url = URL(string: urlString) {
            return url
        }
        return nil
    }
    
    var thumbImageURL: URL? {
        if let thumbImageURL = URL(string: "https://img.youtube.com/vi/\(self)/maxresdefault.jpg") {
            return thumbImageURL
        }
        return nil
    }
    
    var trailerVideoURL: URL? {
        if let trailerVideoURL = URL(string: "https://www.youtube.com/embed/\(self)?playsinline=1") {
            return trailerVideoURL
        }
        return nil
    }
}
