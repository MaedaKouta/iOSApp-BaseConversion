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
    private var resultNumberStringArray: [String] = ["", "", "", ""]
    private var transition = Transition()

    override func viewDidLoad() {
        super.viewDidLoad()
        inputNumberTextField.keyboardType = .numberPad
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
