//
//  TextFieldButtonViewController.swift
//  RxSwiftPractice
//
//  Created by 박다현 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


class TextFieldButtonViewController: UIViewController {

    let signName = UITextField()
    let signEmail = UITextField()
    let signButton = UIButton()
    let simpleLabel = UILabel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setSign()
        test()
    }
    //combinLatest : 두개의 시퀀스가 하나의 시퀀스가 된다.
    //여러 소스 중에서 단 한 가지라도 이벤트를 방출하면, 각각 소스의 맨 마지막 값을 뽑아서 새로운 값을 방출
    //ex) 이메일과 비밀번호가 변할 때마다 버튼의 enabled 를 계산할 때
    func test() {
        let first = Observable.of(1, 2, 3, 4)
        let second = Observable.of("A", "B", "C")
        
        Observable.combineLatest(first, second)
            .subscribe(onNext: { print("\($0)" + $1) })
            .disposed(by: disposeBag)
    }
    
    func setSign() {
        Observable
            .combineLatest(signName.rx.text.orEmpty, signEmail.rx.text.orEmpty, resultSelector: { value1, value2 in
                return "name은 \(value1)이고, email은 \(value2)입니다."
            })
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)
        
        signName.rx.text.orEmpty
            .map { $0.count < 4 }
            .bind(to: signEmail.rx.isHidden, signButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        signEmail.rx.text.orEmpty
            .map { $0.count > 4 }
            .bind(to: signButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signButton.rx.tap
            .subscribe { _ in
                self.showAlert(title: "로그인", message: "로로인", buttonMSG: "확인")
            }
            .disposed(by: disposeBag)
    }

    func showAlert(title:String, message:String, buttonMSG:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: buttonMSG, style: .default)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        view.addSubview(signName)
        view.addSubview(signEmail)
        view.addSubview(signButton)
        view.addSubview(simpleLabel)
        
        signName.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        signEmail.snp.makeConstraints { make in
            make.top.equalTo(signName.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        signButton.snp.makeConstraints { make in
            make.top.equalTo(signEmail.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        simpleLabel.snp.makeConstraints { make in
            make.top.equalTo(signButton.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        signName.backgroundColor = .lightGray
        signEmail.backgroundColor = .lightGray
        signButton.backgroundColor = .lightGray
        simpleLabel.backgroundColor = .lightGray
    }
}
