//
//  SampleAnimationFactory.swift
//  RotatingCounter
//
//  Created by Kiyotaka Sasaya on 2019/07/15.
//

import Foundation

public final class SampleAnimationFactory: CountAnimationFactory {
    public func createCountAnimation(from: Int, to: Int) -> CountAnimation {
        return CountAnimationAdapter(duration: 2, presenter: SampleAnimationPresenter(from: from, to: to))
    }
}
