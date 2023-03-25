//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }

    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    // How many columns we want in our picker - has return
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // How many rows we want in our picker - has return
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    // What happens when we select a row - has return
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
    
    // What the title of the row is going to be - has return
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }

}
