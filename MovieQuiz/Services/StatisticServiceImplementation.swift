
import Foundation


final class StatisticServiceImplementation: StatisticService {
    
    // MARK: - For help
    
    private let userDefaults = UserDefaults.standard
    
    //ключи для сущностей, которые надо сохранить
    private enum Keys: String {
        case correct, total, bestGame, gamesCount
    }
    
    
    // MARK: - Body
    
    var totalAccuracy: Double {
        get {
            return (Double(correct) / Double(total)) * 100
        }
    }
    
    var gamesCount: Int {
        get {
            userDefaults.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    
    var bestGame: GameRecord {
        get {
            guard let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
                  let record = try? JSONDecoder().decode(GameRecord.self, from: data) else {
                      return .init(correct: 0, total: 0, date: Date())
                  }
            return record
        }
        
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
    
    private var correct: Int {
        get {
            userDefaults.integer(forKey: Keys.correct.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.correct.rawValue)
        }
    }
    
    private var total: Int {
        get {
            userDefaults.integer(forKey: Keys.total.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.total.rawValue)
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        gamesCount += 1
        correct += count
        total += amount
        
        let newResult = GameRecord(correct: count, total: amount, date: Date())
        if bestGame.correct < newResult.correct {
            bestGame = newResult
        }
    }
}
