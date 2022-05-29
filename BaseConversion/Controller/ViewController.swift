//
//  ViewController.swift
//  BaseConversion
//
//  Created by 前田航汰 on 2021/08/10.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet private weak var fromBaseTextField: UITextField!
    @IBOutlet private weak var toBaseTextField: UITextField!
    @IBOutlet private weak var beforeNumberTextField: UITextField!
    @IBOutlet private weak var afterNumberLabel: UILabel!
    @IBOutlet private weak var convertButton: UIButton!
    @IBOutlet private weak var copyClearLabel: UILabel!

    private let baseLists = Array(2...36)
    private var fromBase:Int!
    private var toBase:Int!

    var pickerView: UIPickerView = UIPickerView()
    var transition = Transition()

    override func viewDidLoad() {
        super.viewDidLoad()
        setAfterPickerView()
        setBeforePickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        fromBaseTextField.inputView = pickerView
        toBaseTextField.inputView = pickerView

        fromBaseTextField.keyboardType = UIKeyboardType.numberPad
        toBaseTextField.keyboardType = UIKeyboardType.numberPad
        beforeNumberTextField.keyboardType = UIKeyboardType.numbersAndPunctuation
    }

    @IBAction private func didTapConvertButton(_ sender: Any) {
        var result = ""

        guard let beforeNumber = beforeNumberTextField.text, let _ = fromBase, let _ = toBase  else {
            print("wrong")
            return
        }

        do {
            try result = transition.transition(fromBase: fromBase, toBase: toBase, beforeNum: beforeNumber)
            afterNumberLabel.text = result
            print(fromBase)
            print(toBase)
            print(result)
        } catch {
            print("失敗した")
        }

    }

    //クリップボードにコピー
    @IBAction private func didTapCopyButton(_ sender: Any) {
        if(afterNumberLabel.text?.isEmpty == false){
            UIPasteboard.general.string = afterNumberLabel.text
            copyClearLabel.fadeTransition(0.5)
            copyClearLabel.text = "クリップボードにコピーしました"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.copyClearLabel.fadeTransition(0.5)
                self.copyClearLabel.text = ""
            }
        }
    }

    func setAfterPickerView() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapAfterPickerDoneItem))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        toolbar.setItems([cancelItem, spaceItem, doneItem], animated: true)

        toBaseTextField.inputView = pickerView
        toBaseTextField.inputAccessoryView = toolbar

        pickerView.selectRow(0, inComponent: 0, animated: false)
    }


    func setBeforePickerView() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapBeforePickerDoneItem))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        toolbar.setItems([cancelItem, spaceItem, doneItem], animated: true)

        fromBaseTextField.inputView = pickerView
        fromBaseTextField.inputAccessoryView = toolbar

        pickerView.selectRow(0, inComponent: 0, animated: false)
    }

    @objc func didTapBeforePickerDoneItem() {
        fromBaseTextField.endEditing(true)
        fromBaseTextField.text = "\(baseLists[pickerView.selectedRow(inComponent: 0)])進数"
        fromBase = baseLists[pickerView.selectedRow(inComponent: 0)]
    }

    @objc func didTapAfterPickerDoneItem() {
        toBaseTextField.endEditing(true)
        toBaseTextField.text = "\(baseLists[pickerView.selectedRow(inComponent: 0)])進数"
        toBase = baseLists[pickerView.selectedRow(inComponent: 0)]
    }

    @objc func cancel() {
        view.endEditing(true)
    }

    //キーボードをしまう
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return baseLists.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(baseLists[row])進数"
    }
}
