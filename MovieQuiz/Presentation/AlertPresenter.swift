
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
        
        alert.addAction(action)
        
        delegate?.didAlertShow(model: alert)
    }
    
}
