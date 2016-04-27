//
//  ViewController.swift
//  tips
//
//  Created by Franklin Design on 4/25/16.
//  Copyright © 2016 John Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var totalTitleLabel: UILabel!
    @IBOutlet weak var outOfTotalLabel: UILabel!
    
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var splitControl: UISegmentedControl!
    
    @IBOutlet weak var splitView: UIView!
    
    var multiple = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        billLabel.text = "$0.00"
        tipLabel.text = "$0.00"
        tipPercentLabel.text = "(15%)"
        totalLabel.text = "$0.00"
        totalTitleLabel.text = "TOTAL"
        outOfTotalLabel.text = ""
        
        self.splitView.alpha = 0
        self.splitView.frame.origin.y += 10
        self.totalLabel.frame.origin.y += 25
        self.totalTitleLabel.frame.origin.y += 25
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentages = [0.15, 0.18, 0.20]
        let split = [1, 2, 3, 4, 5]
        
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let tipPercent = tipControl.titleForSegmentAtIndex(tipControl.selectedSegmentIndex)!
        let splitNumber = split[splitControl.selectedSegmentIndex]
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        let splitAmount = total / Double(splitNumber)
        
        billLabel.text = "$\(billAmount)"
        tipLabel.text = "$\(tip)"
        tipPercentLabel.text = "(\(tipPercent))"
        
        billLabel.text = String(format: "$%.2f", billAmount)
        tipLabel.text = String(format: "$%.2f", tip)
        
        if splitNumber == 1 {
            totalLabel.text = "$\(total)"
            totalLabel.text = String(format: "$%.2f", total)
            outOfTotalLabel.text = ""
            UIView.animateWithDuration(0.4, animations: {
                self.splitView.alpha = 0
                if self.multiple {
                    self.totalLabel.frame.origin.y += 25
                    self.totalTitleLabel.frame.origin.y += 25
                    self.splitView.frame.origin.y += 10
                }
            })
            multiple = false
        }
        else {
            totalLabel.text = "$\(splitAmount)"
            totalLabel.text = String(format: "$%.2f", splitAmount)
            outOfTotalLabel.text = "\(String(format: "$%.2f", total)) TOTAL (SPLIT BY \(splitNumber))"
            UIView.animateWithDuration(0.4, animations: {
                if !self.multiple {
                    self.totalLabel.frame.origin.y -= 25
                    self.totalTitleLabel.frame.origin.y -= 25
                    self.splitView.frame.origin.y -= 10
                }
                self.splitView.alpha = 1
            })
            multiple = true
        }
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

