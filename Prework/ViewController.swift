//
//  ViewController.swift
//  Prework
//
//  Created by Cao Mai on 3/27/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var partySizeLabel: UILabel!
    @IBOutlet weak var grandTotalLabel: UILabel!
    
    @IBOutlet weak var grandTotalStaticLabel: UILabel!
    var tipPercent = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tip Calculator"
        billAmountTextField.delegate = self
        billAmountTextField.becomeFirstResponder()
        billAmountTextField.keyboardType = .numberPad
        
        billAmountTextField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)),
                                  for: .editingChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async { [self] in
            if let prevTotal = UserDefaults.standard.string(forKey: "BillTotal") {
                grandTotalLabel.text = prevTotal
                grandTotalStaticLabel.text = "Grand Total (Prev)"
                
            }
            

        }
        
        tipPercent = UserDefaults.standard.integer(forKey: "TipPercentage")
        if tipPercent > 0 {
            tipControl.setTitle(String(tipPercent)+"%", forSegmentAt: 3)
        } else {
            tipControl.setTitle("Custom %", forSegmentAt: 3)

        }

        switch tipPercent {
        case 15:
            tipControl.selectedSegmentIndex = 0
        case 18:
            tipControl.selectedSegmentIndex = 1
        case 20:
            tipControl.selectedSegmentIndex = 2
        default:
            tipControl.selectedSegmentIndex = 0

        }
        getTotalAmount()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(grandTotalLabel.text, forKey: "BillTotal")
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        getTotalAmount()
    }
    
    @IBAction func partySizeTapped(_ sender: UIStepper) {
        sender.value > 0 ? (partySizeLabel.text = String(Int(sender.value))) : (partySizeLabel.text = "1")
        getTotalAmount()
        
    }
    
    func getTotalAmount() {
        // Get bill amount from user input
        let bill = Double(billAmountTextField.text!) ?? 0
        
        // Get tip amount by multiplying tip * tipPercentage
        let tipPercentages = [0.15, 0.18, 0.2, Double(tipPercent) * 0.01]
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        
        let partySizeInt = Double(partySizeLabel.text!)
        let total = (bill + tip)
        let totalPerPerson = total / partySizeInt!
        
        // Update tip amount
        tipAmountLabel.text = String(format: "$%.2f", tip)
        // Update Total amount
        totalLabel.text = String(format: "$%.2f", totalPerPerson)
        grandTotalLabel.text = String(format: "$%.2f", total)
    }
    
//    @IBAction func tipInputTapped(_ sender: Any) {
//    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        getTotalAmount()

    }

}


extension UIViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
