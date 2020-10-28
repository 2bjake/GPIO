import Foundation
import SwiftyGPIO

func launch() {
    let display = SevenSegmentDisplay(pins: Array(Pi.gpioPins.prefix(8)))
    display.setup()

    let fanPin = Pi.gpio19.setup(direction: .out, initialValue: .low)

    display.displayCountdown(from: 10) {
        // TODO: add buzzer beep (if $0 == 0, beep a lot)
        // TODO: blink LED  (if $0 == 0, blink a lot)
        if $0 == 5 {
            fanPin.value = .high
        }
    }
    fanPin.value = .low
    display.displayValue(.blank)
}

// TODO: add a button to start the whole process
launch()
