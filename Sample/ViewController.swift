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

        updateCounter1()
        updateCounter2()
    }

    private func updateCounter1() {
        let newCount = Int.random(in: 0...30_000)
        counter1.set(value: newCount, animated: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 5 ) { [weak self] in
            self?.updateCounter1()
        }
    }

    private func updateCounter2() {
        let newCount = Int.random(in: 0...30_000)
        counter2.set(value: newCount, animated: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) { [weak self] in
            self?.updateCounter2()
        }
    }


    @IBOutlet weak var counter1: RotatingCounter!
    @IBOutlet weak var counter2: RotatingCounter!

}
