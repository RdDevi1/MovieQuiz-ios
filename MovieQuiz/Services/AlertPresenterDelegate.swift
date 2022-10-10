//
//  AlertPresenterDelegate.swift
//  MovieQuiz
//
//  Created by Vitaly Anpilov on 09.10.2022.
//

import Foundation
import UIKit

protocol AlertPresenterDelegate: AnyObject {
    func didAlertShow(model: UIAlertController?)
}
