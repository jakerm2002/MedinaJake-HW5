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

protocol PizzaAdder {
    func addPizza(newPizza: Pizza)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PizzaAdder {
    
    @IBOutlet weak var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    let pizzaCreationSegueIdentifier = "PizzaCreationSegueIdentifier"
    
    var pizzaList:[Pizza] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = pizzaList[row].output
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == pizzaCreationSegueIdentifier,
           let destination = segue.destination as? PizzaCreationViewController
        {
            print("YES")
            // allow PizzaCreationViewController to change the pizzaList using us
            destination.delegate = self
        }
    }
    
    func addPizza(newPizza: Pizza) {
        print("adding pizaa")
        print("-----------")
        print(newPizza.output)
        print("-----------")
        pizzaList.append(newPizza)
        print(pizzaList)
    }
    

}

