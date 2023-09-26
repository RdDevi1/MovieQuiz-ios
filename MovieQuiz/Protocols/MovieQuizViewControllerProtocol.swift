import Foundation

protocol MovieQuizViewControllerProtocol: AnyObject {
    func showQuizStep(quiz step: QuizStepViewModel)
    func showQuizResult(quiz result: QuizResultsViewModel)
    func highlightImageBorder(isCorrectAnswer: Bool)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showNetworkError(message: String)
}
