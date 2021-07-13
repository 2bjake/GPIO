//
//  LightManager.swift
//  
//
//  Created by Miles Foster on 7/12/21.
//

import SwiftyGPIO

class LightManager {
    init(lightPins: [Color : GPIO]) {
        self.lightPins = lightPins
    }

    var lightPins: [Color: GPIO]
    var isLightOn = false

    func buttonPressed(color: Color) {
        if isLightOn {
            return
        }
        isLightOn = true
        let pin = lightPins[color]!
        pin.value = .low
        waitForSeconds(1)
        pin.value = .high
        isLightOn = false
    }

    func flashAllLights() {
        isLightOn = true

        lightPins.values.forEach {
            $0.value = .high
        }

        for _ in 1...10 {
            lightPins.values.forEach {
                $0.toggleValue()
            }
            waitForSeconds(0.1)
        }
        isLightOn = false
    }
}
