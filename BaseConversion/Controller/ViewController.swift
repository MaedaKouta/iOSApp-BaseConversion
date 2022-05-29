//
//  ViewController.swift
//  BaseConversion
//
//  Created by 前田航汰 on 2021/08/10.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet private weak var beforeBaseNumberTextField: UITextField!
    @IBOutlet private weak var afterBaseNumberTextField: UITextField!
    @IBOutlet private weak var beforeNumberTextField: UITextField!
    @IBOutlet private weak var afterNumberLabel: UILabel!
    @IBOutlet private weak var convertButton: UIButton!

    private let baseLists = Array(2...36)
    private var beforeBaseNumber:Int!
    private var afterBaseNumber:Int!

    private let pickerView: UIPickerView = UIPickerView()
    private let transition = Transition()

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
        setAfterPickerView()
        setBeforePickerView()
        beforeBaseNumberTextField.inputView = pickerView
        afterBaseNumberTextField.inputView = pickerView

        beforeBaseNumberTextField.keyboardType = UIKeyboardType.numberPad
        afterBaseNumberTextField.keyboardType = UIKeyboardType.numberPad
        beforeNumberTextField.keyboardType = UIKeyboardType.numbersAndPunctuation
    }

    @IBAction private func didTapConvertButton(_ sender: Any) {
        var result = ""

        guard let beforeNumber = beforeNumberTextField.text, let _ = beforeBaseNumber, let _ = afterBaseNumber  else {
            print("wrong")
            return
        }

        do {
            try result = transition.transition(fromBase: beforeBaseNumber, toBase: afterBaseNumber, beforeNum: beforeNumber)
            afterNumberLabel.text = result
        } catch {
            print("失敗した")
        }

    }

    //クリップボードにコピー
    @IBAction private func didTapCopyButton(_ sender: Any) {
        if(afterNumberLabel.text?.isEmpty == false){
            UIPasteboard.general.string = afterNumberLabel.text
            //copyClearLabel.text = "クリップボードにコピーしました"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                //self.copyClearLabel.fadeTransition(0.5)
                //self.copyClearLabel.text = ""
            }
        }
    }


    private func setBeforePickerView() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapBeforePickerDoneButton))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        toolbar.setItems([cancelItem, spaceItem, doneItem], animated: true)

        beforeBaseNumberTextField.inputView = pickerView
        beforeBaseNumberTextField.inputAccessoryView = toolbar

        pickerView.selectRow(0, inComponent: 0, animated: false)
    }


    private func setAfterPickerView() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapAfterPickerDoneButton))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        toolbar.setItems([cancelItem, spaceItem, doneItem], animated: true)

        afterBaseNumberTextField.inputView = pickerView
        afterBaseNumberTextField.inputAccessoryView = toolbar

        pickerView.selectRow(0, inComponent: 0, animated: false)
    }


    @objc private func didTapBeforePickerDoneButton() {
        beforeBaseNumberTextField.endEditing(true)
        beforeBaseNumberTextField.text = "\(baseLists[pickerView.selectedRow(inComponent: 0)])進数"
        beforeBaseNumber = baseLists[pickerView.selectedRow(inComponent: 0)]
    }

    @objc private func didTapAfterPickerDoneButton() {
        afterBaseNumberTextField.endEditing(true)
        afterBaseNumberTextField.text = "\(baseLists[pickerView.selectedRow(inComponent: 0)])進数"
        afterBaseNumber = baseLists[pickerView.selectedRow(inComponent: 0)]
    }

    @objc private func cancel() {
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
