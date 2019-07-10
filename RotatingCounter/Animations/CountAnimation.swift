//
//  CountAnimation.swift
//  RotatingCounter
//
//  Created by Kiyotaka Sasaya on 2019/07/15.
//

import Foundation

public typealias DigitRepresentation = (integer: UInt8, fraction: Double)
public typealias CountRepresentation = [DigitRepresentation]

public protocol CountPresenter {
    func count(at progress: Double) -> CountRepresentation
}

public protocol CountAnimation {
    func count(at time: Date) -> (count: CountRepresentation, finished: Bool)
}

public protocol CountAnimationFactory {
    func createCountAnimation(from: Int, to: Int) -> CountAnimation
}
