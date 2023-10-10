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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func crustButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Select crust", message: "Choose a crust type", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Thin crust", style: .default))
        alert.addAction(UIAlertAction(title: "Thick crust", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func cheeseButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Select cheese", message: "Choose a cheese type:", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Regular cheese", style: .default))
        alert.addAction(UIAlertAction(title: "No cheese", style: .default))
        alert.addAction(UIAlertAction(title: "Double cheese", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func meatButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Select meat", message: "Choose one meat:", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Pepperoni", style: .default))
        alert.addAction(UIAlertAction(title: "Sausage", style: .default))
        alert.addAction(UIAlertAction(title: "Canadian Bacon", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func veggieButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Select veggies", message: "Choose your veggies:", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Mushroom", style: .default))
        alert.addAction(UIAlertAction(title: "Onion", style: .default))
        alert.addAction(UIAlertAction(title: "Green Olive", style: .default))
        alert.addAction(UIAlertAction(title: "Black Olive", style: .default))
        alert.addAction(UIAlertAction(title: "None", style: .default))
        present(alert, animated: true)
    }
    
    
}
