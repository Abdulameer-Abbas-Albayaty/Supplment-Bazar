//
//  ToolbarDoneButton.swift
//  Banan Ekyc iOS
//
//  Created by Ameer on 4/22/20.
//  Copyright © 2020 enjaz. All rights reserved.
//

import UIKit

class PickerKeyboardToolBar: UIToolbar {

    convenience init (_ doneAction : Selector? ) {
        self.init()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: doneAction)
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        self.sizeToFit()
        self.tintColor = UIColor.primary
        self.items = [space,done]
    }

}
