//
//  SettingsViewController.swift
//  Prework
//
//  Created by Cao Mai on 3/27/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTipControl: UISegmentedControl!
    @IBOutlet weak var tipSlider: UISlider!
    var tipPercent = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipSlider.value = 20

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.set(tipPercent, forKey: "TipPercentage")
    }
    
    @IBAction func tipSegmentSelected(_ sender: Any) {
        print(settingsTipControl.selectedSegmentIndex)
        switch settingsTipControl.selectedSegmentIndex {
        case 0:
            tipPercent = 15
        case 1:
            tipPercent = 18
        case 2:
            tipPercent = 20
        default:
            tipPercent = 15
        }
    }
    
    @IBAction func sliderTapped(_ sender: Any) {
        tipPercent = Int(tipSlider.value)
        settingsTipControl.setTitle(String(Int(tipSlider.value))+"%", forSegmentAt: 3)
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
