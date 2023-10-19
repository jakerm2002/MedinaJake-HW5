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
    
    var pizzaList:[Pizza] = []
    var CDPizzaList:[NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        populateTempPizzaList()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // when the user clicks the back "Pizza Order" button
    // make sure we get the new data
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaList.count
    }
    
    // generate cells for TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = pizzaList[row].output
        
        return cell
    }
    
    // deselect row once tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // swipe to delete rows from table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            pizzaList.remove(at: indexPath.row) // remove from temp data structure
//            // TODO: remove from core data here!
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
        
        // try this
        if editingStyle == .delete {
            let pizzaToDelete = CDPizzaList[indexPath.row]
            context.delete(pizzaToDelete)
            pizzaList.remove(at: indexPath.row) // remove from temp data structure
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
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
    
    func populateTempPizzaList() {
        CDPizzaList = retrievePizzas()
        pizzaList.removeAll() // should already be empty, but just in case
        for pizza in CDPizzaList {
            pizzaList.append(Pizza(
                pSize: pizza.value(forKey: "pSize") as! String,
                crust: pizza.value(forKey: "crust") as! String,
                cheese: pizza.value(forKey: "cheese") as! String,
                meat: pizza.value(forKey: "meat") as! String,
                veggies: pizza.value(forKey: "veggies") as! String)
            )
        }
        tableView.reloadData()
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
    func storePizza(pizzaObj:Pizza) -> NSManagedObject {
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
        
        return pizza
    }
    
    func addPizza(newPizza: Pizza) {
        pizzaList.append(newPizza)
        let storedPizza = storePizza(pizzaObj: newPizza)
        CDPizzaList.append(storedPizza)
        
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

