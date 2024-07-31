//
//  SwitchTableViewController.swift
//  RxSwiftPractice
//
//  Created by 박다현 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SwitchTableViewController: UIViewController {
    
    let simpleSwitch = UISwitch()
    let simpleTableView = UITableView()
    let simpleLabel = UILabel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setTableView()
        setSwitch()
    }
    
    func configureView() {
        view.addSubview(simpleSwitch)
        view.addSubview(simpleLabel)
        view.addSubview(simpleTableView)
        
        simpleSwitch.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        simpleLabel.snp.makeConstraints { make in
            make.top.equalTo(simpleSwitch.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
        simpleTableView.snp.makeConstraints { make in
            make.top.equalTo(simpleLabel.snp.bottom).offset(10)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        simpleLabel.backgroundColor = .lightGray
        simpleTableView.backgroundColor = .lightGray
    }
    
    
    func setTableView() {
        simpleTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let item = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
        ])
         
        item.bind(to: simpleTableView.rx.items) { (tableView, row, element) in //items와 클로저는 왜 자동완성이 안되지..
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element) @row \(row)"
            return cell
        }
        .disposed(by: disposeBag)
        
        simpleTableView.rx.modelSelected(String.self)
            .map { data in
                "\(data)를 클릭했습니다."
            }
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)
    }

    func setSwitch() {
        Observable.of(true) //just는 한개요소 , of는 여러개
            .bind(to: simpleSwitch.rx.isOn)
            .disposed(by: disposeBag)
    }

}
