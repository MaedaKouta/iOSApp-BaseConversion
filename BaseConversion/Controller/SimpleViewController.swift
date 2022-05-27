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
        base2View.layer.cornerRadius = 5
        base8View.layer.borderWidth = 1.0
        base8View.layer.borderColor = UIColor.systemGray.cgColor
        base8View.layer.cornerRadius = 5
        base10View.layer.borderWidth = 1.0
        base10View.layer.cornerRadius = 5
        base10View.layer.borderColor = UIColor.systemGray.cgColor
        base16View.layer.borderWidth = 1.0
        base16View.layer.cornerRadius = 5
        base16View.layer.borderColor = UIColor.systemGray.cgColor
    }

    @IBAction func didTapTransitionButton(_ sender: UIButton) {
        let base = [2, 8, 10, 16]
        let baseIndex = baseSegmentedControl.selectedSegmentIndex
        guard let number = Int(inputNumberTextField.text ?? "") else {
            return
        }
        print(number)
        do {
            try resultNumberStringArray = transition.transitionSimpleMode(fromBase: base[baseIndex], beforeNumber: String(number))
        } catch {
            print("???")
        }
        for i in 0..<resultNumberStringArray.count {
            answerTextLabels[i].text = resultNumberStringArray[i]
        }
    }

    private func copyText(index: Int){
        guard let number = Int(inputNumberTextField.text ?? "") else {
            return
        }
        UIPasteboard.general.string = inputNumberTextField.text ?? ""
        answerTextLabels[index].fadeTransition(0.5)
        answerTextLabels[index].text = "クリップボードにコピーしました"

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.answerTextLabels[index].fadeTransition(0.5)
            self.answerTextLabels[index].text = ""
        }
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
