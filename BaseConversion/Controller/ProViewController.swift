//
//  ViewController.swift
//  BaseConversion
//
//  Created by 前田航汰 on 2021/08/10.
//

import UIKit

class ProViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet private weak var beforeBaseNumberTextField: UITextField!
    @IBOutlet private weak var afterBaseNumberTextField: UITextField!
    @IBOutlet private weak var inputNumberTextField: UITextField!
    @IBOutlet private weak var afterNumberLabel: UILabel!
    @IBOutlet private weak var convertButton: UIButton!
    @IBOutlet private weak var afterBaseNumberView: UIView!

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

        afterBaseNumberView.layer.borderWidth = 1.0
        afterBaseNumberView.layer.borderColor = UIColor.systemGray.cgColor
        afterBaseNumberView.layer.cornerRadius = 3
        //afterBaseNumberView.isHidden = false

        beforeBaseNumberTextField.keyboardType = UIKeyboardType.numberPad
        afterBaseNumberTextField.keyboardType = UIKeyboardType.numberPad
        inputNumberTextField.keyboardType = UIKeyboardType.numbersAndPunctuation
    }

    @IBAction private func didTapConvertButton(_ sender: Any) {
        inputNumberTextField.endEditing(true)
        var result = ""

        // textFieldに値が入っているかの判定
        let inputBase = inputNumberTextField.text ?? ""
        let trimmedText = inputBase.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedText.isEmpty == true {
            afterNumberLabel.text = ""
            presentAleart(title: "エラー", message: "値が入力されていません。", actionTitle: "了解")
            return
        }

        guard let _ = beforeBaseNumber, let _ = afterBaseNumber  else {
            afterNumberLabel.text = ""
            presentAleart(title: "エラー", message: "進数が選択されていません。", actionTitle: "了解")
            return
        }

        do {
            try result = transition.transitionProMode(fromBase: beforeBaseNumber, toBase: afterBaseNumber, beforeNum: inputBase)
            afterNumberLabel.text = result
        } catch {
            afterNumberLabel.text = ""
            presentAleart(title: "エラー", message: "値が大きすぎるか、値が間違えています。", actionTitle: "了解")
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

    private func presentAleart(title: String, message: String, actionTitle: String) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let ok = UIAlertAction(title: actionTitle, style: .cancel) { (acrion) in
        }

        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

}

extension ProViewController : UIPickerViewDelegate, UIPickerViewDataSource {

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
