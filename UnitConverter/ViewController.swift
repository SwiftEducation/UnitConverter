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
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let row = initialPickerRow()
        celsiusPicker.selectRow(row, inComponent: 0, animated: true)
        pickerView(celsiusPicker, didSelectRow: row, inComponent: 0)
    }

    func initialPickerRow() -> Int {
        let savedRow = NSUserDefaults.standardUserDefaults().objectForKey(userDefaultsLastRowKey) as? Int
        if let row = savedRow  {
            return row
        } else {
            // we have 200 total rows from -100 to +100 so to make middle value 0 selection
            // we have to get half of total row counts i.e. 200 / 2 = 100
            return celsiusPicker.numberOfRowsInComponent(0) / 2
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
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
        let degreesFahrenheit = converter.degreesFahrenheit(degreesCelsius)
        temperatureLabel.text = "\(degreesFahrenheit)°F"
    }

    func saveSelectedRow(row: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(row, forKey: userDefaultsLastRowKey)
        defaults.synchronize()
    }
    
}

