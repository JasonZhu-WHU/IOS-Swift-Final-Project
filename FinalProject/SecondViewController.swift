//
//  SecondViewController.swift
//  FinalProject
//
//  Created by zhujie on 2019/5/29.
//  Copyright © 2019 zhujie. All rights reserved.
//

import UIKit
import CoreData
import Eureka

class SecondViewController: FormViewController {

    @IBOutlet weak var topSearchImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var search_btn: UIButton!
    
    static var showIsTrue: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(topSearchImage)
        self.view.addSubview(label)
        self.view.addSubview(search_btn)
        self.view.addSubview(searchBar)
    }

    @IBAction func search_clicked(_ sender: Any) {
        if(SecondViewController.showIsTrue){
            print("search is clicked")
            let name: String = searchBar.text!
            let appDel = UIApplication.shared.delegate as! AppDelegate
            let context = appDel.managedObjectContext
            //获取单个学生信息
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Score")
            fetchRequest.predicate = NSPredicate(format: "name = %@", name)
            let students = try! context.fetch(fetchRequest) as! [Score]
            let studentToQuery = students[0] as NSManagedObject
            print(students.count)
            
            //获取全班平均分
            var items :[Any] = []
            let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Score")
            do{
                items = try context.fetch(request)
            }
            catch{
                print("Error occurs in fetch data: \(error)")
            }
            let itemsNumber: Int = items.count
            var cTotal: Int = 0
            var mTotal: Int = 0
            var eTotal: Int = 0
            var ocTotal: Int = 0
            print(items.count)
            for item in items{
                cTotal += Int(((item as! NSManagedObject).value(forKey: "chinese") as? String)!)!
                mTotal += Int(((item as! NSManagedObject).value(forKey: "math") as? String)!)!
                eTotal += Int(((item as! NSManagedObject).value(forKey: "english") as? String)!)!
                ocTotal += Int(((item as! NSManagedObject).value(forKey: "oc") as? String)!)!
                print(ocTotal)
            }
            
            let cAverage = String(format: "%.2f", Float(cTotal/itemsNumber))
            let mAverage = String(format: "%.2f", Float(mTotal/itemsNumber))
            let eAverage = String(format: "%.2f", Float(eTotal/itemsNumber))
            let ocAverage = String(format: "%.2f", Float(ocTotal/itemsNumber))
            print(ocAverage)
            
            form.removeAll()
            for _ in 0...8 {
                form +++ Section()
            }
            
            form +++ Section("成绩单")
                <<< TextRow(){row in
                    row.tag = "Chinese"
                    row.title = "语文"
                    row.value = (studentToQuery).value(forKey: "chinese") as? String
                }
                <<< TextRow(){row in
                    row.tag = "Math"
                    row.title = "数学"
                    row.value = (studentToQuery).value(forKey: "math") as? String

                }
                <<< TextRow(){row in
                    row.tag = "English"
                    row.title = "英语"
                    row.value = (studentToQuery).value(forKey: 	"english") as? String
                }
                <<< TextRow(){row in
                    row.tag = "OC"
                    row.title = "Objective-C"
                    row.value = (studentToQuery).value(forKey: "oc") as? String
            }
            
            form +++ Section("了解全班各科的平均分")
                <<< SwitchRow("high"){
                    $0.title = "显示"
                }
                <<< LabelRow(){ row in
                    row.hidden = Condition.function(["high"], { form in
                        return !((form.rowBy(tag: "high") as? SwitchRow)?.value ?? false)
                    })
                    row.tag = "cHigh"
                    row.title = "语文"
                    row.value = "\(cAverage)"
                }
                <<< LabelRow(){ row in
                    row.hidden = Condition.function(["high"], { form in
                        return !((form.rowBy(tag: "high") as? SwitchRow)?.value ?? false)
                    })
                    row.tag = "mHigh"
                    row.title = "数学"
                    row.value = "\(mAverage)"
                }
                <<< LabelRow(){ row in
                    row.hidden = Condition.function(["high"], { form in
                        return !((form.rowBy(tag: "high") as? SwitchRow)?.value ?? false)
                    })
                    row.tag = "eHigh"
                    row.title = "英语"
                    row.value = "\(eAverage)"
                }
                <<< LabelRow(){ row in
                    row.hidden = Condition.function(["high"], { form in
                        return !((form.rowBy(tag: "high") as? SwitchRow)?.value ?? false)
                    })
                    row.tag = "oHigh"
                    row.title = "OC"
                    row.value = "\(ocAverage)"
            }
        }
        else{
            showMsgbox(_message: "请先登录！")
        }
    }
    
    static func display(){
        SecondViewController.showIsTrue = true
    }

    //用来实现toast提示框
    func showMsgbox(_message: String, _title: String = "提示"){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
    }
}


