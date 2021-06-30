//
//  ViewController.swift
//  Sample
//
//  Created by Kiyotaka Sasaya on 2019/07/11.
//

import UIKit
import RotatingCounter

@IBDesignable
final class DesignableRotatingCounter: RotatingCounter {
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        updateCounters()
    }

    private func updateCounters() {
        let newCount = Int.random(in: 0...300)
        counter1.set(value: newCount, animated: true)
        counter2.set(value: newCount, animated: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 5 ) { [weak self] in
            self?.updateCounters()
        }
    }

    @IBOutlet weak var counter1: RotatingCounter! {
        didSet {
            counter1.font = font
        }
    }
    @IBOutlet weak var counter2: RotatingCounter! {
        didSet {
            counter2.font = font
            counter2.animationFactory = IncrementalAnimationFactory()
        }
    }

    private let font = UIFont.boldSystemFont(ofSize: 35)
}

