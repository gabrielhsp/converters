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
            case Measures.temperature.rawValue:
                changeUnitiesTitles(unitTitle: Measures.weight.rawValue, firstUnitTitle: Unities.weightUnitOne.rawValue, secondUnitTitle: Unities.weightUnitTwo.rawValue)
            
            case Measures.weight.rawValue:
                changeUnitiesTitles(unitTitle: Measures.currency.rawValue, firstUnitTitle: Unities.currencyUnitOne.rawValue, secondUnitTitle: Unities.currencyUnitTwo.rawValue)
            
            case Measures.currency.rawValue:
                changeUnitiesTitles(unitTitle: Measures.distance.rawValue, firstUnitTitle: Unities.distanceUnitOne.rawValue, secondUnitTitle: Unities.distanceUnitTwo.rawValue)
            
            default:
                changeUnitiesTitles(unitTitle: Measures.temperature.rawValue, firstUnitTitle: Unities.temperatureUnitOne.rawValue, secondUnitTitle: Unities.temperatureUnitTwo.rawValue)
        }
        
        actionConvert(nil)
    }
    
    @IBAction func actionConvert(_ sender: UIButton?) {
        guard let unit = Double(textFieldValue.text!) else { return }
        
        if let sender = sender {
            if sender == buttonUnitOne {
                buttonUnitTwo.alpha = 0.5
            } else {
                buttonUnitOne.alpha = 0.5
            }
            
            sender.alpha = 1.0
        }
        
        switch labelUnit.text! {
            case Measures.temperature.rawValue:
                calculateUnit(
                    firstUnit: Unities.temperatureUnitTwo.rawValue, secondUnit: Unities.temperatureUnitOne.rawValue,
                    firstCalcule: unit * 1.8 + 32.0, secondCalcule: (unit - 32.0) / 1.8
                )
            
            case Measures.weight.rawValue:
                calculateUnit(
                    firstUnit: Unities.weightUnitTwo.rawValue, secondUnit: Unities.weightUnitOne.rawValue,
                    firstCalcule: unit * 2.2046, secondCalcule: unit / 2.2046
                )
            
            case Measures.currency.rawValue:
                calculateUnit(
                    firstUnit: Unities.currencyUnitTwo.rawValue, secondUnit: Unities.currencyUnitOne.rawValue,
                    firstCalcule: unit * 3.5, secondCalcule: unit / 3.5
                )
        
            default:
                calculateUnit(
                    firstUnit: Unities.distanceUnitTwo.rawValue, secondUnit: Unities.distanceUnitOne.rawValue,
                    firstCalcule: unit / 1000.0, secondCalcule: unit * 1000.0
                )
        }
        
        view.endEditing(true)
        
        let result = Double(labelResult.text!)!
        labelResult.text = String(format: "%.2f", result)
    }
    
    func calculateUnit(firstUnit: String, secondUnit: String, firstCalcule: Double, secondCalcule: Double) {
        if buttonUnitOne.alpha == 1.0 {
            labelResultUnit.text = firstUnit
            labelResult.text = genericCalcule(calculeFormula: firstCalcule)
        } else {
            labelResultUnit.text = secondUnit
            labelResult.text = genericCalcule(calculeFormula: secondCalcule)
        }
    }
    
    func changeUnitiesTitles(unitTitle: String, firstUnitTitle: String, secondUnitTitle: String) {
        labelUnit.text = unitTitle
        buttonUnitOne.setTitle(firstUnitTitle, for: .normal)
        buttonUnitTwo.setTitle(secondUnitTitle, for: .normal)
    }
    
    func genericCalcule(calculeFormula: Double) -> String {
        return String(calculeFormula)
    }
}
