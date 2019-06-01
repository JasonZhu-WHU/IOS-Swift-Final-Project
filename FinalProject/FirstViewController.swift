//
//  FirstViewController.swift
//  FinalProject
//
//  Created by zhujie on 2019/5/29.
//  Copyright © 2019 zhujie. All rights reserved.
//

import UIKit
import CoreData
import Eureka

class FirstViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    

    @IBOutlet weak var add_btn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    static var show: Bool = false
    
    var items :[Any] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self;
        self.tableView.delegate = self as UITableViewDelegate;
        self.view.addSubview(add_btn)
        
        add_btn.isHidden = true
        tableView.isHidden = true
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "StudentInfo")
        do{
            items = try context.fetch(request)
            print(items.count)
          }
        catch{
            print("Error occurs in fetch data: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        let dic = items[indexPath.row] as! NSManagedObject
        cell.textLabel?.text = (dic.value(forKey: "name") as! String)
        cell.detailTextLabel!.text = (dic.value(forKey: "major") as! String)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row] as! NSManagedObject
        self.performSegue(withIdentifier: "modifyInfo", sender: item)
    }

    static func display(){
        FirstViewController.show = true;
    }
    override func viewWillAppear(_ animated: Bool) {
        if(FirstViewController.show == true){
            add_btn.isHidden = false
            tableView.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //判断是通过哪个segue进行的跳转，然后处理传值
        print("判断segue")
        print(segue.identifier ?? "default segue??")
        if segue.identifier == "modifyInfo"{
            //实例化第二个页面
            let page2:InfoViewController = segue.destination as! InfoViewController
            //传值
            page2.item = items[tableView.indexPathForSelectedRow!.row] as! NSManagedObject
            print("开始传值")
            print(((page2.item as! NSManagedObject).value(forKey: "name") as! String))
            print(((page2.item as! NSManagedObject).value(forKey: "studentID") as! String))
            print("结束传值")
        }
    }
}
