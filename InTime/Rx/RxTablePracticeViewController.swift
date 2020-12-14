//
//  RxTablePracticeViewController.swift
//  InTime
//
//  Created by Mac on 2020/11/23.
//  Copyright © 2020 Martin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxTablePracticeViewController: UIViewController {
    
    
    lazy var registerBtn: UIButton? = {
        let button = UIButton()
        button.setTitle("註冊", for: .normal)
        
        print("aaaaa");
        
//        button.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
        return button
    }()
    
//    UIButton *button = [UIButton new];
//    [button setTitle:@"立即注册" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    var tableView = UITableView(frame: .zero)
    let kCellHeight: CGFloat = 40
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupSubviews()
        
        
//        print(self.registerBtn);
        
        
        self.registerBtn = nil;
        
        
//        print(self.registerBtn);
        
//        // 1
//        let subject = PublishSubject<String>()
//        // 2
//        subject
//            .subscribe(onNext: {
//                print($0)
//            })
//            .disposed(by: disposeBag)
//        // 3
//        subject.onNext("1")
//        subject.onNext("2")
//        subject.onNext("3")
    }
}

extension RxTablePracticeViewController
{
    func setupSubviews()
    {
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        view.addSubview(tableView)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.snp.makeConstraints { (make) in
//            make.left.right.top.bottom.equalTo(view)
//        }
//        //1.创建可观察数据源
//        let texts = ["Objective-C", "Swift", "RXSwift", "aa"]
//        let textsObservable = Observable.from(optional: texts)
//        //2. 将数据源与 tableView 绑定
//        textsObservable.bind(to: tableView.rx
//            .items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, text, cell) in
//                cell.textLabel?.text = text
//        }
//        .disposed(by: disposeBag)
//        //3. 绑定 tableView 的事件
//        tableView.rx.itemSelected.bind { (indexPath) in
////            print(indexPath)
//        }
//        .disposed(by: disposeBag)
//
//        //4. 设置 tableView Delegate/DataSource 的代理方法
//        tableView.rx.setDelegate(self).disposed(by: disposeBag)
//
//        tableView.rx.itemMoved.subscribe(onNext: { (soureIndex,destiIndex) in
//            print("从 \(soureIndex)移动到 \(destiIndex)")
//        })
//        .disposed(by: disposeBag)
        
        
//        let subject = PublishSubject<Void>()
//        // 1
//        tableView.rx.itemSelected
//            .subscribe(onNext: { _ in
//                print("=== A Tap ===")
//                subject.onNext(())
//            })
//            .disposed(by: disposeBag)
//
//        // 2
//        var seconds = 1.0
//        // Put your code which should be executed with a delay here
//        subject.subscribe(onNext: {
//            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
//                print("B Tap")
//            }
//        })
//        .disposed(by: self.disposeBag)
//
//
//        // 3
//        seconds = 2.0
//        subject.subscribe(onNext: {
//            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
//                print("C Tap")
//            }
//        })
//        .disposed(by: self.disposeBag)
        
        
//        let subject = PublishSubject<String>()
//
//        subject.onNext("1")
//        // 1, 2
//        subject
//            .debug("🏀")
//            .subscribe()
//            .disposed(by: disposeBag)
//
//        subject.onNext("2")
//
//        subject.onNext("3")
//
//        subject
//            .debug("🎾")
//            .subscribe()
//            .disposed(by: disposeBag)
//        // 3
//        subject.onError(NSError(domain: "Test", code: -1, userInfo: nil))
        
        
        
        let subject = BehaviorSubject<String>(value: "1")

        subject
            .debug("A")
            .subscribe()
            .disposed(by: disposeBag)

        subject.onNext("2")
        // 2
        print("Subject value: \(try! subject.value())")

        subject.onNext("3")

        subject.onError(NSError(domain: "Test", code: -1, userInfo: nil))

        subject
            .debug("B")
            .subscribe()
            .disposed(by: disposeBag)
        // 3
//        print("Subject value: \(try! subject.value())")
        
        
        
//        itemSelected.bind { (indexPath) in
//            print(indexPath)
//        }
//        .disposed(by: disposeBag)
    }
}

extension RxTablePracticeViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
}
