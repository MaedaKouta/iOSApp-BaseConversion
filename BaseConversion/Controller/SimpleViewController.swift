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
    @IBOutlet private weak var deleteButton: UIButton!

    private var resultNumberStringArray: [String] = ["", "", "", ""]
    private var transition = Transition()

    override func viewDidLoad() {
        super.viewDidLoad()
        deleteButton.isEnabled = false
        inputNumberTextField.keyboardType = .numberPad
        base2View.layer.borderWidth = 1.0
        base2View.layer.borderColor = UIColor.systemGray.cgColor
        base2View.layer.cornerRadius = 3
        base8View.layer.borderWidth = 1.0
        base8View.layer.borderColor = UIColor.systemGray.cgColor
        base8View.layer.cornerRadius = 3
        base10View.layer.borderWidth = 1.0
        base10View.layer.cornerRadius = 3
        base10View.layer.borderColor = UIColor.systemGray.cgColor
        base16View.layer.borderWidth = 1.0
        base16View.layer.cornerRadius = 3
        base16View.layer.borderColor = UIColor.systemGray.cgColor
        answerTextLabels[0].adjustsFontSizeToFitWidth = true
        answerTextLabels[1].adjustsFontSizeToFitWidth = true
        answerTextLabels[2].adjustsFontSizeToFitWidth = true
        answerTextLabels[3].adjustsFontSizeToFitWidth = true

        transitionButton.layer.cornerRadius = 40
    }

    @IBAction func didChangeSegmentedControll(_ sender: Any) {
        switch baseSegmentedControl.selectedSegmentIndex {
        case 0:
            if inputNumberTextField.keyboardType != .numberPad {
                inputNumberTextField.endEditing(true)
                inputNumberTextField.keyboardType = .numberPad
            }
            inputNumberTextField.becomeFirstResponder()
        case 1:
            if inputNumberTextField.keyboardType != .numberPad {
                inputNumberTextField.endEditing(true)
                inputNumberTextField.keyboardType = .numberPad
            }
            inputNumberTextField.becomeFirstResponder()
        case 2:
            if inputNumberTextField.keyboardType != .numberPad {
                inputNumberTextField.endEditing(true)
                inputNumberTextField.keyboardType = .numberPad
            }
            inputNumberTextField.becomeFirstResponder()
        case 3:
            if inputNumberTextField.keyboardType != .default {
                inputNumberTextField.endEditing(true)
                inputNumberTextField.keyboardType = UIKeyboardType.numbersAndPunctuation
            }
            inputNumberTextField.becomeFirstResponder()
        default:
            inputNumberTextField.keyboardType = UIKeyboardType.numbersAndPunctuation
        }

    }

    @IBAction private func didTapTransitionButton(_ sender: UIButton) {
        let base = [2, 8, 10, 16]
        let baseIndex = baseSegmentedControl.selectedSegmentIndex

        // textFieldに値が入っているかの判定
        let text = inputNumberTextField.text ?? ""
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedText.isEmpty == true {
            makeLabelBlank()
            presentAleart(title: "エラー", message: "値が入力されていません。", actionTitle: "了解")
            return
        }

        do {
            try resultNumberStringArray = transition.transitionSimpleMode(fromBase: base[baseIndex], beforeNumber: String(trimmedText))
            inputNumberTextField.endEditing(true)
        } catch {
            makeLabelBlank()
            if error as? TransitionError == TransitionError.WrongInputBase {
                presentAleart(title: "エラー", message: "選択された進数と値が一致しません。", actionTitle: "了解")
            }
            if error as? TransitionError == TransitionError.OverNumber {
                presentAleart(title: "エラー", message: "入力された値が大きすぎます。", actionTitle: "了解")
            }
        }
        for i in 0..<resultNumberStringArray.count {
            answerTextLabels[i].text = resultNumberStringArray[i]
        }

    }

    @IBAction private func didChangeTextField(_ sender: Any) {
        let text = inputNumberTextField.text ?? ""
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedText.isEmpty {
            deleteButton.isEnabled = false
        } else {
            deleteButton.isEnabled = true
        }
    }

    @IBAction private func didTapDeleteButton(_ sender: Any) {
        makeLabelBlank()
        inputNumberTextField.text = ""
        deleteButton.isEnabled = false
    }

    private func makeLabelBlank() {
        resultNumberStringArray = ["", "", "", ""]
        for i in 0..<resultNumberStringArray.count {
            answerTextLabels[i].text = resultNumberStringArray[i]
        }
    }

    private func presentAleart(title: String, message: String, actionTitle: String) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let ok = UIAlertAction(title: actionTitle, style: .cancel) { (acrion) in
        }

        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

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
