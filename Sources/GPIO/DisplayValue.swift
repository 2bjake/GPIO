//
//  DisplayValue.swift
//
//
//  Created by Jake Foster on 9/7/20.
//

struct DisplaySegments: Equatable {
    enum PowerState {
        case off
        case on
    }

    var top: PowerState = .off
    var middle: PowerState = .off
    var bottom: PowerState = .off
    var upperLeft: PowerState = .off
    var upperRight: PowerState = .off
    var lowerLeft: PowerState = .off
    var lowerRight: PowerState = .off
    var decimal: PowerState = .off

    var values: [PowerState] { [top, upperRight, lowerRight, bottom, lowerLeft, upperLeft, middle, decimal] }
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

extension DisplayValue {
    /// Returns DisplayValue for the number in the ones place in `value`
    init(_ value: Int) {
        var value = value
        if value < 0 { value *= -1 }
        value %= 10

        switch value {
            case 0: self = .zero
            case 1: self = .one
            case 2: self = .two
            case 3: self = .three
            case 4: self = .four
            case 5: self = .five
            case 6: self = .six
            case 7: self = .seven
            case 8: self = .eight
            case 9: self = .nine
            default: fatalError("failed to ensure that value was between 0 and 9")
        }
    }
}
