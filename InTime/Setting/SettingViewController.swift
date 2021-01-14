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
import RxDataSources
import Alamofire
import Firebase

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
    
    lazy var refreshButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0,y: 0,width: 0,height: 0))
        button.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        return button
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
        //创建表格视图
        if #available(iOS 13.0, *) {
            self.tableView = UITableView(frame: self.view.frame, style:.insetGrouped)
        } else {
            self.tableView = UITableView(frame: self.view.frame, style:.grouped)
        }
        self.tableView.backgroundColor = #colorLiteral(red: 0.04705882353, green: 0.1176470588, blue: 0.1921568627, alpha: 1)
        self.tableView.separatorColor = #colorLiteral(red: 0.1176944152, green: 0.2295543253, blue: 0.34139961, alpha: 1)
        //创建一个重用的单元格
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.refreshButton)
        
        //随机的表格数据
        let randomResult = refreshButton.rx.tap.asObservable()
            .startWith(()) //加这个为了让一开始就能自动请求一次数据
            .flatMapLatest(getRandomResult)
            .share(replay: 1)
         
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource
            <SectionModel<String, String>>(configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                cell.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.168627451, blue: 0.2470588235, alpha: 1)
                cell.textLabel?.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                cell.textLabel?.text = "\(element)"
                cell.selectionStyle = .none
                let accessoryView = UIImageView(image: UIImage(named: "assetTableCell"));
                cell.accessoryView = accessoryView
                return cell
            })
         
        //绑定单元格数据
        randomResult
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        //3. 绑定 tableView 的事件
        self.tableView.rx.itemSelected.bind { (indexPath) in
            var vc : UIViewController
            switch (indexPath.section,indexPath.row) {
            case (0,0):
                vc = SetStartTimeViewController()
            case (1,0):
                vc = AboutMeViewController()
            default:
                vc = AboutMeViewController()
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        .disposed(by: disposeBag)
    }
    
    //获取随机数据
    func getRandomResult() -> Observable<[SectionModel<String, String>]> {
        let section1 = ["每日起始時間"]
        let section2 = ["關於"]
        let observable = Observable.just([SectionModel(model: "", items: section1),SectionModel(model: "", items: section2)])
        return observable
    }
}

extension SettingViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return kCellHeight
    }
}
