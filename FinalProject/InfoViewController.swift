//
//  InfoViewController.swift
//  FinalProject
//
//  Created by zhujie on 2019/5/31.
//  Copyright © 2019 zhujie. All rights reserved.
//

import UIKit
import CoreData
import Eureka

class InfoViewController: FormViewController {

    @IBOutlet weak var back_btn: UIButton!
    
    @IBOutlet weak var modify_btn: UIButton!
    
    @IBOutlet weak var delete_btn: UIButton!
    
    //存放传来的学生详细信息
    var item :Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(back_btn)
        self.view.addSubview(modify_btn)
        self.view.addSubview(delete_btn)
        
        //这里使用了一个第三方的组件库——用来美化文本框
        //Eureka 一个专门美化表单的组件库
        
        form +++ Section("基本信息：")
            <<< TextRow(){ row in
                row.tag = "姓名"
                row.title = "姓名"
                row.value = (item as! NSManagedObject).value(forKey: "name") as? String
            }
            <<< TextRow(){ row in
                row.tag = "学号"
                row.title = "学号"
                row.value = (item as! NSManagedObject).value(forKey: "studentID") as? String
            }
            <<< TextRow(){ row in
                row.tag = "年级"
                row.title = "年级"
                row.value = (item as! NSManagedObject).value(forKey: "grade") as? String
            }
            <<< TextRow(){ row in
                row.tag = "学院和专业"
                row.title = "学院和专业"
                row.value = (item as! NSManagedObject).value(forKey: "major") as? String
            }
            
            +++ Section("个人信息：")
            <<< TextRow(){ row in
                row.tag = "身份证号"
                row.title = "身份证号"
                row.value = (item as! NSManagedObject).value(forKey: "citizenID") as? String
            }
            <<< TextRow(){ row in
                row.tag = "籍贯"
                row.title = "籍贯"
                row.value = (item as! NSManagedObject).value(forKey: "hometown") as? String
            }
            <<< PhoneRow(){ row in
                row.tag = "电话"
                row.title = "电话"
                row.value = (item as! NSManagedObject).value(forKey: "phoneNumber") as? String
            }
            <<< EmailRow(){ row in
                row.tag = "电子邮箱"
                row.title = "电子邮箱"
                row.value = (item as! NSManagedObject).value(forKey: "email") as? String
        }
        
        print("开始加载infoview")
        print((item as! NSManagedObject).value(forKey: "name") as! String)
        print((item as! NSManagedObject).value(forKey: "grade") as! String)
        print((item as! NSManagedObject).value(forKey: "major") as! String)
        // Do any additional setup after loading the view.
    }

    //返回
    @IBAction func back_clicked(_ sender: Any) {
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    //更改
    @IBAction func modify_clicked(_ sender: Any) {
        
        // 获取表格中所有rows的值(必须给每个row的tag赋值)
        // 字典中包含的键值对为：['rowTag': value]。
        let valuesDictionary = form.values()
        let name: String = valuesDictionary["姓名"] as! String
        let studentID: String = valuesDictionary["学号"] as! String
        let grade: String = valuesDictionary["年级"] as! String
        let major: String = valuesDictionary["学院和专业"] as! String
        let citizenID: String = valuesDictionary["身份证号"] as! String
        let hometown: String = valuesDictionary["籍贯"] as! String
        let phoneNumber: String = valuesDictionary["电话"] as! String
        let email: String = valuesDictionary["电子邮箱"] as! String
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StudentInfo")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        let students = try! context.fetch(fetchRequest) as! [StudentInfo]

        // 遍历所有实体，修改 name 属性
        for student in students {
            student.setValue(studentID , forKey: "studentID")
            student.setValue(grade , forKey: "grade")
            student.setValue(major , forKey: "major")
            student.setValue(citizenID , forKey: "citizenID")
            student.setValue(hometown , forKey: "hometown")
            student.setValue(phoneNumber , forKey: "phoneNumber")
            student.setValue(email , forKey: "email")
        }
        appDel.saveContext()
        showMsgbox(_message: "该同学信息修改已完成！")
    }
    
    //删除
    @IBAction func delete_clicked(_ sender: Any) {
        let valuesDictionary = form.values()
        let name: String = valuesDictionary["姓名"] as! String
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StudentInfo")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        let students = try! context.fetch(fetchRequest) as! [StudentInfo]
        do
        {
            let studentToDelete = students[0] as NSManagedObject
            context.delete(studentToDelete)
            try context.save()
        }
        catch
        {
            print(error)
        }
        
        showMsgbox(_message: "您已成功删除该同学的信息！")
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    //用来实现toast提示框
    func showMsgbox(_message: String, _title: String = "提示"){
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
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
