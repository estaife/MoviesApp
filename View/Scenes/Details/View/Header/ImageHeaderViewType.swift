//
//  ImageHeaderViewType.swift
//  View
//
//  Created by Estaife Lima on 30/10/21.
//

import UIKit

internal protocol ImageHeaderViewType: AnyObject {
    func updateView(with viewState: ImageHeaderViewState)
}
