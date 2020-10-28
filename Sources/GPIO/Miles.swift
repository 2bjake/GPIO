//
//  Miles.swift
//  
//
//  Created by Miles Foster on 9/7/20.
//

import Foundation

private func setupLedDisplay() {
    for i in 0..<8 {
        Pi.gpioPins[i].setup(direction: .out, initialValue: .high)
    }
}

private func displayLedValue(_ displayValue: DisplayValue) {
    for (i, value) in displayValue.segments.values.enumerated() {
        Pi.gpioPins[i].value = value == .on ? .low : .high
    }
}

private func displayCountdown(from: Int, delay: Double = 1, action: ((Int) -> Void)?) {
    for i in (0..<from).reversed() {
        displayLedValue(DisplayValue(i))
        action?(i)
        wait(delay)
    }
}

func runSevenLed() {
    setupLedDisplay()

    func milesCountdown() {
        displayLedValue(.nine)
        wait(1)
        displayLedValue(.eight)
        wait(1)
        displayLedValue(.seven)
        wait(1)
        displayLedValue(.six)
        wait(1)
        displayLedValue(.five)
        wait(1)
        displayLedValue(.four)
        wait(1)
        displayLedValue(.three)
        wait(1)
        displayLedValue(.two)
        wait(1)
        displayLedValue(.one)
        wait(1)
        displayLedValue(.zero)
        wait(1)
        displayLedValue(.blank)
    }
    func milesAlphabet() {
        displayLedValue(.A)
        wait(1)
        displayLedValue(.B)
        wait(1)
        displayLedValue(.C)
        wait(1)
        displayLedValue(.D)
        wait(1)
        displayLedValue(.E)
        wait(1)
        displayLedValue(.F)
    }
    milesCountdown()
}

//runSevenLed()
