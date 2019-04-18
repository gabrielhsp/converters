//
//  ViewController.swift
//  Converters
//
//  Created by Gabriel Henrique Santos Pereira on 17/04/19.
//  Copyright © 2019 Gabriel Henrique Santos Pereira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textFieldValue: UITextField!
    @IBOutlet weak var buttonUnitOne: UIButton!
    @IBOutlet weak var buttonUnitTwo: UIButton!
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var labelResultUnit: UILabel!
    @IBOutlet weak var labelUnit: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionShowNext(_ sender: UIButton) {
        switch labelUnit.text! {
            case Measures.weight.rawValue:
                changeUnitiesTitles(unitTitle: Measures.weight.rawValue, firstUnitTitle: "Kilograma", secondUnitTitle: "Libra")
            
            case "Peso":
                changeUnitiesTitles(unitTitle: Measures.currency.rawValue, firstUnitTitle: "Real", secondUnitTitle: "Dólar")
            
            case "Moeda":
                changeUnitiesTitles(unitTitle: Measures.distance.rawValue, firstUnitTitle: "Metro", secondUnitTitle: "Kilômetro")
            
            default:
                changeUnitiesTitles(unitTitle: Measures.temperature.rawValue, firstUnitTitle: "Celsius", secondUnitTitle: "Fahrenheit")
        }
        
        actionConvert(nil)
    }
    
    @IBAction func actionConvert(_ sender: UIButton?) {
        if let sender = sender {
            if sender == buttonUnitOne {
                buttonUnitTwo.alpha = 0.5
            } else {
                buttonUnitOne.alpha = 0.5
            }
            
            sender.alpha = 1.0
        }
        
        switch labelUnit.text! {
            case "Temperatura":
                calculateTemperature()
            
            case "Peso":
                calculateWeight()
            
            case "Moeda":
                calculateCurrency()
        
            default:
                calculateDistance()
        }
        
        view.endEditing(true)
        
        let result = Double(labelResult.text!)!
        labelResult.text = String(format: "%.2f", result)
    }
    
    func calculateTemperature() {
        guard let temperature = Double(textFieldValue.text!) else { return }
        
        if buttonUnitOne.alpha == 1.0 {
            labelResultUnit.text = "Fahrenheit"
            labelResult.text = String(temperature * 1.8 + 32.0)
        } else {
            labelResultUnit.text = "Celsius"
            labelResult.text = String((temperature - 32.0) / 1.8)
        }
    }
    
    func calculateWeight() {
        guard let weight = Double(textFieldValue.text!) else { return }
        
        if buttonUnitOne.alpha == 1.0 {
            labelResultUnit.text = "Libra"
            labelResult.text = String(weight / 2.2046)
        } else {
            labelResultUnit.text = "Kilograma"
            labelResult.text = String(weight * 2.2046)
        }
    }
    
    func calculateCurrency() {
        guard let currency = Double(textFieldValue.text!) else { return }
        
        if buttonUnitOne.alpha == 1.0 {
            labelResultUnit.text = "Dólar"
            labelResult.text = String(currency / 3.5)
        } else {
            labelResultUnit.text = "Real"
            labelResult.text = String(currency * 3.5)
        }
    }
    
    func calculateDistance() {
        guard let distance = Double(textFieldValue.text!) else { return }
        
        if buttonUnitOne.alpha == 1.0 {
            labelResultUnit.text = "Kilômetro"
            labelResult.text = String(distance / 1000.0)
        } else {
            labelResultUnit.text = "Metros"
            labelResult.text = String(distance * 1000.0)
        }
    }
    
    func changeUnitiesTitles(unitTitle: String, firstUnitTitle: String, secondUnitTitle: String) {
        labelUnit.text = unitTitle
        buttonUnitOne.setTitle(firstUnitTitle, for: .normal)
        buttonUnitTwo.setTitle(secondUnitTitle, for: .normal)
    }
}
