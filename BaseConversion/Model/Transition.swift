//
//  Transition.swift
//  BaseConversion
//
//  Created by 前田航汰 on 2021/08/13.
//

import Foundation

enum TransitionError : Error {
    case WrongInputBase  // 入力進数が間違えているエラー
    case OverNumber // 入力・出力進数が大きすぎるエラー
    case SomethingWrong // どこかが失敗したエラー
}

//n進数からn進数にするコード
class Transition{

    // シンプルモードから呼び出される関数
    func transitionSimpleMode(fromBase: Int, beforeNumber: String) throws -> [String] {

        // 入力された進数を適切に入力されているか判定
        for char in beforeNumber {

            if fromBase == 2 {
                let needsNumber = "01"
                if !needsNumber.contains(char) {
                    throw TransitionError.WrongInputBase
                }
            }

            if fromBase == 8 {
                let needsNumber = "01234567"
                if !needsNumber.contains(char) {
                    throw TransitionError.WrongInputBase
                }
            }

            if fromBase == 10 {
                let needsNumber = "0123456789"
                if !needsNumber.contains(char) {
                    throw TransitionError.WrongInputBase
                }
            }

            if fromBase == 16 {
                let needsNumber = "0123456789abcdef"
                if !needsNumber.contains(char) {
                    throw TransitionError.WrongInputBase
                }
            }

        }

        // Intのキャパを超えるかの判定
        if Int(beforeNumber, radix: fromBase) == nil {
            throw TransitionError.OverNumber
        }

        let base2String = String(Int(beforeNumber, radix: fromBase)!, radix:2)
        let base8String = String(Int(beforeNumber, radix: fromBase)!, radix:8)
        let base10String = String(Int(beforeNumber, radix: fromBase)!, radix:10)
        let base16String = String(Int(beforeNumber, radix: fromBase)!, radix:16)

        return [base2String, base8String, base10String, base16String]
    }

    // プロモードから呼び出される関数
    func transitionProMode(fromBase:Int, toBase:Int, beforeNum:String) throws -> String {

        if fromBase<2 || 36<fromBase || toBase<2 || 36<toBase {
            throw TransitionError.SomethingWrong
        } else if Int(beforeNum, radix: fromBase) == nil {
            throw TransitionError.WrongInputBase
        }

        return String(Int(beforeNum, radix: fromBase)!, radix:toBase)
    }

}
