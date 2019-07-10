//
//  FixedPresenter.swift
//  RotatingCounter
//
//  Created by Kiyotaka Sasaya on 2019/07/11.
//

import Foundation

public final class FixedPresenter: CountPresenter {
    public init(_ value: Int) {
        if value == 0 {
            digits = [0]
        } else {
            var digits = [UInt8]()
            var val = value
            while 0 < value {
                digits.append(UInt8(val % 10))
                val /= 10
            }

            self.digits = digits.reversed()
        }
    }

    public func count(at progress: Double) -> CountRepresentation {
        return digits.map { (integer: $0, fraction: 0) }
    }

    private let digits: [UInt8]
}
