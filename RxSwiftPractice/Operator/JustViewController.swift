//
//  JustViewController.swift
//  RxSwiftPractice
//
//  Created by 박다현 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class JustViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    let itemsA = [3.3, 4.0, 5.0, 2.0, 3.6, 4.8]
    let itemsB = [2.3, 2.0, 1.3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        letsKnowJust()
        letsKnowOf()
        letsKnowFrom()
        letsKnowTake()
    }

    func letsKnowJust() { //하나의 값만 방출
        
        Observable.just(itemsA)
            .subscribe { value in
                print("just - \(value)")
            } onError: { error in
                print("just - \(error)")
            } onCompleted: {
                print("just Completed")
            } onDisposed: {
                print("just Disposed")
            }
            .disposed(by: disposeBag)
        print("--------------")

    }
    
    func letsKnowOf() { //2개 이상의 값을 방출

        Observable.of(itemsA, itemsB)
            .subscribe { value in
                print("of - \(value)")
            } onError: { error in
                print("of - \(error)")
            } onCompleted: {
                print("of completed")
            } onDisposed: {
                print("of disposed")
            }
            .disposed(by: disposeBag)
        print("--------------")
    }
    
    func letsKnowFrom() { //배열의 각요소 리턴
        Observable.from(itemsA)
            .subscribe { value in
                print("from - \(value)")
            } onError: { error in
                print("from - \(error)")
            } onCompleted: {
                print("from Completed")
            } onDisposed: {
                print("from Disposed")
            }
            .disposed(by: disposeBag)
        print("--------------")
    }
    
    func letsKnowTake() { //방출된 아이템 중 처음 n개의 아이템을 내보냄
        Observable.repeatElement("jack")
            .take(5)
            .subscribe { value in
                print("repeat - \(value)")
            } onError: { error in
                print("repeat - \(error)")
            } onCompleted: {
                print("repeat Completed")
            } onDisposed: {
                print("repeat Disposed")
            }
            .disposed(by: disposeBag)
        print("--------------")
    }

}
