//
//  UITextView+Extension.swift
//  AnyFormatKit
//
//  Created by Oleksandr Orlov on 12.11.2020.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

extension UITextView {
  
  func setCursorLocation(_ location: Int) {
    if let cursorLocation = position(from: beginningOfDocument, offset: location) {
      DispatchQueue.main.async { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.selectedTextRange = strongSelf.textRange(from: cursorLocation, to: cursorLocation)
      }
    }
  }
  
}