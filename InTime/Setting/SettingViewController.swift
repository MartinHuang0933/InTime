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
        let button = UIButton(frame: CGRect(x: 0,y: 0,width: 100,height: 100))
        button.backgroundColor = .red
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.04705882353, green: 0.1176470588, blue: 0.1921568627, alpha: 1)
        self.title = "設定"
        
        setupSubviews2()
    }
}

extension SettingViewController
{
    func setupSubviews2()
    {
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)
         
        
        self.view.addSubview(self.refreshButton)
        
        //随机的表格数据
        let randomResult = refreshButton.rx.tap.asObservable()
            .startWith(()) //加这个为了让一开始就能自动请求一次数据
            .flatMapLatest(getRandomResult)
            .share(replay: 1)
         
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource
            <SectionModel<String, Int>>(configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "条目\(indexPath.row)：\(element)"
                return cell
            })
         
        //绑定单元格数据
        randomResult
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
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
            cell.selectionStyle = .none
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            cell.tintColor = .red
            let accessoryView = UIImageView(image: UIImage(named: "assetTableCell"));
            cell.accessoryView = accessoryView
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
    
    //获取随机数据
    func getRandomResult() -> Observable<[SectionModel<String, Int>]> {
        print("正在请求数据......")
        let items = (0 ..< 5).map {_ in
            Int(arc4random())
        }
        let observable = Observable.just([SectionModel(model: "Sjkjkjk", items: items)])
        return observable.delay(2, scheduler: MainScheduler.instance)
    }
}

extension SettingViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return kCellHeight
    }
}
