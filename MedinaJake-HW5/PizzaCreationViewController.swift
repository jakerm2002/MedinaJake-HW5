//
//  PizzaCreationViewController.swift
//  MedinaJake-HW5
//
//  Created by Jake Medina on 10/8/23.
//
// Project: MedinaJake-HW5
// EID: jrm7784
// Course: CS371L

import UIKit

class PizzaCreationViewController: UIViewController {

    @IBOutlet weak var sizeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var confirmationLabel: UILabel!
    
    var delegate: UIViewController?
    var size = "small" // ensure default pizza size
    var crustType = ""
    var cheeseType = ""
    var meatType = ""
    var veggiesType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmationLabel.numberOfLines = 0 // allow for newline chars in text
        confirmationLabel.text = ""
    }
    
    @IBAction func onSegmentChanged(_ sender: Any) {
        switch sizeSegmentedControl.selectedSegmentIndex {
        case 0:
            size = "small"
        case 1:
            size = "medium"
        case 2:
            size = "large"
        default:
            break
        }
    }
    
    @IBAction func crustButtonPressed(_ sender: Any) {
        // set our string variables using the selected option
        func setCrustType(_ type: String) {
            self.crustType = type.lowercased()
        }
        
        let alert = UIAlertController(title: "Select crust", message: "Choose a crust type", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Thin crust", style: .default) {
            (action) in
            setCrustType(action.title!)
        })
        alert.addAction(UIAlertAction(title: "Thick crust", style: .default) {
            (action) in
            setCrustType(action.title!)
        })
        present(alert, animated: true)
    }
    
    @IBAction func cheeseButtonPressed(_ sender: Any) {
        func setCheeseType(_ type: String) {
            self.cheeseType = type.lowercased()
        }
        
        let alert = UIAlertController(title: "Select cheese", message: "Choose a cheese type:", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Regular cheese", style: .default) {
            (action) in
            setCheeseType(action.title!)
        })
        alert.addAction(UIAlertAction(title: "No cheese", style: .default) {
            (action) in
            setCheeseType(action.title!)
        })
        alert.addAction(UIAlertAction(title: "Double cheese", style: .default) {
            (action) in
            setCheeseType(action.title!)
        })
        present(alert, animated: true)
    }
    
    @IBAction func meatButtonPressed(_ sender: Any) {
        func setMeatType(_ type: String) {
            self.meatType = type.lowercased()
        }
        
        let alert = UIAlertController(title: "Select meat", message: "Choose one meat:", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Pepperoni", style: .default) {
            (action) in
            setMeatType(action.title!)
        })
        alert.addAction(UIAlertAction(title: "Sausage", style: .default) {
            (action) in
            setMeatType(action.title!)
        })
        alert.addAction(UIAlertAction(title: "Canadian Bacon", style: .default) {
            (action) in
            setMeatType(action.title!)
        })
        present(alert, animated: true)
    }
    
    @IBAction func veggieButtonPressed(_ sender: Any) {
        func setVeggiesType(_ type: String) {
            self.veggiesType = type.lowercased()
        }
        
        let alert = UIAlertController(title: "Select veggies", message: "Choose your veggies:", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Mushroom", style: .default) {
            (action) in
            setVeggiesType(action.title!)
        })
        alert.addAction(UIAlertAction(title: "Onion", style: .default) {
            (action) in
            setVeggiesType(action.title!)
        })
        alert.addAction(UIAlertAction(title: "Green Olive", style: .default) {
            (action) in
            setVeggiesType(action.title!)
        })
        alert.addAction(UIAlertAction(title: "Black Olive", style: .default) {
            (action) in
            setVeggiesType(action.title!)
        })
        alert.addAction(UIAlertAction(title: "None", style: .default) {
            (action) in
            setVeggiesType(action.title!)
        })
        present(alert, animated: true)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        // check for missing ingredients
        if (crustType.isEmpty || cheeseType.isEmpty || meatType.isEmpty || veggiesType.isEmpty) {
            var missing:[String] = [] // array for printing missing ingredients
            if crustType.isEmpty {
                missing.append("crust")
            }
            if cheeseType.isEmpty {
                missing.append("cheese")
            }
            if meatType.isEmpty {
                missing.append("meat")
            }
            if veggiesType.isEmpty {
                missing.append("veggies")
            }
            let alert = UIAlertController(title: "Missing ingredient(s)", message: "Please select a \(missing.joined(separator: " & ")) type.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            
        } else {
            let newPizza = Pizza(pSize: size, crust: crustType, cheese: cheeseType, meat: meatType, veggies: veggiesType)
            // format and display the confirmation label
            confirmationLabel.text = "One \(size) pizza with:\n\t\(crustType)\n\t\(cheeseType)\n\t\(meatType)\n\t\(veggiesType)"
            // utilize mainVC PizzaAdder protocol to add to the pizzaList array
            let mainVC = delegate as! PizzaAdder
            mainVC.addPizza(newPizza: newPizza)
        }

    }
    
}
