//
//  SimpleViewController.swift
//  BaseConversion
//
//  Created by 前田航汰 on 2021/08/14.
//

import UIKit

class SimpleViewController: UIViewController {
    
    @IBOutlet weak var modeChangeButton: UIButton!
    @IBOutlet weak var Base2TextField: UITextField!
    @IBOutlet weak var Base8TextField: UITextField!
    @IBOutlet weak var Base10TextField: UITextField!
    @IBOutlet weak var Base16TextField: UITextField!
    @IBOutlet weak var base2Button: UIButton!
    @IBOutlet weak var base8Button: UIButton!
    @IBOutlet weak var base10Button: UIButton!
    @IBOutlet weak var base16Button: UIButton!
    @IBOutlet weak var copy2Button: UIButton!
    @IBOutlet weak var copy8Button: UIButton!
    @IBOutlet weak var copy10Button: UIButton!
    @IBOutlet weak var copy16Button: UIButton!
    @IBOutlet weak var copyOkText2: UILabel!
    @IBOutlet weak var copyOkText8: UILabel!
    @IBOutlet weak var copyOkText10: UILabel!
    @IBOutlet weak var copyOkText16: UILabel!
    @IBOutlet weak var wrongMessage: UILabel!
    
    var result2num:String = ""
    var result8num:String = ""
    var result10num:String = ""
    var result16num:String = ""
    
