//
//  CountAnimation.swift
//  RotatingCounter
//
//  Created by Kiyotaka Sasaya on 2019/07/15.
//

import Foundation

/**
 Representation of each digit

 `integer` should be in 0...9, and `fraction` should be in 0.0..<1.0

 Two numbers(`n`=`integer`, `n+1`) are drawn for each digit.
 `n` is leaving upward and `n+1` is entering from the bottom.

 For example, when interger is 3 and fraction is 0.3, the bottom 70% of digit `3` is drawn at the top,
 and the top 30% of digit `4` is drawn at the bottom.
 */
public typealias DigitRepresentation = (integer: UInt8, fraction: Double)

/**
 Representaion of count

 This is just an array of `DigitRepresentation` in order from left to right.
 */
public typealias CountRepresentation = [DigitRepresentation]

/**
 An interface to retrieve `CountRepresentation` from animation progress
 */
public protocol CountPresenter {
    func count(at progress: Double) -> CountRepresentation
}

/**
 An interface to retrieve `CountRepresentation` from datetime

 `time` is going to be the current timestamp in most cases.
 */
public protocol CountAnimation {
    func count(at time: Date) -> (count: CountRepresentation, finished: Bool)
}

/**
 An interface to create `CountAnimation`

 `from` is the starting count, and `to` is the destination count of the animation.
 */
public protocol CountAnimationFactory {
    func createCountAnimation(from: Int, to: Int) -> CountAnimation
}
