//
//  ViewController.swift
//  TodoAppSwift
//
//  Created by Simon Wilson on 09/02/2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var todoTitleTextField: UITextField!

    @IBOutlet weak var todoTextTextView: UITextView!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveTodoButtonClicked(_ sender: Any) {
        if todoTitleTextField.text == nil {
            
            if todoTitleTextField.text == nil {
                
                alertMessage(title: "Error", message: "title and text cant be blank")
                
            }
                
            } else {
                
                saveToCoreData()
            
        }
    }
    
    @IBAction func gotoListViewClicked(_ sender: Any) {
        performSegue(withIdentifier: "toListViewVC", sender: nil)
    }
    
    func alertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let button = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(button)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveToCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newTodo = NSEntityDescription.insertNewObject(forEntityName: "Todos", into: context)
        
        newTodo.setValue(todoTitleTextField.text!, forKey: "title")
        newTodo.setValue(todoTextTextView.text!, forKey: "text")
        newTodo.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            print("success")
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "newTodo"), object: nil)
            performSegue(withIdentifier: "toListViewVC", sender: nil)
        } catch {
            
            print("Unable to save todo")
            
        }
    }
}

