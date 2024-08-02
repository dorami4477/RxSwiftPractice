//
//  SimpleValidation2ViewController.swift
//  RxSwiftPractice
//
//  Created by 박다현 on 8/2/24.
//

import UIKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class SimpleValidation2ViewController: UIViewController {
    
    let usernameOutlet = UITextField()
    let usernameValidOutlet = UILabel()
    let passwordOutet = UITextField()
    let passwordValidOutlet = UILabel()
    let doSomethingOutlet = UIButton()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        let usernameValid = usernameOutlet.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)
        
        let passwordValid = passwordOutet.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
        
        let everyThingVaild = Observable.combineLatest(usernameValid, passwordValid) {
            $0 && $1
        }
            .share(replay: 1)
        
        usernameValid
            .bind(to: passwordOutet.rx.isEnabled, usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden, doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        doSomethingOutlet.rx.tap
            .bind(with: self) { owner, _ in
                owner.showAlert()
            }
            .disposed(by: disposeBag)
        
    }


    func showAlert() {
        print("doSth")
    }
}
