
import Foundation
import UIKit

protocol AlertPresenterDelegate: AnyObject {
    func didAlertShow(model: UIAlertController?)
}
