//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Andrei Gavrilenko on 10.09.2024.
//

import Foundation

struct AlertModel {
    var title: String
    var message: String
    var buttonText: String
    var completion: (() -> Void)?
}
