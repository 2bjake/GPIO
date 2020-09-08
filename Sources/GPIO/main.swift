import Foundation
import SwiftyGPIO

struct Pi {
    static private let gpios = SwiftyGPIO.GPIOs(for:.RaspberryPi3)

    static var gpio4: GPIO { gpios[.P4]! }
    static var gpio5: GPIO { gpios[.P5]! }
    static var gpio6: GPIO { gpios[.P6]! }
    static var gpio12: GPIO { gpios[.P12]! }
    static var gpio13: GPIO { gpios[.P13]! }
    static var gpio16: GPIO { gpios[.P16]! }
    static var gpio17: GPIO { gpios[.P17]! }
    static var gpio18: GPIO { gpios[.P18]! }
    static var gpio19: GPIO { gpios[.P19]! }
    static var gpio20: GPIO { gpios[.P20]! }
    static var gpio21: GPIO { gpios[.P21]! }
    static var gpio22: GPIO { gpios[.P22]! }
    static var gpio23: GPIO { gpios[.P23]! }
    static var gpio24: GPIO { gpios[.P24]! }
    static var gpio25: GPIO { gpios[.P25]! }
    static var gpio26: GPIO { gpios[.P26]! }
    static var gpio27: GPIO { gpios[.P27]! }

    static var pins: [GPIO] = [gpio4, gpio5, gpio6, gpio12, gpio13, gpio16, gpio17, gpio18, gpio19, gpio20, gpio21, gpio22, gpio23, gpio24, gpio25, gpio26, gpio27]
}

extension Int {
    static let low = 0
    static let high = 1
}

extension Bool {
    static let on = true
    static let off = false
}

extension GPIO {
    var boolValue: Bool {
        get { value != 0 }
        set { value = newValue ? .high : .low }
    }
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

func sleep(_ seconds: Double) {
    Thread.sleep(forTimeInterval: seconds)
}

func blinkLed() {
    Pi.gpio17.setup(direction: .OUT, initialValue: .high)

    while true {
        Pi.gpio4.boolValue.toggle()
        sleep(0.5)
    }
}

struct DisplaySegments {
    var top: Bool = .off
    var middle: Bool = .off
    var bottom: Bool = .off
    var upperLeft: Bool = .off
    var upperRight: Bool = .off
    var lowerLeft: Bool = .off
    var lowerRight: Bool = .off
    var decimal: Bool = .off

