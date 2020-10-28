//
//  Utility.swift
//
//
//  Created by Jake Foster on 9/7/20.
//

import Foundation

func wait(_ seconds: Double) {
    Thread.sleep(forTimeInterval: seconds)
}

//func blinkLed() {
//    Pi.gpio17.setup(direction: .OUT, initialValue: .high)
//
//    while true {
//        Pi.gpio4.toggleValue()
//        wait(0.5)
//    }
//}

//func runSevenLedIC() {
//    let sdi = Pi.gpio17.setup(direction: .OUT, initialValue: .low)
//    let rclk = Pi.gpio18.setup(direction: .OUT, initialValue: .low)
//    let srclk = Pi.gpio27.setup(direction: .OUT, initialValue: .low)
//
//    // Shift the data to 74HC595
//    func display(_ displayValue: DisplayValue) {
//        for value in displayValue.segments.values {
//            sdi.value = value == .on ? .low : .high
//            srclk.value = .high
//            wait(0.001)
//            srclk.value = .low
//        }
//        rclk.value = .high
//        wait(0.001)
//        rclk.value = .low
//    }
//
//    display(.zero)
//}
