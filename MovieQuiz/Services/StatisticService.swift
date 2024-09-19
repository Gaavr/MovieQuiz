//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Andrei Gavrilenko on 11.09.2024.
//

import Foundation

final class StatisticService: StatisticServiceProtocol {
    
    private let storage: UserDefaults = .standard
    
    var totalAccuracy: Double {
        get {
            let corretAnswers: Int = storage.integer(forKey: Keys.globalCorrectAnswers.rawValue)
            if (gamesCount > 0) {
                return Double(corretAnswers) / (Double(gamesCount) * 10) * 100
            } else {
                return 0
            }
            
        }
    }
    
    var gamesCount: Int {
        get {
            storage.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameResult {
        get {
            let corret = storage.integer(forKey: Keys.oneGameCorrectAnswers.rawValue)
            let total = storage.integer(forKey: Keys.oneGameTotal.rawValue)
            let date = storage.object(forKey: Keys.date.rawValue) as? Date ?? Date()
            
            return GameResult(correct: corret, total: total, date: date)
        }
        set {
            storage.set(newValue.correct, forKey: Keys.oneGameCorrectAnswers.rawValue)
            storage.set(newValue.total, forKey: Keys.oneGameTotal.rawValue)
            storage.set(newValue.date, forKey: Keys.date.rawValue)
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        storage.set(storage.integer(forKey: Keys.globalCorrectAnswers.rawValue) + count,
                    forKey: Keys.globalCorrectAnswers.rawValue)
        storage.set(storage.integer(forKey: Keys.globalTotal.rawValue) + amount,
                    forKey: Keys.globalTotal.rawValue)
        storage.set(gamesCount + 1, forKey: Keys.gamesCount.rawValue)
        
        let newGameResult = GameResult(correct: count, total: amount, date: Date())
        if newGameResult.isBetterThan(bestGame) {
            bestGame = newGameResult
        }
    }
    
    private enum Keys: String {
        case globalCorrectAnswers = "globalCorrectAnswers"
        case globalTotal = "globalTotal"
        case oneGameCorrectAnswers = "oneGameCorrectAnswers"
        case oneGameTotal = "oneGameTotal"
        case date = "date"
        case gamesCount = "gamesCount"
    }
}
