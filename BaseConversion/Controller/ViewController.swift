//
//  ViewController.swift
//  BaseConversion
//
//  Created by 前田航汰 on 2021/08/10.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var fromBaseTextField: UITextField!
    @IBOutlet private weak var toBaseTextField: UITextField!
    @IBOutlet private weak var beforeNumberTextField: UITextField!
    @IBOutlet private weak var afterNumberLabel: UILabel!
    @IBOutlet private weak var conversionButton: UIButton!
    @IBOutlet private weak var copyClearLabel: UILabel!
    @IBOutlet private weak var modeChangeButton: UIButton!
    @IBOutlet private weak var wrongMessageLabel: UILabel!

    var fromBase:Int!
    var toBase:Int!
    var beforeNum:String!
    var result:String!
    var copyOkText: String!
    
    var transition = Transition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //buttonの設定
        //transformButton.sizeToFit()
        conversionButton.layer.cornerRadius = 5
        modeChangeButton.layer.cornerRadius = 10
        
        //TextFieldの設定
        fromBaseTextField.setUnderLine()
        toBaseTextField.setUnderLine()
        beforeNumberTextField.setUnderLine()
        fromBaseTextField.attributedPlaceholder = NSAttributedString(string: "進数:変換前", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        toBaseTextField.attributedPlaceholder = NSAttributedString(string: "進数:変換後", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        beforeNumberTextField.attributedPlaceholder = NSAttributedString(string: "変換したい値", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.fromBaseTextField.keyboardType = UIKeyboardType.numberPad
        self.toBaseTextField.keyboardType = UIKeyboardType.numberPad
        self.beforeNumberTextField.keyboardType = UIKeyboardType.numbersAndPunctuation
    }
    
    @IBAction func transformButton(_ sender: Any) {
        wrongMessageLabel.fadeTransition(0.3)
        wrongMessageLabel.text = ""
        afterNumberLabel.text = ""
        fromBase = Int(fromBaseTextField.text!)
        toBase = Int(toBaseTextField.text!)
        beforeNum = beforeNumberTextField.text!
        
        do{
            if(fromBaseTextField.text != "" && toBaseTextField.text != ""){
                try result = transition.transition(fromBase: fromBase, toBase: toBase, beforeNum: beforeNum)
            }else{
                UIPasteboard.general.string = wrongMessageLabel.text!
                wrongMessageLabel.fadeTransition(0.5)
                wrongMessageLabel.text = "⚠正しい値を入力して下さい"
            }
        }catch{
            UIPasteboard.general.string = wrongMessageLabel.text!
            wrongMessageLabel.fadeTransition(0.5)
            wrongMessageLabel.text = "⚠正しい値を入力して下さい"
        }
        
        afterNumberLabel.text = result
    }

    //クリップボードにコピー
    @IBAction func copyButton(_ sender: Any) {
        if(result != nil){
            UIPasteboard.general.string = result
            copyClearLabel.fadeTransition(0.5)
            copyClearLabel.text = "クリップボードにコピーしました"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.copyClearLabel.fadeTransition(0.5)
                self.copyClearLabel.text = ""
            }
        }
    }

    //キーボードをしまう
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }

    //画面遷移
    @IBAction func modeChangeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

//TextFieldのデザインを整える
extension UITextField {
    func setUnderLine() {
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
