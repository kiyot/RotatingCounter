//
//  IncrementalAnimationFactory.swift
//  RotatingCounter
//
//  Created by 笹谷 清隆 on 2021/06/30.
//

import Foundation

public final class IncrementalAnimationFactory: CountAnimationFactory {
    public init() {}

    public func createCountAnimation(from: Int, to: Int) -> CountAnimation {
        return CountAnimationAdapter(duration: 2, presenter: IncrementalAnimationPresenter(from: from, to: to))
    }
}
