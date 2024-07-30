//
//  BasicButtonViewController.swift
//  RxSwiftPractice
//
//  Created by 박다현 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class BasicButtonViewController: UIViewController {

    let button = UIButton()
    let label = UILabel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonExample()
    }

    func buttonExample() {
        //1.
        button.rx.tap //infinite Observable Streams -> error, completed가 실행되지 않음
            .subscribe { _ in
                self.label.text = "버튼을 클릭했어요."
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
        
        //2.
        button.rx.tap //메모리 누수 위험이 있고, 쓰레드 세이프 하지 않음
            .subscribe { _ in
                self.label.text = "버튼을 클릭했어요."
            }
            .disposed(by: disposeBag)
        
        //3.
        button.rx.tap
            .observe(on: MainScheduler.instance) //메인쓰레드에서 동작
            .withUnretained(self) // 약한 참조로 캡쳐리스트의 메모리 누수 방지,
            .subscribe { _ in
                self.label.text = "버튼을 클릭했어요."
            }
            .disposed(by: disposeBag)
        //4.
        button.rx.tap
            .bind(with: self, onNext: { owner, _ in //약한참조, 메인쓰레드에서 동작, ui에 좀더 최적화?
                owner.label.text = "버튼을 클릭했어요."
            })
            .disposed(by: disposeBag)
        
        //5.
        button.rx.tap
            .map{ "버튼을 클릭했어요." } //데이터 형태가 변함
            .bind(to: label.rx.text) //이러면? 위에 with를 쓴것과 같은것인가..?
            .disposed(by: disposeBag)
    }
}
