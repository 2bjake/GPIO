//
//  SevenSegmentDisplay.swift
//
//
//  Created by Jake Foster on 9/7/20.
//

import Foundation
import SwiftyGPIO

// drives a common anode seven segment LED display where each segment is wired to a GPIO pin.
struct SevenSegmentDisplay {

    private let pins: [GPIO]

    init(pins: [GPIO]) {
        assert(pins.count == 8, "exactly 8 pins must be specified")
        self.pins = pins
    }

    func setup() {
        for pin in pins {
            pin.setup(direction: .out, initialValue: .high)
        }
    }

    func displayValue(_ displayValue: DisplayValue) {
        for (i, value) in displayValue.segments.values.enumerated() {
            pins[i].value = value == .on ? .low : .high
        }
    }

    func displayCountdown(from: Int, delay: Double = 1, action: ((Int) -> Void)?) {
        for i in (0...from).reversed() {
            displayValue(DisplayValue(i))
            action?(i)
            wait(delay)
        }
    }
    
}
