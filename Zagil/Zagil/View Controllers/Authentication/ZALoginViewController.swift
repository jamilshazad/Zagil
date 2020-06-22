//
//  ZALoginViewController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 17/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import PromiseKit

class ZALoginViewController: ZAViewController {

    
    // MARK: - Class Properties
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var emailTextField: ZATextField!
    @IBOutlet weak var passwordTextField: ZATextField!
    @IBOutlet weak var signInButton: ZAButton!
    private var rememberMe: Bool = false
    private var validator: Validator!
    
    
    // MARK: - Life - Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupViewController() {
        signInButton.isGradient = true
        signInButton.isEnabled = false
        signInButton.alpha = 0.4
        addValidator()
        emailTextField.text = ZAUserDefaults.email.get()
        passwordTextField.text = ZAUserDefaults.password.get()
    }
    
    private func addValidator() {
        validator = Validator(with: view, scrollView: scrollView, delegate: self)
        validator.configure(.init(textField: emailTextField, rules: .regex(regex: .email)),
                            .init(textField: passwordTextField, rules: .min(characters: 6)))
    }
    
    private func startSignupFlowAfterSocialLogin(session: SocialSession, provider: ProviderType) {
        showHud()
        let user = session.user
        firstly {
            APIClient.verify(email: session.user.email)
        }.then { isExists -> Promise<User> in
            if isExists {
                return APIClient.updateSocial(iD: user.id, name: user.name, email: user.email, provider: provider)
            } else {
                return APIClient.socialLogin(iD: user.id, name: user.name, email: user.email, provider: provider)
            }
        }.done { [weak self] user in
            guard let self = self else { return }
            self.hideHud()
            ZAUserDefaults.user.set(value: user)
            self.view.window?.swapRoot(viewController: R.storyboard.privacy.instantiateInitialViewController()!, animation: .present)
        }.catch { [weak self] error in
            guard let self = self else { return }
            self.hideHud()
            self.displayService(error: error)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.containerView.endEditing(true)
    }

}


// MARK: - ValidationDelegate Methods

extension ZALoginViewController: ValidationDelegate {
    
    func onValidationChanged(_ areFieldsValid: Bool) {
        signInButton.isEnabled = areFieldsValid
        signInButton.alpha = areFieldsValid == true ? 1.0 : 0.4
    }
    
}


// MARK: - Action Methods

extension ZALoginViewController {
    
    @IBAction private func crossButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rememberMeButtonTapped(_ sender: UIButton) {
        let image = sender.tag == 0 ? R.image.check() : R.image.uncheck()
        sender.setImage(image, for: .normal)
        sender.tag = sender.tag == 0 ? 1 : 0
        rememberMe = sender.tag == 1
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        showHud()
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if self.rememberMe {
            ZAUserDefaults.email.set(value: email)
            ZAUserDefaults.password.set(value: password)
        } else {
            ZAUserDefaults.email.clear()
            ZAUserDefaults.password.clear()
        }
        
        APIClient.login(email: email, password: password).done { [weak self] user in
            guard let self = self else { return }
            self.hideHud()
            ZAUserDefaults.user.set(value: user)
            self.view.window?.swapRoot(viewController: R.storyboard.privacy.instantiateInitialViewController()!, animation: .present)
        }.catch { [weak self] error in
            guard let self = self else { return }
            self.hideHud()
            self.displayService(error: error)
        }
    }
    
    @IBAction func facebookButtonTapped(_ sender: UIButton) {
        Authorize.me.on(provider: .facebook, from: self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let socialSession):
                self.startSignupFlowAfterSocialLogin(session: socialSession, provider: .facebook)
            case .failure(let error):
                self.displayService(error: error)
            }
        }
    }
    
    @IBAction func googleButtonTapped(_ sender: UIButton) {
        Authorize.me.on(provider: .google, from: self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let socialSession):
                self.startSignupFlowAfterSocialLogin(session: socialSession, provider: .google)
            case .failure(let error):
                self.displayService(error: error)
            }
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        present(viewController: ZASignUpViewController.self, storyboard: R.storyboard.authentication()) { [weak self] viewController in
            guard let _ = self else { return }
            viewController.modalPresentationStyle = .fullScreen
        }
    }
    
}
