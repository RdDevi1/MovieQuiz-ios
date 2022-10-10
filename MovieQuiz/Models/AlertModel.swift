//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Vitaly Anpilov on 08.10.2022.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    var completion: (() -> Void)?
}
