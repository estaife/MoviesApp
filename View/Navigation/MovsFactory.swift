//
//  MovsFactory.swift
//  View
//
//  Created by Estaife Lima on 16/10/21.
//

import UIKit

public protocol MovsFactory {
    func makeMovsFlowController(from navigationController: UINavigationController) -> MovsFlowController
    func makeAlertController(alertStyle: AlertControllerStyle, message: String?) -> AlertController
    func makePopularMoviesViewController() -> PopularMoviesViewController
}
