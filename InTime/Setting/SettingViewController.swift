//
//  SettingViewController.swift
//  InTime
//
//  Created by Mac on 2020/11/30.
//  Copyright © 2020 Martin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingViewController: UIViewController {

    let disposeBag = DisposeBag()
    let kCellHeight: CGFloat = 52

    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.04705882353, green: 0.1176470588, blue: 0.1921568627, alpha: 1)
        self.title = "設定"
        
        setupSubviews()
    }
}

extension SettingViewController
{
    func setupSubviews()
    {
        //0. 创建tableView
        view.addSubview(self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(view)
        }
        
        //1. 创建可观察数据源
        let texts = ["關於作者", "Swift", "RXSwift", "aa"]
        let textsObservable = Observable.from(optional: texts)
        
        //2. 将数据源与 tableView 绑定
        textsObservable.bind(to: tableView.rx
            .items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, text, cell) in
                cell.textLabel?.text = text
                cell.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.168627451, blue: 0.2470588235, alpha: 1)
                cell.textLabel?.textColor = UIColor.white
                
//                cell.tintColor = UIColor.whiteColor()
                cell.selectionStyle = .none
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                cell.tintColor = .red
                
                let imageV = UIImageView(image: UIImage(named: "icon1_selected"));
                cell.accessoryView = imageV
        }
        .disposed(by: disposeBag)
        
        //3. 绑定 tableView 的事件
        tableView.rx.itemSelected.bind { (indexPath) in
            print(indexPath)
        }
        .disposed(by: disposeBag)

        //4. 设置 tableView Delegate/DataSource 的代理方法
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

extension SettingViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return kCellHeight
    }
}
