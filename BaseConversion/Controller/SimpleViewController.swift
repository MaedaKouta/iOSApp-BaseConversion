//
//  SimpleViewController.swift
//  BaseConversion
//
//  Created by 前田航汰 on 2021/08/14.
//

import UIKit

class SimpleViewController: UIViewController {
    
    @IBOutlet private weak var modeChangeButton: UIButton!
    @IBOutlet private var inputNumberTextField: [UITextField]!
    @IBOutlet private var conversionButton: [UIButton]!
    @IBOutlet private var copyButton: [UIButton]!
    @IBOutlet private var copyClearTextLabel: [UILabel]!
    @IBOutlet private weak var wrongMessage: UILabel!

    private var resultNumberStringArray = ["", "", "", ""]
    private var array = [String]()

    private var transition = Transition()

    override func viewDidLoad() {
        super.viewDidLoad()
        for textField in inputNumberTextField {
            textField.setUnderLine2()
            textField.keyboardType = UIKeyboardType.numbersAndPunctuation
        }
    }

    //変換
    @IBAction private func base2Button(_ sender: Any) {
        TransitionOutput(index: 0)
    }

    @IBAction private func base8Button(_ sender: Any) {
        TransitionOutput(index: 1)
    }

    @IBAction private func base10Button(_ sender: Any) {
        TransitionOutput(index: 2)
    }

    @IBAction private func base16Button(_ sender: Any) {
        TransitionOutput(index: 3)
    }

    //クリップボードにコピー
    @IBAction func copy2num(_ sender: Any) {
        if(!inputNumberTextField[0].text!.isEmpty){
            UIPasteboard.general.string = inputNumberTextField[0].text!
            copyClearTextLabel[0].fadeTransition(0.5)
            copyClearTextLabel[0].text = "クリップボードにコピーしました"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.copyClearTextLabel[0].fadeTransition(0.5)
                self.copyClearTextLabel[0].text = ""
            }
        }
    }

    @IBAction func copy8num(_ sender: Any) {
        if(!inputNumberTextField[1].text!.isEmpty){
            UIPasteboard.general.string = inputNumberTextField[1].text!
            copyClearTextLabel[1].fadeTransition(0.5)
            copyClearTextLabel[1].text = "クリップボードにコピーしました"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                self.copyClearTextLabel[1].fadeTransition(0.5)
                self.copyClearTextLabel[1].text = ""
            }
        }
    }

    @IBAction func copy10num(_ sender: Any) {
        if(!inputNumberTextField[2].text!.isEmpty){
            UIPasteboard.general.string = inputNumberTextField[2].text!
            copyClearTextLabel[2].fadeTransition(0.5)
            copyClearTextLabel[2].text = "クリップボードにコピーしました"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.copyClearTextLabel[2].fadeTransition(0.5)
                self.copyClearTextLabel[2].text = ""
            }
        }
    }

    @IBAction func copy16num(_ sender: Any) {
        if(!inputNumberTextField[3].text!.isEmpty){
            UIPasteboard.general.string = inputNumberTextField[3].text!
            copyClearTextLabel[3].fadeTransition(0.5)
            copyClearTextLabel[3].text = "クリップボードにコピーしました"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.copyClearTextLabel[3].fadeTransition(0.5)
                self.copyClearTextLabel[3].text = ""
            }
        }
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
