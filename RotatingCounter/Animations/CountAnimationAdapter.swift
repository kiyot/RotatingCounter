//
//  CountAnimationAdapter.swift
//  RotatingCounter
//
//  Created by Kiyotaka Sasaya on 2019/07/15.
//

import Foundation

/**
 A utility class to create count animations based on elapsed time
 */
public struct CountAnimationAdapter {
    public init(duration: TimeInterval, presenter: CountPresenter, start: Date = Date()) {
        self.duration = duration
        self.presenter = presenter
        self.start = start
    }

    public let duration: TimeInterval
    public let presenter: CountPresenter
    public let start: Date
}

extension CountAnimationAdapter: CountAnimation {
    public func count(at time: Date) -> (count: CountRepresentation, finished: Bool) {
        let progress = max(0, min(1, -start.timeIntervalSinceNow / duration))
        return (count: presenter.count(at: progress), finished: 1 <= progress)
    }
}

extension CountAnimationAdapter {
    public static func fixed(_ value: Int) -> CountAnimation {
        return CountAnimationAdapter(duration: 1, presenter: FixedPresenter(value))
    }
}
