/*

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike
4.0 International License, by Yong Bakos.

*/

import Foundation

class UnitConverter {
    
    func degreesFahrenheit(degreesCelsius: Int) -> Float {
        return Float(1.8 * Float(degreesCelsius) + 32.0)
    }
    
}