    var transition = Transition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Base2TextField.setUnderLine2()
        Base8TextField.setUnderLine2()
        Base10TextField.setUnderLine2()
        Base16TextField.setUnderLine2()
        modeChangeButton.layer.cornerRadius = 10
        base2Button.layer.cornerRadius = 5
        base8Button.layer.cornerRadius = 5
        base10Button.layer.cornerRadius = 5
        base16Button.layer.cornerRadius = 5
        copy2Button.layer.cornerRadius = 5
        copy8Button.layer.cornerRadius = 5
        copy10Button.layer.cornerRadius = 5
        copy16Button.layer.cornerRadius = 5
        self.Base2TextField.keyboardType = UIKeyboardType.numbersAndPunctuation
        self.Base8TextField.keyboardType = UIKeyboardType.numbersAndPunctuation
        self.Base10TextField.keyboardType = UIKeyboardType.numbersAndPunctuation
        self.Base16TextField.keyboardType = UIKeyboardType.numbersAndPunctuation
    }
    
    //変換
    @IBAction func base2Button(_ sender: Any) {
        wrongMessage.fadeTransition(0.3)
        wrongMessage.text = ""
        //２進数が空であれば、「値を入力してください」
        if(Base2TextField.text!.isEmpty){
            //８進数、１０進数、１６進数を空にする
            Base8TextField.text = ""
            Base10TextField.text = ""
            Base16TextField.text = ""
        }else{
            //８進数、１０進数、１６進数を空にする
            Base8TextField.text = ""
            Base10TextField.text = ""
            Base16TextField.text = ""
            
            //変換、出力
            do{
                try Base8TextField.text = transition.transition(fromBase: 2, toBase: 8, beforeNum: Base2TextField.text!)
                try Base10TextField.text = transition.transition(fromBase: 2, toBase: 10, beforeNum: Base2TextField.text!)
                try Base16TextField.text = transition.transition(fromBase: 2, toBase: 16, beforeNum: Base2TextField.text!)
            }catch{
                UIPasteboard.general.string = wrongMessage.text!
                wrongMessage.fadeTransition(0.5)
                wrongMessage.text = "⚠正しい値を入力して下さい"
            }
        }
    }
    @IBAction func base8Button(_ sender: Any) {
        wrongMessage.fadeTransition(0.3)
        wrongMessage.text = ""
        //８進数が空であれば、「値を入力してください」
        if(Base8TextField.text!.isEmpty){
            //２進数、１０進数、１６進数を空にする
            Base2TextField.text = ""
            Base10TextField.text = ""
            Base16TextField.text = ""
        }else{
            //２進数、１０進数、１６進数を空にする
            Base2TextField.text = ""
            Base10TextField.text = ""
            Base16TextField.text = ""
            
            //変換、出力
            do{
                try Base2TextField.text = transition.transition(fromBase: 8, toBase: 2, beforeNum: Base8TextField.text!)
                try Base10TextField.text = transition.transition(fromBase: 8, toBase: 10, beforeNum: Base8TextField.text!)
                try Base16TextField.text = transition.transition(fromBase: 8, toBase: 16, beforeNum: Base8TextField.text!)
            }catch{
                UIPasteboard.general.string = wrongMessage.text!
                wrongMessage.fadeTransition(0.5)
                wrongMessage.text = "⚠正しい値を入力して下さい"
            }
        }
    }
    @IBAction func base10Button(_ sender: Any) {
        wrongMessage.fadeTransition(0.3)
        wrongMessage.text = ""
        //１０進数が空であれば、「値を入力してください」
        if(Base2TextField.text!.isEmpty){
            //２進数、８進数、１６進数を空にする
            Base2TextField.text = ""
            Base8TextField.text = ""
            Base16TextField.text = ""
        }else{
            //２進数、８進数、１６進数を空にする
            Base2TextField.text = ""
            Base8TextField.text = ""
            Base16TextField.text = ""
            
            //変換、出力
            do{
                try Base2TextField.text = transition.transition(fromBase: 10, toBase: 2, beforeNum: Base10TextField.text!)
                try Base8TextField.text = transition.transition(fromBase: 10, toBase: 8, beforeNum: Base10TextField.text!)
                try Base16TextField.text = transition.transition(fromBase: 10, toBase: 16, beforeNum: Base10TextField.text!)
            }catch{
                UIPasteboard.general.string = wrongMessage.text!
                wrongMessage.fadeTransition(0.5)
                wrongMessage.text = "⚠正しい値を入力して下さい"
            }
        }
    }
    @IBAction func base16Button(_ sender: Any) {
        wrongMessage.fadeTransition(0.3)
        wrongMessage.text = ""
        //１６進数が空であれば、「値を入力してください」
        if(Base2TextField.text!.isEmpty){
            //２進数、８進数、１０進数を空にする
            Base2TextField.text = ""
            Base8TextField.text = ""
            Base10TextField.text = ""
        }else{
            //２進数、８進数、１０進数を空にする
            Base2TextField.text = ""
            Base8TextField.text = ""
            Base10TextField.text = ""
            
            //変換、出力
            do{
                try Base2TextField.text = transition.transition(fromBase: 16, toBase: 2, beforeNum: Base16TextField.text!)
                try Base8TextField.text = transition.transition(fromBase: 16, toBase: 8, beforeNum: Base16TextField.text!)
                try Base10TextField.text = transition.transition(fromBase: 16, toBase: 10, beforeNum: Base16TextField.text!)
            }catch{
                UIPasteboard.general.string = wrongMessage.text!
                wrongMessage.fadeTransition(0.5)
                wrongMessage.text = "⚠正しい値を入力して下さい"
            }
        }
    }
    
    
    
    
    //クリップボードにコピー
    @IBAction func copy2num(_ sender: Any) {
        if(!Base2TextField.text!.isEmpty){
            UIPasteboard.general.string = Base2TextField.text!
            copyOkText2.fadeTransition(0.5)
            copyOkText2.text = "クリップボードにコピーしました"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.copyOkText2.fadeTransition(0.5)
                self.copyOkText2.text = ""
            }
        }
    }
    @IBAction func copy8num(_ sender: Any) {
        if(!Base8TextField.text!.isEmpty){
            UIPasteboard.general.string = Base8TextField.text!
            copyOkText8.fadeTransition(0.5)
            copyOkText8.text = "クリップボードにコピーしました"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                self.copyOkText8.fadeTransition(0.5)
                self.copyOkText8.text = ""
            }
        }
    }
    @IBAction func copy10num(_ sender: Any) {
        if(!Base10TextField.text!.isEmpty){
            UIPasteboard.general.string = Base10TextField.text!
            copyOkText10.fadeTransition(0.5)
            copyOkText10.text = "クリップボードにコピーしました"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.copyOkText10.fadeTransition(0.5)
                self.copyOkText10.text = ""
            }
        }
    }
    
    @IBAction func copy16num(_ sender: Any) {
        if(!Base16TextField.text!.isEmpty){
            UIPasteboard.general.string = Base16TextField.text!
            copyOkText16.fadeTransition(0.5)
            copyOkText16.text = "クリップボードにコピーしました"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.copyOkText16.fadeTransition(0.5)
                self.copyOkText16.text = ""
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
