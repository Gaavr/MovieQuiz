//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Andrei Gavrilenko on 09.09.2024.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
}
