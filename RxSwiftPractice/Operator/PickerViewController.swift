//
//  ViewController.swift
//  RxSwiftPractice
//
//  Created by 박다현 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PickerViewController: UIViewController {
    
    let simplePickerView = UIPickerView()
    let simpleLabel = UILabel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        setPickerView()
    }

    func configureUI() {
        view.addSubview(simplePickerView)
        view.addSubview(simpleLabel)
        simplePickerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        simpleLabel.snp.makeConstraints { make in
            make.top.equalTo(simplePickerView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        simpleLabel.backgroundColor = .lightGray
        simplePickerView.backgroundColor = .lightGray
    }
    func setPickerView() {
        let items = Observable.just([
         "영화",
         "애니메이션",
         "드라마",
         "기타"
        ])
        
        items.bind(to: simplePickerView.rx.itemTitles) { (row, element) in //아이탬을 픽커뷰의 타이틀로 넘겨줌 //어떻게 요소가 2개 나오지
            return element
        }
        .disposed(by: disposeBag)
        
        simplePickerView.rx.modelSelected(String.self) //event
            .map{ $0.description }   //$0.description 이거뭐지
            .bind(to: simpleLabel.rx.text )
            .disposed(by: disposeBag)
    }

}

