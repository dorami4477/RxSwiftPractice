//
//  NumbersViewController.swift
//  RxSwiftPractice
//
//  Created by 박다현 on 8/4/24.
//

import UIKit
import RxSwift
import RxCocoa

class Numbers2ViewController: UIViewController {

    let number1 = UITextField()
    let number2 = UITextField()
    let number3 = UITextField()
    let result = UILabel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }
    
    func bind() {
        Observable
            .combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty)
            .map {
                let num1 = Int($0) ?? 0
                let num2 = Int($1) ?? 0
                let num3 = Int($2) ?? 0
                let sum = num1 + num2 + num3
                return sum.formatted()
            }
            .bind(to: result.rx.text)
            .disposed(by: disposeBag)
        
    }

    func configureView() {
        view.addSubview(number1)
        view.addSubview(number2)
        view.addSubview(number3)
        view.addSubview(result)
        
        number1.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }
        number2.snp.makeConstraints { make in
            make.top.equalTo(number1.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
        number3.snp.makeConstraints { make in
            make.top.equalTo(number2.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
        result.snp.makeConstraints { make in
            make.top.equalTo(number3.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.height.equalTo(44)
        }
        number1.backgroundColor = .lightGray
        number2.backgroundColor = .lightGray
        number3.backgroundColor = .lightGray
        result.backgroundColor = .lightGray
    }
}
