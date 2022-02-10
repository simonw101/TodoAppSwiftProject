//
//  ListViewController.swift
//  TodoAppSwift
//
//  Created by Simon Wilson on 10/02/2022.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var titleArray = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
    

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableview.dataSource = self
        tableview.delegate = self
        
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newTodo"), object: nil)
    }
    
    @objc func getData() {
        
        titleArray.removeAll(keepingCapacity: true)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todos")
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    if let title = result.value(forKey: "title") as? String {
                        self.titleArray.append(title)
                    }
                    self.tableview.reloadData()
                }
                
                
            }
            
        } catch {
            print("unable to retrieve core data")
        }
        
    }

}
