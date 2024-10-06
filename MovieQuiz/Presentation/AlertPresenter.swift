//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Andrei Gavrilenko on 10.09.2024.
//

import Foundation
import UIKit

final class AlertPresenter {
    
    func show(quiz result: AlertModel, controller: MovieQuizViewController) {
        let alert = UIAlertController(
            title: result.title,
            message: result.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: result.buttonText, style: .default) { _ in
            result.completion?()
        }
        
        alert.addAction(action)
        controller.present(alert, animated: true, completion: nil)
    }
    
    
}
