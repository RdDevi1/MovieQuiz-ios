//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Vitaly Anpilov on 08.10.2022.
//

import Foundation
import UIKit


class  AlertPresenter: AlertPresenterProtocol {
    
    weak var delegate: AlertPresenterDelegate?
    
    init(delegate: AlertPresenterDelegate?) {
        self.delegate = delegate
    }
    
    func showAlert(model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in }
        //            guard let self = self else { return }
        //            self.currentQuestionIndex = 0
        //            self.correctAnswers = 0
        //
        //            // заново показываем первый вопрос
        //            self.questionFactory?.requestNextQuestion()
        
        //
        //         надо в методе протокола презентера передавать алерт модель
        //         А в метод делегата UIAlertController и в реализации делегата надо метод present писать
        
        alert.addAction(action)
        
        // alert.present(alert, animated: true, completion: model.completion)
    }
    
}
