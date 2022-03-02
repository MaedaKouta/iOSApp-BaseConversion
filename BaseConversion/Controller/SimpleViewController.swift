//
//  SimpleViewController.swift
//  BaseConversion
//
//  Created by 前田航汰 on 2021/08/14.
//

import UIKit

class SimpleViewController: UIViewController {

    @IBOutlet private var inputNumberTextField: [UITextField]!
    @IBOutlet private var copyClearTextLabel: [UILabel]!
    @IBOutlet private weak var wrongMessage: UILabel!

    private var resultNumberStringArray = ["", "", "", ""]
    private var array = [String]()

    private var transition = Transition()

    override func viewDidLoad() {
        super.viewDidLoad()
        for textField in inputNumberTextField {
            // textField.setUnderLine2()
            textField.keyboardType = UIKeyboardType.numbersAndPunctuation
        }
    }

    //変換
    @IBAction private func didTapConvert2Button(_ sender: Any) {
        TransitionOutput(index: 0)
    }
    @IBAction private func didTapConvert8Button(_ sender: Any) {
        TransitionOutput(index: 1)
    }
    @IBAction private func didTapConvert10Button(_ sender: Any) {
        TransitionOutput(index: 2)
    }
    @IBAction private func didTapConvert16Button(_ sender: Any) {
        TransitionOutput(index: 3)
    }

    //クリップボードにコピー
    @IBAction func didTapCopy2Button(_ sender: Any) {
        copyText(index: 0)
    }
    @IBAction func didTapCopy8Button(_ sender: Any) {
        copyText(index: 1)
    }
    @IBAction func didTapCopy10Button(_ sender: Any) {
        copyText(index: 2)
    }
    @IBAction func didTapCopy16Button(_ sender: Any) {
        copyText(index: 3)
    }

    func TransitionOutput(index: Int) {
        let targetBases = [2, 8, 10, 18]
        let targetBase = targetBases[index]

        wrongMessage.fadeTransition(0.3)
        wrongMessage.text = ""

        if inputNumberTextField[index].text?.isEmpty == false {
            do {
                try resultNumberStringArray = transition.transitionSimpleMode(fromBase: targetBase, beforeNumber: inputNumberTextField[index].text!)
                for i in 0 ..< resultNumberStringArray.count {
                    inputNumberTextField[i].text = resultNumberStringArray[i]
                }
            } catch {
                UIPasteboard.general.string = wrongMessage.text!
                wrongMessage.fadeTransition(0.5)
                wrongMessage.text = "⚠正しい値を入力して下さい"
            }

        } else {
            for i in 0 ..< resultNumberStringArray.count {
                inputNumberTextField[i].text = ""
            }
        }
    }

    func copyText(index: Int){
        if inputNumberTextField[index].text?.isEmpty == false {
            UIPasteboard.general.string = inputNumberTextField[index].text ?? ""
            copyClearTextLabel[index].fadeTransition(0.5)
            copyClearTextLabel[index].text = "クリップボードにコピーしました"

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.copyClearTextLabel[index].fadeTransition(0.5)
                self.copyClearTextLabel[index].text = ""
            }
        }
    }

    //キーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }

    //画面遷移
    @IBAction func modeChange(_ sender: Any) {
        let nextView = storyboard?.instantiateViewController(withIdentifier: "Next") as! ViewController
                nextView.modalPresentationStyle = .fullScreen
                self.present(nextView, animated: true, completion: nil)
    }
}

//TextFieldのデザインを整える
extension UITextField {
    func setUnderLine2() {
        // 枠線を非表示にする
        borderStyle = .none
        let underline = UIView()
        // heightにはアンダーラインの高さを入れる
        underline.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: 0.5)
        // 枠線の色
        underline.backgroundColor = .white
        addSubview(underline)
        // 枠線を最前面に
        bringSubviewToFront(underline)
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
