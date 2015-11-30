/*

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike
4.0 International License, by Yong Bakos.

*/

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate {

    let userDefaultsLastRowKey = "defaultCelsiusPickerRow"
    
    @IBOutlet var temperatureRange: TemperatureRange!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var celsiusPicker: UIPickerView!
    
    private let converter = UnitConverter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let row = initialPickerRow()
        celsiusPicker.selectRow(row, inComponent: 0, animated: false)
        pickerView(celsiusPicker, didSelectRow: row, inComponent: 0)
    }

    func initialPickerRow() -> Int {
        let savedRow = NSUserDefaults.standardUserDefaults().objectForKey(userDefaultsLastRowKey) as? Int
        if let row = savedRow  {
            return row
        } else {
            return celsiusPicker.numberOfRowsInComponent(0) / 2
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let celsiusValue = temperatureRange.values[row]
        return "\(celsiusValue)°C"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int,
        inComponent component: Int) {
        displayConvertedTemperatureForRow(row)
        saveSelectedRow(row)
    }
    
    func displayConvertedTemperatureForRow(row: Int) {
        let degreesCelsius = temperatureRange.values[row]
        temperatureLabel.text = "\(converter.degreesFahrenheit(degreesCelsius))°F"
    }

    func saveSelectedRow(row: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(row, forKey: userDefaultsLastRowKey)
        defaults.synchronize()
    }
    
}

