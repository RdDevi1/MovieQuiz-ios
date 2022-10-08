//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Vitaly Anpilov on 07.10.2022.
//

import Foundation

protocol QuestionFactoryDelegate: class {
    func didRecieveNextQuestion(question: QuizQuestion?)
}
