func launch() {
    let display = SevenSegmentDisplay(pins: Array(Pi.gpioPins.prefix(8)))
    display.setup()

    let fanPin = Pi.gpio19.setup(direction: .out, initialValue: .low)

    display.displayCountdown(from: 9) { currentNumber in
        // TODO: add buzzer beep (if $0 == 0, beep a lot)
        // TODO: blink LED  (if $0 == 0, blink a lot)
        print(currentNumber)
        if currentNumber == 5 {
            fanPin.value = .high
        }

        if currentNumber == 0 {
            fanPin.value = .low
        }
    }
    display.displayValue(.blank)
}
