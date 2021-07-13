import Foundation
import SwiftyGPIO

#if os(OSX)
deployAndExit()
#endif

enum Color {
    case red, yellow, green, blue
}

func waitForSeconds(_ seconds: Double) {
    Thread.sleep(forTimeInterval: seconds)
}

func setupPinsForColor(_ color: Color, buttonGPIO: GPIO, ledGPIO: GPIO, lightMgr: LightManager) {
    let buttonPin = buttonGPIO.setup(direction: .in)
    buttonPin.bounceTime = 0.1
    buttonPin.pull = .up

    ledGPIO.setup(direction: .out, initialValue: .high)

    buttonPin.onFalling { _ in
        lightMgr.buttonPressed(color: color)
    }
}

func setupSimon() {
    let redLedPin = Pi.gpio6
    let yellowLedPin = Pi.gpio12
    let greenLedPin = Pi.gpio5
    let blueLedPin = Pi.gpio16

    let lightPins = [Color.red: redLedPin,
                     .yellow: yellowLedPin,
                     .green: greenLedPin,
                     .blue: blueLedPin]

    let lightMgr = LightManager(lightPins: lightPins)

    setupPinsForColor(.red, buttonGPIO: Pi.gpio19, ledGPIO: redLedPin, lightMgr: lightMgr)
    setupPinsForColor(.yellow, buttonGPIO: Pi.gpio26, ledGPIO: yellowLedPin, lightMgr: lightMgr)
    setupPinsForColor(.green, buttonGPIO: Pi.gpio21, ledGPIO: greenLedPin, lightMgr: lightMgr)
    setupPinsForColor(.blue, buttonGPIO: Pi.gpio20, ledGPIO: blueLedPin, lightMgr: lightMgr)
}

setupSimon()
RunLoop.main.run()













//let pin = Pi.gpio20.setup(direction: .out, initialValue: .low)
//let redLedPin = Pi.gpio12.setup(direction: .out, initialValue: .low)
//let buttonPin = Pi.gpio19.setup(direction: .in)
//redLedPin.value = .high
//while buttonPin.value == .low {
//
//}
//redLedPin.value = .low
//for _ in 0..<5 {
//    pin.value = .high
//    waitForSeconds(1)
//    pin.value = .low
//    waitForSeconds(0.25)
//}


