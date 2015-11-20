//
//  BlahView.swift
//  BlahViewRedux
//
//  Created by Matthew Burke on 10/12/15.
//  Copyright © 2015 BlueDino Software. 
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



class BlahView: UIView
{
  
  override func drawRect(rect: CGRect)
  {
    let bounds = self.bounds

    pointerToColor(unsafeAddressOf(self)).set()
    UIRectFill(bounds)
    
    UIColor.blackColor().set()
    UIRectFrame(bounds)
  }
  
  
  
  
  private func pointerToColor(pointer: UnsafePointer<Void>) -> UIColor
  {
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
  
  
}
