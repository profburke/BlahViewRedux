//
//  ViewController.swift
//  BlahViewRedux
//
//  Created by Matthew Burke on 10/12/15.
//  Copyright © 2015-2021 BlueDino Software.

import UIKit

class ViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createBlahViews()

        let tgc = UITapGestureRecognizer(target: self, action: #selector(replaceBlahViews))
        view.addGestureRecognizer(tgc)
    }

    @objc
    private func replaceBlahViews() {
        view.subviews.forEach { $0.removeFromSuperview() }
        createBlahViews()
    }

    private func createBlahViews() {
        for _ in 0...Int.random(in: 4...20) {
            let blahView = BlahView()

            let (x, y) = (Int.random(in: 20...300), Int.random(in: 20...300))
            let (width, height) = (Int.random(in: 50...200), Int.random(in: 50...200))
            blahView.frame = CGRect(x: x, y: y, width: width, height: height)

            view.addSubview(blahView)
        }
    }
}

