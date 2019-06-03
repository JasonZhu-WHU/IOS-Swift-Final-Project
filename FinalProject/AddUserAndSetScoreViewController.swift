//
//  AddUserAndSetScoreViewController.swift
//  FinalProject
//
//  Created by zhujie on 2019/5/31.
//  Copyright © 2019 zhujie. All rights reserved.
//

import UIKit
import CoreData
import Eureka

class AddUserAndSetScoreViewController: FormViewController {
    
    @IBOutlet weak var back_btn: UIButton!
    @IBOutlet weak var addUser_btn: UIButton!
    @IBOutlet weak var setScore_btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(back_btn)
        self.view.addSubview(addUser_btn)
        self.view.addSubview(setScore_btn)
        
        form +++ Section()
        form +++ Section()
        
        form +++ Section("添加用户/老师")
            <<< TextRow(){row in
                row.tag = "name"
                row.title = "用户名"
                row.placeholder = "name"
            }
            <<< TextRow(){row in
                row.tag = "password"
                row.title = "密码"
                row.placeholder = "password"
        }
        
        form +++ Section()
        form +++ Section()
        form +++ Section()
        
        form +++ Section("设定学生分数")
            <<< TextRow(){row in
                row.tag = "studentName"
                row.title = "学生名"
                row.placeholder = "name"
            }
            <<< TextRow(){row in
                row.tag = "chinese"
                row.title = "语文"
                row.placeholder = "score"
            }
            <<< TextRow(){row in
                row.tag = "math"
                row.title = "数学"
                row.placeholder = "score"
            }
            <<< TextRow(){row in
                row.tag = "english"
                row.title = "英语"
                row.placeholder = "score"
            }
            <<< TextRow(){row in
                row.tag = "oc"
                row.title = "OC"
                row.placeholder = "score"
            }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back_clicked(_ sender: Any) {
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    //添加新用户/老师
    @IBAction func addUser_clicked(_ sender: Any) {
        // 获取表格中所有rows的值(必须给每个row的tag赋值)
        // 字典中包含的键值对为：['rowTag': value]。
        let valuesDictionary = form.values()
        let username = valuesDictionary["name"]
        let password = valuesDictionary["password"]
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.managedObjectContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
        print(username!!)
        print(password!!)
        
        newUser.setValue(username ?? "default name", forKey: "name")
        newUser.setValue(password ?? "not available", forKey: "password")
        appDel.saveContext()
        showMsgbox(_message: "您已成功添加新用户！")
    }
    
    @IBAction func setScore_clicked(_ sender: Any) {
        // 获取表格中所有rows的值(必须给每个row的tag赋值)
        // 字典中包含的键值对为：['rowTag': value]。
        let valuesDictionary = form.values()
        let studentName = valuesDictionary["studentName"]
        let chinese = valuesDictionary["chinese"]
        let math = valuesDictionary["math"]
        let english = valuesDictionary["english"]
        let oc = valuesDictionary["oc"]
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.managedObjectContext
        let newScore = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context) as! Score
        print(studentName!!)
        print(chinese as Any)
        
        newScore.setValue(studentName ?? "default name", forKey: "name")
        newScore.setValue(chinese ?? "default name", forKey: "chinese")
        newScore.setValue(math ?? "math", forKey: "math")
        newScore.setValue(english ?? "default english", forKey: "english")
        newScore.setValue(oc ?? "not available", forKey: "oc")
        appDel.saveContext()
        showMsgbox(_message: "您已成功设定分数！")
    }
    
    
    //用来实现toast提示框
    func showMsgbox(_message: String, _title: String = "提示"){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
    }

}
