//
//  ViewController.swift
//  XCTest-Sample
//
//  Created by Kazunori Aoki on 2021/06/19.
//

// 参考：https://www.youtube.com/watch?v=P-Zow2yVx4o&ab_channel=KiloLoco
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let dummyDatabase = [User(username: "kilo loco", password: "password1")]
    
    private let validation: ValidationService
    
    init(validation: ValidationService) {
        self.validation = validation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.validation = ValidationService()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tapLoginButton(_ sender: Any) {
        do {
            
            let username = try validation.validateUsername(usernameTextField.text)
            let password = try validation.validatePassword(passwordTextField.text)

            if let user = dummyDatabase.first(where: { user in
                user.username == username && user.password == password
            }) {
                presentAlert(with: "You successfully logged in as \(user.username)")
            } else {
                throw LoginError.invalidCredentials
            }
        } catch {
            present(error)
        }
    }
    
}

extension ViewController {
    
    enum LoginError: LocalizedError {
        case invalidCredentials
        
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return "Incorrenct username or password. Please try again."
            }
        }
    }
}
