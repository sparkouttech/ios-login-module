//
//  ViewController.swift
//  LoginModule
//
//  Created by Keerthi on 21/08/21.
//

import UIKit

class ViewController: UIViewController {

    lazy var loginViewController: OverrideLoginViewController = {
        let controller = OverrideLoginViewController()
        controller.loginType = .emailWithPassword
        controller.delegate = self
        controller.modalPresentationStyle = .overFullScreen
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.present(loginViewController, animated: true, completion: nil)
    }
}

extension ViewController: LoginViewDelegate {
    func didSelectBack(_ viewController: UIViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didSelectLogin(_ viewController: UIViewController, loginModel: LoginModel) {
        print(loginModel)
    }
}

