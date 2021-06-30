//
//  RotatingCounter.swift
//  RotatingCounter
//
//  Created by Kiyotaka Sasaya on 2019/07/10.
//

import UIKit

// Why not @IBDesignable?
// https://github.com/mapbox/mapbox-gl-native/issues/10072
// @IBDesignable
open class RotatingCounter: UIView {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    public func set(value: Int, animated: Bool) {
        let oldValue = displayedValue
        self.value = value

        if animated {
            animation = animationFactory.createCountAnimation(from: oldValue, to: value)
        } else {
            animation = CountAnimationAdapter.fixed(value)
        }

        setNeedsDisplay()
    }

    /**
     This object creates animation.

     Set  customized animation factory if you want to change how count animates.
     */
    public var animationFactory: CountAnimationFactory = SampleAnimationFactory()

    @IBInspectable public var textColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }

    public var font = UIFont.preferredFont(forTextStyle: .body) {
        didSet {
            calculateCharacterSize()
            _ = updateIntrinsicContentSize(contentSize(for: value))
            setNeedsDisplay()
        }
    }

    private var displayedValue: Int {
        animation.count(at: Date()).count.reduce(0) { 10 * $0 + Int($1.integer) }
    }

    private(set) var value = 0
    private var contentSize = CGSize.zero
    private var digitSize = CGSize.zero
    private var commaSize = CGSize.zero
    private var animation: CountAnimation = CountAnimationAdapter.fixed(0)
}

// MARK: - UIView overrides
extension RotatingCounter {
    override open func draw(_ rect: CGRect) {
        super.draw(rect)

        let (count, finished) = animation.count(at: Date())
        let digits = removeLeadingZeros(from: count)
        let digitCount = digits.count
        let commaCount = (digitCount - 1) / 3

        let totalWidth = CGFloat(digits.count) * digitSize.width + CGFloat(commaCount) * commaSize.width
        let resized = updateIntrinsicContentSize(CGSize(width: totalWidth, height: digitSize.height))

        // TODO: shrink should be optional
        let shrink = min(1, bounds.width / totalWidth)
        var xOffset = (bounds.width - totalWidth) / 2
        let yOffset = (bounds.height - digitSize.height) / 2

        if let ctx = UIGraphicsGetCurrentContext() {
            ctx.scaleBy(x: shrink, y: 1)
            ctx.translateBy(x: bounds.width * (1 - shrink) / 2 / shrink, y: 0)

            ctx.addRect(CGRect(x: 0, y: yOffset, width: bounds.width, height: digitSize.height))
            ctx.clip()
        }

        for (index, (integer: i, fraction: f)) in digits.enumerated() {
            draw(text: String(i),
                 frame: CGRect(origin: CGPoint(x: xOffset, y: yOffset - CGFloat(f) * digitSize.height),
                               size: digitSize))

            draw(text: String((i + 1) % 10),
                 frame: CGRect(origin: CGPoint(x: xOffset, y: yOffset + CGFloat(1 - f) * digitSize.height),
                               size: digitSize))

            xOffset += digitSize.width

            // comma
            let isLast = index == digitCount - 1
            if !isLast && (digitCount - index) % 3 == 1 {
                draw(text: ",", frame: CGRect(origin: CGPoint(x: xOffset, y: yOffset), size: commaSize))
                xOffset += commaSize.width
            }
        }

        if resized || !finished {
            // FIXME: there should be a better way to do this
            DispatchQueue.main.async { [weak self] in self?.setNeedsDisplay() }
        }
    }

    open override var intrinsicContentSize: CGSize {
        return contentSize
    }

    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        value = Int.random(in: 0...30_000)
        set(value: Int.random(in: 0...30_000), animated: true)
        _ = updateIntrinsicContentSize(contentSize(for: value))
    }
}

// MARK: - private methods
private extension RotatingCounter {
    func setup() {
        calculateCharacterSize()
        _ = updateIntrinsicContentSize(contentSize(for: value))
    }

    func removeLeadingZeros(from count: CountRepresentation) -> ArraySlice<DigitRepresentation> {
        let digits = count.drop(while: { $0.integer == 0 && $0.fraction == 0 })
        if digits.isEmpty {
            return [(integer: 0, fraction: 0)]
        } else {
            return digits
        }
    }

    func updateIntrinsicContentSize(_ size: CGSize) -> Bool {
        if contentSize != size {
            contentSize = size
            invalidateIntrinsicContentSize()
            return true
        } else {
            return false
        }
    }

    func contentSize(for value: Int) -> CGSize {
        let digitCount: Int = {
            var count = 1

            var v = value
            while 0 < v {
                count += 1
                v /= 10
            }

            return count
        }()
        let commaCount = (digitCount - 1) / 3
        return CGSize(width: CGFloat(digitCount) * digitSize.width + CGFloat(commaCount) * commaSize.width,
                      height: digitSize.height)
    }

    func calculateCharacterSize() {
        let attr = textAttributes
        var size = CGSize.zero
        for i in 0...9 {
            let s = NSString(format: "%d", i).size(withAttributes: attr)
            if size.width < s.width { size.width = s.width }
            if size.height < s.height { size.height = s.height }
        }
        digitSize = size
        commaSize = ("," as NSString).size(withAttributes: attr)
    }

    func draw(text: String, frame: CGRect) {
        (text as NSString).draw(with: frame, options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil)
    }

    var textAttributes: [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return [
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
    }
}