    var values: [Bool] { [top, upperRight, lowerRight, bottom, lowerLeft, upperLeft, middle, decimal] }
}

enum DisplayValue: Hashable {
    case blank, zero, one, two, three, four, five, six, seven, eight, nine, A, B, C, D, E, F
}

extension DisplayValue {
    var segments: DisplaySegments {
        switch self {
            case .blank: return DisplaySegments()
            case .zero: return DisplaySegments(top: .on, bottom: .on, upperLeft: .on, upperRight: .on, lowerLeft: .on, lowerRight: .on, decimal: .on)
            case .one: return DisplaySegments(upperRight: .on, lowerRight: .on, decimal: .on)
            case .two: return DisplaySegments(top: .on, middle: .on, bottom: .on, upperRight: .on, lowerLeft: .on, decimal: .on)
            case .three: return DisplaySegments(top: .on, middle: .on, bottom: .on, upperRight: .on, lowerRight: .on, decimal: .on)
            case .four: return DisplaySegments(middle: .on, upperLeft: .on, upperRight: .on, lowerRight: .on, decimal: .on)
            case .five: return DisplaySegments(top: .on, middle: .on, bottom: .on, upperLeft: .on, lowerRight: .on, decimal: .on)
            case .six: return DisplaySegments(top: .on, middle: .on, bottom: .on, upperLeft: .on, lowerLeft: .on, lowerRight: .on, decimal: .on)
            case .seven: return DisplaySegments(top: .on, upperRight: .on, lowerRight: .on, decimal: .on)
            case .eight: return DisplaySegments(top: .on, middle: .on, bottom: .on, upperLeft: .on, upperRight: .on, lowerLeft: .on, lowerRight: .on, decimal: .on)
            case .nine: return DisplaySegments(top: .on, middle: .on, bottom: .on, upperLeft: .on, upperRight: .on, lowerRight: .on, decimal: .on)
            case .A: return DisplaySegments(top: .on, middle: .on, upperLeft: .on, upperRight: .on, lowerLeft: .on, lowerRight: .on)
            case .B: return DisplaySegments(top: .on, middle: .on, bottom: .on, upperLeft: .on, upperRight: .on, lowerLeft: .on, lowerRight: .on)
            case .C: return DisplaySegments(top: .on, bottom: .on, upperLeft: .on, lowerLeft: .on)
            case .D: return DisplaySegments(top: .on, bottom: .on, upperLeft: .on, upperRight: .on, lowerLeft: .on, lowerRight: .on)
            case .E: return DisplaySegments(top: .on, middle: .on, bottom: .on, upperLeft: .on, lowerLeft: .on)
            case .F: return DisplaySegments(top: .on, middle: .on, upperLeft: .on, lowerLeft: .on)
        }
    }
}

func runSevenLedIC() {
    let sdi = Pi.gpio17.setup(direction: .OUT, initialValue: .low)
    let rclk = Pi.gpio18.setup(direction: .OUT, initialValue: .low)
    let srclk = Pi.gpio27.setup(direction: .OUT, initialValue: .low)

    // Shift the data to 74HC595
    func display(_ displayValue: DisplayValue) {
        for value in displayValue.segments.values {
            sdi.boolValue = !value
            srclk.value = .high
            sleep(0.001)
            srclk.value = .low
        }
        rclk.value = .high
        sleep(0.001)
        rclk.value = .low
    }

    display(.zero)
}

func runSevenLed() {
    for i in 0..<8 {
        Pi.pins[i].setup(direction: .OUT, initialValue: .high)
    }

    func displayLed(_ displayValue: DisplayValue) {
        for (i, value) in displayValue.segments.values.enumerated() {
            Pi.pins[i].boolValue = !value
        }
    }
    func milesCountdown() {
        displayLed(.nine)
        sleep(1.0)
        displayLed(.eight)
        sleep(1.0)
        displayLed(.seven)
        sleep(1.0)
        displayLed(.six)
        sleep(1.0)
        displayLed(.five)
        sleep(1.0)
        displayLed(.four)
        sleep(1.0)
        displayLed(.three)
        sleep(1.0)
        displayLed(.two)
        sleep(1.0)
        displayLed(.one)
        sleep(1.0)
        displayLed(.zero)
        sleep(1.0)
        displayLed(.blank)
    }
    func milesAlphabet() {
        displayLed(.A)
        sleep(1.0)
        displayLed(.B)
        sleep(1.0)
        displayLed(.C)
        sleep(1.0)
        displayLed(.D)
        sleep(1.0)
        displayLed(.E)
        sleep(1.0)
        displayLed(.F)
    }
    milesCountdown()
}

func launch() {
    for i in 0..<8 {
        Pi.pins[i].setup(direction: .OUT, initialValue: .high)
    }
    Pi.gpio19.setup(direction: .OUT, initialValue: .low)

    func displayLed(_ displayValue: DisplayValue) {
        for (i, value) in displayValue.segments.values.enumerated() {
            Pi.pins[i].boolValue = !value
        }
    }
    func milesCountdown() {
        displayLed(.nine)
        sleep(1.0)
        displayLed(.eight)
        sleep(1.0)
        displayLed(.seven)
        sleep(1.0)
        displayLed(.six)
        sleep(1.0)
        displayLed(.five)
        Pi.gpio19.value = .high
        sleep(1.0)
        displayLed(.four)
        sleep(1.0)
        displayLed(.three)
        sleep(1.0)
        displayLed(.two)
        sleep(1.0)
        displayLed(.one)
        sleep(1.0)
        displayLed(.zero)
        sleep(1.0)
        Pi.gpio19.value = .low
        displayLed(.blank)
    }

    milesCountdown()
}

//runSevenLed()
launch()
