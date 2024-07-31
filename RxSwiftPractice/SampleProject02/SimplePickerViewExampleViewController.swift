//
//  SimplePickerViewExampleViewController.swift
//  RxSwiftPractice
//
//  Created by 박다현 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa

class SimplePickerViewExampleViewController: UIViewController {
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    let pickerView3 = UIPickerView()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configurePickView1()
        configurePickView2()
        configurePickView3()
    

        
        
    }
    
    func configurePickView1() {
        Observable.just([1, 2, 3])
            .bind(to: pickerView1.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)
        
        pickerView1.rx.modelSelected(Int.self)
            .subscribe { models in
                print("mdels selected 1: \(models)")
            }
            .disposed(by: disposeBag)
    }
    func configurePickView2() {
        Observable.just([1, 2, 3])
            .bind(to: pickerView2.rx.itemAttributedTitles) { _, item in
                return NSAttributedString(string: "\(item)", 
                                          attributes : [
                                            NSAttributedString.Key.foregroundColor : UIColor.cyan,
                                            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.double.rawValue
                
                ])
            }
            .disposed(by: disposeBag)
        
        pickerView2.rx.modelSelected(Int.self)
            .subscribe { models in
                print("models selected 2: \(models)")
            }
            .disposed(by: disposeBag)
    }
    func configurePickView3() {
        Observable.just([UIColor.red, UIColor.green, UIColor.blue])
            .bind(to: pickerView3.rx.items) { _, item, _ in
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposeBag)
        
        pickerView3.rx.modelSelected(UIColor.self)
            .subscribe { model in
                print("models selected 3: \(model)")
            }
            .disposed(by: disposeBag)
    }
    
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(pickerView1)
        view.addSubview(pickerView2)
        view.addSubview(pickerView3)
        
        pickerView1.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        pickerView2.snp.makeConstraints { make in
            make.top.equalTo(pickerView1.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        pickerView3.snp.makeConstraints { make in
            make.top.equalTo(pickerView2.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }


}
