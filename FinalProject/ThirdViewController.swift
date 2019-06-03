//
//  ThirdViewController.swift
//  FinalProject
//
//  Created by zhujie on 2019/5/29.
//  Copyright © 2019 zhujie. All rights reserved.
//

import UIKit
import CoreData
import Eureka

class ThirdViewController: FormViewController {

    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var login_btn: UIButton!
    @IBOutlet weak var HelloLabel: UILabel!
    @IBOutlet weak var HelloImage: UIImageView!
    @IBOutlet weak var addStudent_btn: UIButton!
    @IBOutlet weak var setScore_btn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(UserImage)
        self.view.addSubview(login_btn)
        
        
        for _ in 0...3 {
            form +++ Section()
        }
        
        form +++ Section("")
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
        // Do any additional setup after loading the view.
    }
    
    //点击登陆
    @IBAction func login_clicked(_ sender: Any) {
        let valuesDictionary = form.values()
        let username :String = valuesDictionary["name"] as! String
        let password :String = valuesDictionary["password"] as! String
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "name = %@", username)
        let users = try! context.fetch(fetchRequest) as! [User]
        print(username)
        print(password)
        if(users.count == 0){
            showMsgbox(_message: "登录失败，用户名不正确，请重新输入！")
            return
        }
        else{
            if(users[0].password == password){
                display(username: username)
                FirstViewController.display()
                SecondViewController.display()
                showMsgbox(_message: "登录成功，\(username)，欢迎您！")
            }
            else{
                showMsgbox(_message: "登录失败，密码不正确，请重新输入！")
            }
        }
    }
    
    func display(username: String){
        HelloLabel.text = "Hello, \(username)！"
        self.view.addSubview(HelloLabel)
        self.view.addSubview(HelloImage)
        self.view.addSubview(addStudent_btn)
        self.view.addSubview(setScore_btn)
    }
    
    //用来实现toast提示框
    func showMsgbox(_message: String, _title: String = "提示"){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
    }
}
