//
//  SimpleValidationViewController.swift
//  RxSwiftPractice
//
//  Created by 박다현 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class SimpleValidationViewController: UIViewController {

    let usernameOutlet = UITextField()
    let usernameValidOutlet = UILabel()
    let passwordOutlet = UITextField()
    let passwordValidOutlet = UILabel()
    let doSomethingOutlet = UIButton()
    let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureValidation()
    }

    func configureValidation() {
        let usernameValid = usernameOutlet.rx.text.orEmpty
            .map{ $0.count >= minimalUsernameLength }
            .share(replay: 1) //share()는 한번 생성한 시퀀스를 공유 하는 것 //replay는 버퍼의 사이즈
        
        let passwordValid = passwordOutlet.rx.text.orEmpty
            .map{ $0.count >= minimalPasswordLength }
            .share(replay: 1) //share??
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: disposedBag)
        
        usernameValid
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposedBag)
        
        passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposedBag)
        
        everythingValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposedBag)
        
        doSomethingOutlet.rx.tap
            .subscribe { [weak self] _ in
                self?.showAlert()
            }
            .disposed(by: disposedBag)
    }
    
    func configureView() {
        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"
    }
    
    func showAlert() {
        print("얼럿")
    }

}
