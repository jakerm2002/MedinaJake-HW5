//
//  ViewController.swift
//  MedinaJake-HW5
//
//  Created by Jake Medina on 10/8/23.
//
// Project: MedinaJake-HW5
// EID: jrm7784
// Course: CS371L

import UIKit
import CoreData
import FirebaseAuth

// implemented by this, used by PizzaCreationVC
protocol PizzaAdder {
    func addPizza(newPizza: Pizza)
}

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PizzaAdder {
    
    @IBOutlet weak var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    let pizzaCreationSegueIdentifier = "PizzaCreationSegueIdentifier"
    
//    var pizzaList:[Pizza] = []
    var CDPizzaList:[NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // when the user clicks the back "Pizza Order" button
    // make sure we get the new data
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return pizzaList.count
        return CDPizzaList.count
    }
    
    // generate cells for TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        
        let row = indexPath.row
//        cell.textLabel?.text = pizzaList[row].output
        if let output = CDPizzaList[row].value(forKey: "output") {
            cell.textLabel?.text = output as? String
        }
        
        return cell
    }
    
    // deselect row once tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == pizzaCreationSegueIdentifier,
           let destination = segue.destination as? PizzaCreationViewController
        {
            // allow PizzaCreationViewController to change the pizzaList using us
            destination.delegate = self
        }
    }
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // get me an array of pizzas
    func retrievePizzas() -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CDPizza")
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
        } catch {
            print("Error occurred while retrieving data")
            abort()
        }
        
        return(fetchedResults)!
    }
    
    // store into core data
    func storePizza(pizzaObj:Pizza) {
        let pizza = NSEntityDescription.insertNewObject(
            forEntityName: "CDPizza",
            into: context)

        pizza.setValue(pizzaObj.pSize, forKey: "pSize")
        pizza.setValue(pizzaObj.crust, forKey: "crust")
        pizza.setValue(pizzaObj.cheese, forKey: "cheese")
        pizza.setValue(pizzaObj.meat, forKey: "meat")
        pizza.setValue(pizzaObj.veggies, forKey: "veggies")
        pizza.setValue(pizzaObj.output, forKey: "output")
        
        // commit the changes
        saveContext()
    }
    
    func addPizza(newPizza: Pizza) {
//        pizzaList.append(newPizza) // old non-CD
        
        storePizza(pizzaObj: newPizza)
        CDPizzaList = retrievePizzas()
    }
    
    @IBAction func signoutButtonPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true)
        } catch {
            print("Sign out error")
        }
    }
    

}

