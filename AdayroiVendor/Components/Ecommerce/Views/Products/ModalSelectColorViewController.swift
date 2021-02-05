//
//  ModelDemoController.swift
//  FlexColorPickerDemo
//
//  Created by Rastislav Mirek on 4/6/18.
//
//    MIT License
//  Copyright (c) 2018 Rastislav Mirek
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import FlexColorPicker

@available(iOS 13.0, *) protocol ModalSelectColorRutDelegate {
    func refreshData(colorIndex:Int,color:UIColor)
}
@available(iOS 13.0, *)
class ModalSelectColorViewController: DefaultColorPickerViewController {
var pickedColor = #colorLiteral(red: 0.6813090444, green: 0.253660053, blue: 1, alpha: 1)
     var modalSelectColorRutDelegate: ModalSelectColorRutDelegate!
    var colorIndex:Int=0
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedColor = pickedColor
        self.delegate=self
    }
    

}
@available(iOS 13.0, *) extension ModalSelectColorViewController: ColorPickerDelegate {
    func colorPicker(_: ColorPickerController, selectedColor: UIColor, usingControl: ColorControl) {
       
    }

    func colorPicker(_: ColorPickerController, confirmedColor: UIColor, usingControl: ColorControl) {
        print("hello confirmedColor \(confirmedColor)")
        self.modalSelectColorRutDelegate.refreshData(colorIndex:self.colorIndex,color: confirmedColor)
        dismiss(animated: true, completion: nil)
    }
}


