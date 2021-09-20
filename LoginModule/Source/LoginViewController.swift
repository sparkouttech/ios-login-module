//
//  LoginViewController.swift
//  LoginModule
//
//  Created by Keerthi on 21/08/21.
//

import UIKit

public protocol LoginViewDelegate: AnyObject {
    func didSelectBack(_ viewController: UIViewController)
    func didSelectLogin(_ viewController: UIViewController, loginModel: LoginModel)
}

public enum LoginType {
    case mobileNumberWithPassword
    case mobileNumberWithOTP
    case emailWithPassword
    case userNameWithPassword
}

open class LoginViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mobileNumberView: UIView!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var countryCodeTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var mobileNumberTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var userNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet var textFieldCollection: [SkyFloatingLabelTextField]!
    @IBOutlet weak var loginButton: UIButton!
    
    public weak var delegate: LoginViewDelegate?
    public var loginType: LoginType = .mobileNumberWithPassword
    public var backgroundImage: UIImage? = UIImage(named: "login-logo") {
        didSet {
            backgroundImageView.image = backgroundImage
        }
    }
    public var titleValue: String = "Enter your mobile number" {
        didSet {
            titleLabel.text = titleValue
        }
    }
    public var descriptionValue: String = "Please confirm your country code and enter your phone numebr" {
        didSet {
            descriptionLabel.text = descriptionValue
        }
    }
    
    public var titleFont: UIFont = .boldSystemFont(ofSize: 20) {
        didSet {
            self.applyConfiguration()
        }
    }
    
    public var descriptionFont: UIFont = .systemFont(ofSize: 13) {
        didSet {
            self.applyConfiguration()
        }
    }
    
    public var emailPlaceholder: String = "Email" {
        didSet {
            emailTextField.placeholder = emailPlaceholder
        }
    }
    public var userNamePlaceholder: String = "Username" {
        didSet {
            userNameTextField.placeholder = userNamePlaceholder
        }
    }
    public var countryCodePlaceholder: String = "Country Code" {
        didSet {
            countryCodeTextField.placeholder = countryCodePlaceholder
        }
    }
    public var mobileNumberPlaceholder: String = "Mobile number" {
        didSet {
            mobileNumberTextField.placeholder = mobileNumberPlaceholder
        }
    }
    public var passwordPlaceholder: String = "Password" {
        didSet {
            passwordTextField.placeholder = passwordPlaceholder
        }
    }
    public lazy var configuration: DefaultConfiguration = {
        return DefaultConfiguration()
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureLoginType()
        configureTextField()
        configureLoginButton()
        applyConfiguration()
    }
    
    override open func loadView() {
        self.view = viewFromNib(optionalName: "LoginViewController")
    }
    
    func configureLoginButton() {
        self.loginButton.layer.cornerRadius = 5
        self.loginButton.setTitleColor(UIColor.white, for: .normal)
        self.loginButton.backgroundColor = UIColor().colorFromHex(hex: "#EFB239")
    }
    
    func configureLoginType() {
        switch loginType {
        case .mobileNumberWithOTP:
            self.mobileNumberView.isHidden = false
            self.emailTextField.isHidden = true
            self.userNameTextField.isHidden = true
            self.passwordTextField.isHidden = true
        case .mobileNumberWithPassword:
            self.mobileNumberView.isHidden = false
            self.emailTextField.isHidden = true
            self.userNameTextField.isHidden = true
            self.passwordTextField.isHidden = false
        case .emailWithPassword:
            self.mobileNumberView.isHidden = true
            self.emailTextField.isHidden = false
            self.userNameTextField.isHidden = true
            self.passwordTextField.isHidden = false
        case .userNameWithPassword:
            self.mobileNumberView.isHidden = true
            self.emailTextField.isHidden = true
            self.userNameTextField.isHidden = false
            self.passwordTextField.isHidden = false
        }
    }
    
    func configureTextField() {
        for txt in textFieldCollection {
            txt.lineColor = configuration.lineColor
            txt.selectedLineColor = configuration.selectedLineColor
            txt.textColor = configuration.textColor
            txt.placeholderColor = configuration.placeholderColor
            txt.selectedTitleColor = configuration.selectedTitleColor
            txt.selectedLineHeight = 1.0
            txt.placeholderFont = configuration.placeholderFont
            txt.titleFont = configuration.titleFont
        }
    }
    
    func applyConfiguration() {
        self.backgroundImageView.image = self.backgroundImage
        self.titleLabel.text = self.titleValue
        self.descriptionLabel.text = self.descriptionValue
        self.titleLabel.font = self.titleFont
        self.descriptionLabel.font = self.descriptionFont
        self.emailTextField.placeholder = self.emailPlaceholder
        self.userNameTextField.placeholder = self.userNamePlaceholder
        self.countryCodeTextField.placeholder = self.countryCodePlaceholder
        self.mobileNumberTextField.placeholder = self.mobileNumberPlaceholder
        self.passwordTextField.placeholder = self.passwordPlaceholder
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.delegate?.didSelectBack(self)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.delegate?.didSelectLogin(self, loginModel: createLoginModel())
    }

    func createLoginModel() -> LoginModel {
        var loginModel = LoginModel()
        loginModel.email = self.emailTextField.text ?? ""
        loginModel.mobile = self.mobileNumberTextField.text ?? ""
        loginModel.userName = self.userNameTextField.text ?? ""
        loginModel.password = self.passwordTextField.text ?? ""
        return loginModel
    }
    
    // MARK: - Navigation

    func gotoCountryCodeVC() {
        let vc = CountryCodeVC(nibName: "CountryCodeVC", bundle: nil)
        vc.delegate = self
        self.present(vc, animated: true) {}
    }
}

extension LoginViewController: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == countryCodeTextField {
            self.gotoCountryCodeVC()
            return false
        }
        return true
    }
}

extension LoginViewController: CountryCodeProtocol {
    func updateCountryCode(dic: CountryCodeModel) {
        let dialCode = dic.dialCode
        self.countryCodeTextField.text = dialCode
    }
}

