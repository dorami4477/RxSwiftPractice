//
//  SimpleTableViewExampleViewController.swift
//  RxSwiftPractice
//
//  Created by 박다현 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa

class SimpleTableViewExampleViewController: UIViewController {

    let tableView = UITableView()
    let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureView()
    }
    func configureTableView() {
        let items = Observable.just(
            (0..<20).map({ "\($0)" })
        )
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposedBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe { value in
                //DefaultWireframe.presentAlert("Tapped \(value)")
                print("Tapped \(value)")
            }
            .disposed(by: disposedBag)
        
        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe { indexPath in
                print("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            }
            .disposed(by: disposedBag)
    }
    func configureView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}
