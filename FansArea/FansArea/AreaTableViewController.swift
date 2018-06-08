//
//  AreaTableViewController.swift
//  FansArea
//
//  Created by qujiahong on 2018/6/2.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

import UIKit
import CoreData

class AreaTableViewController: UITableViewController,NSFetchedResultsControllerDelegate,UISearchResultsUpdating {
    
    var sc : UISearchController!
    
    var fc : NSFetchedResultsController<AreaMO>!
    
    //由于此时 不需要再没次都用代码写数据，数据源可以留空
    var areas : [AreaMO] = []
    
    //定义一个空数组以保存搜索结果
    var searchResults : [AreaMO] = []
    //添加一个筛选器方法
    func searchFilter(text: String) {
        //Swift数组自带的filter方法/功能:返回一个符合条件的新数组
        searchResults = areas.filter({ (area) -> Bool in
            //Contains检测字符串中包含另一个字符串
            return area.name!.localizedCaseInsensitiveContains(text)
        })
    }
   // MARK: - System
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //判断：从UserDefaults中取
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "guiderShow") {
            return
        }
        
        
        //显示引导页
        if let pageVC = storyboard?.instantiateViewController(withIdentifier: "GuiderViewController") as? GuiderViewController {
            pageVC.hidesBottomBarWhenPushed = true
            present(pageVC, animated: true, completion: nil)
        }

        //放在viewDidAppear里执行
//        fetchAllData()
//        tableView.reloadData()
        
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //向下滑动时隐藏导航条
        self.navigationController?.hidesBarsOnSwipe = true

        sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.dimsBackgroundDuringPresentation = false
        sc.searchBar.tintColor = UIColor.white
        sc.searchBar.placeholder = "输入name进行搜索哟!"
        sc.searchBar.barTintColor = UIColor.orange
        tableView.tableHeaderView = sc.searchBar
        
        fetchAllData2()
        
        
    }
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        if var text = searchController.searchBar.text {
           
            text = text.trimmingCharacters(in: .whitespaces)
            searchFilter(text: text)
            tableView.reloadData()
        }
    }
    
    // MARK: - 写一个获取所有Area Entity下数据的方法
    func fetchAllData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //do-try-catch错误处理
        do {
            //AreaMO.fetchRequest() 获取AreaMO此Entity的所有条目
            
            areas = try appDelegate.persistentContainer.viewContext.fetch(AreaMO.fetchRequest())
        } catch  {
            print(error)
        }
        
    }
    func fetchAllData2() {
        //请求结果是AreaMO
        let request : NSFetchRequest<AreaMO> = AreaMO.fetchRequest()
        //NSSortDescriptor指定请求结果如何排序[这里是按name来的，即ABC...]
        let sd = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sd]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //NSFetchedResultsController初始化后，指定代理
        fc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fc.delegate = self
        
        //执行查询，将结果保存到数组中
        do {
            try fc.performFetch()
            if let objects = fc.fetchedObjects {
                areas = objects
                
            }
        } catch {
            print(error)
        }
        //如果执行，会显示上一次保存的数据，但新增数据后，表格不会更新
        
    }
    
    //当控制器开始处理内容变化时
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
       tableView.beginUpdates()
    }
    //内容发生变更时
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
       
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        default:
            tableView.reloadData()
        }
        
        //数据已经发生了变化，同步到数组
        if let objects = controller.fetchedObjects {
            areas = objects as! [AreaMO]
        }
    }
    //当控制器已经处理完内容变更时
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
     
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

//        return areas.count
        return sc.isActive ? searchResults.count : areas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let area = sc.isActive ? searchResults[indexPath.row] : areas[indexPath.row]
        
        cell.nameLab.text = area.name
        cell.thumbImage.image = UIImage(data: area.thumbImage!)
        cell.proviceLab.text = area.province
        cell.partLab.text = area.part
        
        cell.thumbImage.layer.cornerRadius = cell.thumbImage.frame.size.width/2
        cell.thumbImage.layer.masksToBounds = true
        
        cell.accessoryType = area.visited ? .checkmark : .none
        
        return cell
    }
 
    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alertAC = UIAlertController(title: "友情提示", message: "您点击了\n第\(indexPath.row)行的\n ->\(areas[indexPath.row].part!)<-", preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: "我去过", style: .default) { (_) in
            let cell = tableView.cellForRow(at: indexPath)
            
            //右部扩展
            cell?.accessoryType = .checkmark
            
            self.areas[indexPath.row].visited = true
            
        }
        let action2 = UIAlertAction(title: "不明白", style: .cancel, handler: nil)
        let action3 = UIAlertAction(title: "进入详情页", style: .destructive) { (_) in
            
            let detailTVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
            detailTVC.area = self.sc.isActive ? self.searchResults[indexPath.row] : self.areas[indexPath.row]
            detailTVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailTVC, animated: true)
            
        }
        
        alertAC.addAction(action)
        alertAC.addAction(action2)
        alertAC.addAction(action3)
        
        self.present(alertAC, animated: true, completion: nil)
    
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - 有点看不懂的segue的转场
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        
    }
    


    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let actionShare = UITableViewRowAction(style: .normal, title: "分享") { (_, indexPath) in
            let alertSheet = UIAlertController(title: "分享到", message: nil, preferredStyle: .actionSheet)
            
            let option1 = UIAlertAction(title: "QQ", style: .default, handler: nil)
            let option2 = UIAlertAction(title: "微信", style: .default, handler: nil)
            let option3 = UIAlertAction(title: "微博", style: .default, handler: nil)
            let option4 = UIAlertAction(title: "算了吧", style: .cancel, handler: nil)
            
            alertSheet.addAction(option1)
            alertSheet.addAction(option2)
            alertSheet.addAction(option3)
            alertSheet.addAction(option4)
            
            self.present(alertSheet, animated: true, completion: nil)
        }
        let actionDelete = UITableViewRowAction(style: .destructive, title: "删除") { (_, indexPath) in
            self.areas.remove(at: indexPath.row)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(self.fc.object(at: indexPath))
            appDelegate.saveContext()
            
//            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        let actionTop = UITableViewRowAction(style: .default, title: "我是紫色") { (_, indexPath) in
            //取出当前元素
            
            //删除当前元素
            
            //将当前元素放在数组第0个位置
            
            //刷新table
        }
        
        
        actionShare.backgroundColor = UIColor.orange
        actionTop.backgroundColor = UIColor.purple
        return [actionShare,actionDelete,actionTop]
    }
    //搜索显示时，不可编辑
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return !sc.isActive
    }
    
    // MARK: - Navigation


}
