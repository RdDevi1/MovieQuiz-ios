
import Foundation

class QuestionFactory: QuestionFactoryProtocol {
    
    var delegate: QuestionFactoryDelegate?
    
    private let moviesLoader: MoviesLoader
    
    private var movies: [MostPopularMovie] = []
    
    //    private let questions: [QuizQuestion] = [
    //            QuizQuestion(
    //                image: "The Godfather",
    //                text: "Рейтинг этого фильма больше чем 6?",
    //                correctAnswer: true),
    //            QuizQuestion(
    //                image: "The Dark Knight",
    //                text: "Рейтинг этого фильма больше чем 6?",
    //                correctAnswer: true),
    //            QuizQuestion(
    //                image: "Kill Bill",
    //                text: "Рейтинг этого фильма больше чем 6?",
    //                correctAnswer: true),
    //            QuizQuestion(
    //                image: "The Avengers",
    //                text: "Рейтинг этого фильма больше чем 6?",
    //                correctAnswer: true),
    //            QuizQuestion(
    //                image: "Deadpool",
    //                text: "Рейтинг этого фильма больше чем 6?",
    //                correctAnswer: true),
    //            QuizQuestion(
    //                image: "The Green Knight",
    //                text: "Рейтинг этого фильма больше чем 6?",
    //                correctAnswer: true),
    //            QuizQuestion(
    //                image: "Old",
    //                text: "Рейтинг этого фильма больше чем 6?",
    //                correctAnswer: false),
    //            QuizQuestion(
    //                image: "The Ice Age Adventures of Buck Wild",
    //                text: "Рейтинг этого фильма больше чем 6?",
    //                correctAnswer: false),
    //            QuizQuestion(
    //                image: "Tesla",
    //                text: "Рейтинг этого фильма больше чем 6?",
    //                correctAnswer: false),
    //            QuizQuestion(
    //                image: "Vivarium",
    //                text: "Рейтинг этого фильма больше чем 6?",
    //                correctAnswer: false)
    //        ]
    
    init(delegate: QuestionFactoryDelegate, moviesLoader: MoviesLoader) {
        self.delegate = delegate
        self.moviesLoader = moviesLoader
    }
    
    func requestNextQuestion() {
        DispatchQueue.global().async { [weak self] in  //запускаем работу с изображениями и сетью в другом потоке
            guard let self = self else { return }  //выбираем произвольный элемент из массива, чтобы показать его
            let index = (0..<self.movies.count).randomElement() ?? 0
            
            guard let movies = self.movies[safe: index] else { return }
            
            var imageData = Data()  //создание данных для картинки из URL и обработка ошибки
            
            do {
                imageData = try Data(contentsOf: movies.resizedImageURL)
            } catch {
                print("Failed to load image")
            }
            
            let rating = Float(movies.rating) ?? 0
            
           
            let questionsArray = [
                "Рейтинг этого фильма больше чем 8,5?",
                "Рейтинг этого фильма меньше чем 8,5?"]
            
            let text = questionsArray.randomElement()!
            
            var correctAnswer: Bool {
                if rating > 8.5 && text == "Рейтинг этого фильма больше чем 8,5?" {
                    return true
                } else if rating < 8.5 && text == "Рейтинг этого фильма больше чем 8,5?" {
                    return false
                } else if rating > 8.5 && text == "Рейтинг этого фильма меньше чем 8,5?" {
                    return false
                } else {
                    return true
                }
            }
            
            let question = QuizQuestion(image: imageData, text: text, correctAnswer: correctAnswer)
            
            DispatchQueue.main.async { [weak self] in   //возвращение в главные поток после загрузки данных
                guard let self = self else { return }
                self.delegate?.didReceiveNextQuestion(question: question)
            }
            
            //        let index = (0..<questions.count).randomElement() ?? 0
            //        let question = questions[safe: index]
            //        delegate?.didRecieveNextQuestion(question: question)
        }
    }
    
    func loadData() {
        moviesLoader.loadMovies { result in
            
            DispatchQueue.main.async { [weak self] in   //возвращение в главные поток после загрузки данных
                guard let self = self else { return }
                
                switch result {
                    
                case .success(let mostPopularMovies):
                    self.movies = mostPopularMovies.items  // сохраняем фильм в нашу новую переменную
                    self.delegate?.didLoadDataFromServer() // сообщаем, что данные загрузились
                    
                case .failure(let error):
                    self.delegate?.didFailToLoadData(with: error) // сообщаем об ошибке нашему MovieQuizViewController
                }
            }
        }
    }
}
