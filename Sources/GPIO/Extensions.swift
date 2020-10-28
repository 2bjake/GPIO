//
//  Extensions.swift
//
//
//  Created by Jake Foster on 9/7/20.
//

import SwiftyGPIO

struct Pi {
    static private let gpios = SwiftyGPIO.GPIOs(for:.RaspberryPi3)

    static let gpioPinNumbers = [GPIOName.P4, .P5, .P6, .P12, .P13, .P16, .P17, .P18, .P19, .P20, .P21, .P22, .P23, .P24, .P25, .P26, .P27]

    static var gpioPins: [GPIO] = gpioPinNumbers.map { gpios[$0]! }

    static var gpio4: GPIO { gpioPins[0] }
    static var gpio5: GPIO { gpioPins[1] }
    static var gpio6: GPIO { gpioPins[2] }
    static var gpio12: GPIO { gpioPins[3] }
    static var gpio13: GPIO { gpioPins[4] }
    static var gpio16: GPIO { gpioPins[5] }
    static var gpio17: GPIO { gpioPins[6] }
    static var gpio18: GPIO { gpioPins[7] }
    static var gpio19: GPIO { gpioPins[8] }
    static var gpio20: GPIO { gpioPins[9] }
    static var gpio21: GPIO { gpioPins[10] }
    static var gpio22: GPIO { gpioPins[11] }
    static var gpio23: GPIO { gpioPins[12] }
    static var gpio24: GPIO { gpioPins[13] }
    static var gpio25: GPIO { gpioPins[14] }
    static var gpio26: GPIO { gpioPins[15] }
    static var gpio27: GPIO { gpioPins[16] }
}

extension Int {
    static let low = 0
    static let high = 1
}

extension GPIODirection {
    static var `in` = Self.IN
    static var out = Self.OUT
}

extension GPIO {
    @discardableResult
    func setup(direction: GPIODirection, initialValue: Int? = nil) -> GPIO {
        self.direction = direction
        if let initialValue = initialValue {
            self.value = initialValue
        }
        return self
    }
}

extension GPIO {
    func toggleValue() {
        value = (value + 1) % 2
    }
}
