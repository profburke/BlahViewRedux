//
//  BlahView.swift
//  BlahViewRedux
//
//  Created by Matthew Burke on 10/12/15.
//  Copyright © 2015-2021 BlueDino Software.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


// A Swift implentation of an idea (and Obj-C code) by Mark Dalrymple.
// See https://www.bignerdranch.com/blog/peek-a-view/ for details.

import UIKit

public class BlahView: UIView {
    override public func draw(_ rect: CGRect) {
        let bounds = self.bounds

        viewColor.set()
        UIRectFill(bounds)

        UIColor.black.set()
        UIRectFrame(bounds)
    }

    public var viewColor: UIColor {
        let pointer = Unmanaged.passUnretained(self).toOpaque()
        let selfAsString = pointer.debugDescription
        let selfAsInt: Int = Int(strtoul(selfAsString, nil, 16))

        // NOTE: In markd's original, green and blue were shifted by
        // 8 and 16. But Swift objects are allocated at a different "spacing"
        // which resulted in multiple views being colored too similarly.
        // Offsets of 4 and 12 appear to work better in my limited testing.

        let red = (CGFloat(selfAsInt & 0xFF) / 255.0)
        let green = (CGFloat(selfAsInt >> 4 & 0xFF) / 255.0)
        let blue = (CGFloat(selfAsInt >> 12 & 0xFF) / 255.0)

        let color = UIColor(red: red,
                            green: green,
                            blue: blue,
                            alpha: 1.0)

        return color
    }

    public var accessibleFontColor: UIColor {
        return viewColor.isLightColor ? .black : .white
    }
}

extension UIColor {
    public var isLightColor: Bool {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0

        guard self.getRed(&red, green: &green, blue: &blue, alpha: nil) else {
            return false
        }
        
        let lightRed = red > 0.65
        let lightGreen = green > 0.65
        let lightBlue = blue > 0.65

        let lightness = [lightRed, lightGreen, lightBlue].reduce(0) { $1 ? $0 + 1 : $0 }
        return lightness >= 2
    }
}
