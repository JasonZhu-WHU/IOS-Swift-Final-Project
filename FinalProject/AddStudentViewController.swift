//
//  AddStudentViewController.swift
//  FinalProject
//
//  Created by zhujie on 2019/5/29.
//  Copyright © 2019 zhujie. All rights reserved.
//

import UIKit
import CoreData
import Eureka

class AddStudentViewController: FormViewController {

    @IBOutlet weak var back_btn: UIButton!
    
    @IBOutlet weak var submit_btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(back_btn)
        self.view.addSubview(submit_btn)
        
        //这里使用了一个第三方的组件库——用来美化文本框
        //Eureka 一个专门美化表单的组件库
        
        form +++ Section("基本信息：")
            <<< TextRow(){ row in
                row.tag = "姓名"
                row.title = "姓名"
                row.placeholder = "输入你的姓名"
            }
            <<< TextRow(){ row in
                row.tag = "学号"
                row.title = "学号"
                row.placeholder = "学号"
            }
            <<< TextRow(){ row in
                row.tag = "年级"
                row.title = "年级"
                row.placeholder = "年级"
            }
            <<< TextRow(){ row in
                row.tag = "学院和专业"
                row.title = "学院和专业"
                row.placeholder = "学院和专业"
            }
            
            +++ Section("个人信息：")
            <<< TextRow(){ row in
                row.tag = "身份证号"
                row.title = "身份证号"
                row.placeholder = "输入你的身份证号"
            }
            <<< TextRow(){ row in
                row.tag = "籍贯"
                row.title = "籍贯"
                row.placeholder = "籍贯"
            }
            <<< PhoneRow(){ row in
                row.tag = "电话"
                row.title = "电话"
                row.placeholder = "电话号码"
            }
            <<< EmailRow(){ row in
                row.tag = "电子邮箱"
                row.title = "电子邮箱"
                row.placeholder = "email"
        }
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func back_btn_clicked(_ sender: Any) {
         self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func submit_btn_clicked(_ sender: Any) {
        
        // 获取表格中所有rows的值(必须给每个row的tag赋值)
        // 字典中包含的键值对为：['rowTag': value]。
        let valuesDictionary = form.values()
        let name = valuesDictionary["姓名"]
        let studentID = valuesDictionary["学号"]
        let grade = valuesDictionary["年级"]
        let major = valuesDictionary["学院和专业"]
        let citizenID = valuesDictionary["身份证号"]
        let hometown = valuesDictionary["籍贯"]
        let phoneNumber = valuesDictionary["电话"]
        let email = valuesDictionary["电子邮箱"]
        
        print(name as Any)
        print(studentID as Any)
        print(major as Any)
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.managedObjectContext
        let newstudent = NSEntityDescription.insertNewObject(forEntityName: "StudentInfo", into: context) as! StudentInfo
        newstudent.setValue(name ?? "default name", forKey: "name")
        newstudent.setValue(studentID ?? "not available", forKey: "studentID")
        newstudent.setValue(grade ?? "not available", forKey: "grade")
        newstudent.setValue(major ?? "not available", forKey: "major")
        newstudent.setValue(citizenID ?? "default", forKey: "citizenID")
        newstudent.setValue(hometown ?? "default", forKey: "hometown")
        newstudent.setValue(phoneNumber ?? "default", forKey: "phoneNumber")
        newstudent.setValue(email ?? "default", forKey: "email")
        appDel.saveContext()
        
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
