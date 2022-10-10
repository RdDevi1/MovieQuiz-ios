//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Vitaly Anpilov on 07.10.2022.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didRecieveNextQuestion(question: QuizQuestion?)
}
