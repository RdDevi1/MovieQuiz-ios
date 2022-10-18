import Foundation

protocol StatisticService {
    
    var totalAccuracy: Double { get } //статистика игры
    var gamesCount: Int { get }  //количество сыгранных игр
    var bestGame: GameRecord { get } //рекорд
    
    func store(correct count: Int, total amount: Int) // метод сохранения текущего результата игры
    
}

struct GameRecord: Codable, Comparable {
    let correct: Int
    let total: Int
    let date: Date
    
    static func < (oldValue: GameRecord, newValue: GameRecord) -> Bool {
        return oldValue.correct < newValue.correct
    }
    
    func toString() -> String {
        return "\(correct)/\(total) (\(date.dateTimeString))"
    }
}


