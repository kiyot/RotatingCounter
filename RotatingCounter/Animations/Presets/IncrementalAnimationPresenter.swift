//
//  IncrementalAnimationPresenter.swift
//  RotatingCounter
//
//  Created by Kiyotaka Sasaya on 2021/06/30.
//

import Foundation

public final class IncrementalAnimationPresenter: CountPresenter {
    public init(from: Int, to: Int) {
        valueCalculator = { Double(from) + Double(to - from) * sqrt(1.0 - ($0 - 1.0) * ($0 - 1.0)) }
    }

    public func count(at progress: Double) -> CountRepresentation {
        let value = valueCalculator(progress)
        let floorValue = floor(value)
        let fraction = value - floorValue

        var intValue = Int(value)
        var applyFraction = true
        var count = CountRepresentation()
        while 0 < intValue {
            let digitValue = UInt8(intValue % 10)
            count.append((integer: digitValue, fraction: applyFraction ? fraction : 0))
            applyFraction = applyFraction && digitValue == 9
            intValue /= 10
        }

        return count.reversed()
    }

    private let valueCalculator: (Double) -> Double
}
