//
//  Pizza.swift
//  MedinaJake-HW5
//
//  Created by Jake Medina on 10/9/23.
//
// Project: MedinaJake-HW5
// EID: jrm7784
// Course: CS371L

class Pizza {
    var pSize: String
    var crust: String
    var cheese: String
    var meat: String
    var veggies: String
    var output: String
    
    init(pSize: String, crust: String, cheese: String, meat: String, veggies: String) {
        self.pSize = pSize
        self.crust = crust
        self.cheese = cheese
        self.meat = meat
        self.veggies = veggies
        output = "\(pSize)\n\t\(crust)\n\t\(cheese)\n\t\(meat)\n\t\(veggies)"
    }
}
