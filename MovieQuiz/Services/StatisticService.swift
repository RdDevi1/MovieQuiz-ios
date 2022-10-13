import Foundation

protocol StatisticService {
    
    var totalAccuracy: Double { get }
    var gamesCount: Int { get set }
    var bestGame: GameRecord { get set }
    
    func store(correct count: Int, total amount: Int)
    
}

struct GameRecord: Codable {
    let correct: Int
    let total: Int
    let date: Date
    
    private func compareRecords(current: GameRecord, previous: GameRecord) -> GameRecord {
        
    }
}


final class StatisticServiceImplementation: StatisticService {
    private let userDefaults = UserDefaults.standard
    
    var totalAccuracy: Double {
        get {
            
        }
        set {
            
        }
    }
    
    var gamesCount: Int {
        get {
            
        }
        set {
            
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
    
    private enum Keys: String {
        case correct, total, bestGame, gamesCount
    }
    
    func store(correct count: Int, total amount: Int) {
        <#code#>
    }
    
  
    init(totalAccuracy: Double, gamesCount: Int, bestGame: GameRecord) {
        self.totalAccuracy = totalAccuracy
        self.gamesCount = gamesCount
        self.bestGame = bestGame
    }
    
}
