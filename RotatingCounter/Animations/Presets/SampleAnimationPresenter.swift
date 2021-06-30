//
//  SampleAnimationPresenter.swift
//  RotatingCounter
//
//  Created by Kiyotaka Sasaya on 2019/07/11.
//

import Foundation

public final class SampleAnimationPresenter: CountPresenter {
    init(from: Int, to: Int) {
        var f = from, t = to
        var fromDigits = [Int](), toDigits = [Int]()
        while 0 < f || 0 < t {
            let fromDigit = f % 10, toDigit = t % 10
            fromDigits.append(fromDigit)
            toDigits.append(toDigit)
            f /= 10
            t /= 10
        }

        let decreasing = to < from
        animatedDigits = zip(fromDigits, toDigits).enumerated().reversed().map { _, digits in
            return { progress in
                let (from, to) = digits
                let p = 1 - pow(progress - 1, 2)
                let destination: Int
                if from < to {
                    destination = to - (decreasing ? 10 : 0)
                } else if to < from {
                    destination = to + (decreasing ? 0 : 10)
                } else {
                    destination = to + (decreasing ? -10 : 10)
                }

                let value = Double(from) + p * Double(destination - from)
                let floorValue = floor(value)
                let integer: UInt8 = {
                    let raw = Int(floorValue) % 10
                    return UInt8(0 <= raw ? raw : 10 + raw)
                }()
                return (integer: integer, fraction: value - floorValue)
            }
        }
    }

    public func count(at progress: Double) -> CountRepresentation {
        return animatedDigits.map { $0(progress) }
    }

    private var animatedDigits = [(Double) -> DigitRepresentation]()
}
