//
//  SimpleTableViewExample2ViewController.swift
//  RxSwiftPractice
//
//  Created by 박다현 on 8/2/24.
//

import UIKit
import RxSwift
import RxCocoa

class SimpleTableViewExample2ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    let items = Observable.just(
        (0..<20).map{ "\($0)" }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }
    
    func bind() {
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)){ row, element, cell in
                cell.textLabel?.text = "\(element) @row \(row)"
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe{ print($0) }
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe { indexPath in
                print(indexPath)
            }
            .disposed(by: disposeBag)
    }

    
    func configureView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    

}
