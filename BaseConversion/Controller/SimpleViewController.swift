//
//  SimpleViewController.swift
//  BaseConversion
//
//  Created by 前田航汰 on 2021/08/14.
//

import UIKit

class SimpleViewController: UIViewController {

    @IBOutlet private weak var inputNumberTextField: UITextField!
    @IBOutlet private var answerTextLabels: [UILabel]!
    @IBOutlet private weak var baseSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var transitionButton: UIButton!

    @IBOutlet private weak var base2View: UIView!
    @IBOutlet private weak var base8View: UIView!
    @IBOutlet private weak var base10View: UIView!
    @IBOutlet private weak var base16View: UIView!

    private var resultNumberStringArray: [String] = ["", "", "", ""]
    private var transition = Transition()

    override func viewDidLoad() {
        super.viewDidLoad()
        inputNumberTextField.keyboardType = .numberPad
        base2View.layer.borderWidth = 1.0
        base2View.layer.borderColor = UIColor.systemGray.cgColor
        //base2View.layer.cornerRadius = 5
        base8View.layer.borderWidth = 1.0
        base8View.layer.borderColor = UIColor.systemGray.cgColor
        //base8View.layer.cornerRadius = 5
        base10View.layer.borderWidth = 1.0
        //base10View.layer.cornerRadius = 5
        base10View.layer.borderColor = UIColor.systemGray.cgColor
        base16View.layer.borderWidth = 1.0
        //base16View.layer.cornerRadius = 5
        base16View.layer.borderColor = UIColor.systemGray.cgColor
        answerTextLabels[0].adjustsFontSizeToFitWidth = true
        answerTextLabels[1].adjustsFontSizeToFitWidth = true
        answerTextLabels[2].adjustsFontSizeToFitWidth = true
        answerTextLabels[3].adjustsFontSizeToFitWidth = true

        //transitionButton.layer.borderWidth = 1.0
        //transitionButton.layer.borderColor = UIColor.systemGray.cgColor
        transitionButton.layer.cornerRadius = 40
    }

    @IBAction private func didTapTransitionButton(_ sender: UIButton) {
        let base = [2, 8, 10, 16]
        let baseIndex = baseSegmentedControl.selectedSegmentIndex
        guard let number = Int(inputNumberTextField.text ?? "") else {
            print("値が大きすぎて変換できません")
            return
        }
        do {
            try resultNumberStringArray = transition.transitionSimpleMode(fromBase: base[baseIndex], beforeNumber: String(number))
            print(resultNumberStringArray)
        } catch {
            print("値が大きすぎて変換できません")
        }
        for i in 0..<resultNumberStringArray.count {
            answerTextLabels[i].text = resultNumberStringArray[i]
        }

    }

/*
    @IBAction private func changeTextField(_ sender: Any) {
        let text = inputNumberTextField.text ?? ""
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedText.isEmpty {
            transitionButton.isEnabled = false
        } else {
            transitionButton.isEnabled = true
        }
    }
*/

    //キーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }

}

//テキストアニメーション
extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
