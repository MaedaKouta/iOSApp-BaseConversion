//
//  CopyUILabel.swift
//  BaseConversion
//
//  Created by 前田航汰 on 2022/05/30.
//

import Foundation
import UIKit

class CopyUILabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.copyInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.copyInit()
    }

    func copyInit() {
        self.isUserInteractionEnabled = true
        // 長押しコピー
        //self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(CopyUILabel.showMenu(sender:))))
        // 軽くタッチコピー
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CopyUILabel.showMenu(sender:))))
    }

    @objc func showMenu(sender:AnyObject?) {
        self.becomeFirstResponder()
        let contextMenu = UIMenuController.shared
        if !contextMenu.isMenuVisible {
            contextMenu.showMenu(from: self, rect: self.bounds)
        }
    }

    override func copy(_ sender: Any?) {
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = text
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.copy)
    }
}

