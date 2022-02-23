//
//  ViewController.swift
//  BaseConversion
//
//  Created by 前田航汰 on 2021/08/10.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var fromBaseTextField: UITextField!
    @IBOutlet weak var toBaseTextField: UITextField!
    @IBOutlet weak var beforeNumTextField: UITextField!
    @IBOutlet weak var afterNum: UILabel!
    @IBOutlet weak var transformButton: UIButton!
    @IBOutlet weak var copyOkTextField: UILabel!
    @IBOutlet weak var modeChangeButton: UIButton!
    @IBOutlet weak var wrongMessage: UILabel!
    
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
        transformButton.layer.cornerRadius = 5
        modeChangeButton.layer.cornerRadius = 10
        
        //TextFieldの設定
        fromBaseTextField.setUnderLine()
        toBaseTextField.setUnderLine()
        beforeNumTextField.setUnderLine()
        fromBaseTextField.attributedPlaceholder = NSAttributedString(string: "進数:変換前", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        toBaseTextField.attributedPlaceholder = NSAttributedString(string: "進数:変換後", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        beforeNumTextField.attributedPlaceholder = NSAttributedString(string: "変換したい値", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.fromBaseTextField.keyboardType = UIKeyboardType.numberPad
        self.toBaseTextField.keyboardType = UIKeyboardType.numberPad
        self.beforeNumTextField.keyboardType = UIKeyboardType.numbersAndPunctuation
    }
    
    @IBAction func transformButton(_ sender: Any) {
        wrongMessage.fadeTransition(0.3)
        wrongMessage.text = ""
        afterNum.text = ""
        fromBase = Int(fromBaseTextField.text!)
        toBase = Int(toBaseTextField.text!)
        beforeNum = beforeNumTextField.text!
        
        do{
            if(fromBaseTextField.text != "" && toBaseTextField.text != ""){
                try result = transition.transition(fromBase: fromBase, toBase: toBase, beforeNum: beforeNum)
            }else{
                UIPasteboard.general.string = wrongMessage.text!
                wrongMessage.fadeTransition(0.5)
                wrongMessage.text = "⚠正しい値を入力して下さい"
            }
        }catch{
            UIPasteboard.general.string = wrongMessage.text!
            wrongMessage.fadeTransition(0.5)
            wrongMessage.text = "⚠正しい値を入力して下さい"
        }
        
        afterNum.text = result
    }
    
    //クリップボードにコピー
    @IBAction func copyButton(_ sender: Any) {
        if(result != nil){
            UIPasteboard.general.string = result
            copyOkTextField.fadeTransition(0.5)
            copyOkTextField.text = "クリップボードにコピーしました"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.copyOkTextField.fadeTransition(0.5)
                self.copyOkTextField.text = ""
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
