//
//  ResultProtocol.swift
//  MovieQuiz
//
//  Created by Andrei Gavrilenko on 10.09.2024.
//

import Foundation

protocol ResultProtocol {
    func setCurrentQuestionIndexZero()
    func setCorrectAnswersZero()
    func show(quiz result: AlertModel)
}
