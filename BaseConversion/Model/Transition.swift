//
//  Transition.swift
//  BaseConversion
//
//  Created by 前田航汰 on 2021/08/13.
//

import Foundation

//n進数からn進数にするコード
class Transition{

    func transition(fromBase:Int, toBase:Int, beforeNum:String) throws -> String {
        if fromBase<2 || 36<fromBase || toBase<2 || 36<toBase {
            throw NSError(domain: "bigNum", code: -1, userInfo: nil)
        } else if Int(beforeNum, radix: fromBase) == nil {
            throw NSError(domain: "bigNum", code: -1, userInfo: nil)
        }

        return String(Int(beforeNum, radix: fromBase)!, radix:toBase)
    }

    func transitionSimpleMode(fromBase: Int, beforeNumber: String) throws -> [String] {
        if Int(beforeNumber, radix: fromBase) == nil {
            throw NSError(domain: "bigNum", code: -1, userInfo: nil)
        }

        let base2String = String(Int(beforeNumber, radix: fromBase)!, radix:2)
        let base8String = String(Int(beforeNumber, radix: fromBase)!, radix:8)
        let base10String = String(Int(beforeNumber, radix: fromBase)!, radix:10)
        let base16String = String(Int(beforeNumber, radix: fromBase)!, radix:16)

        return [base2String, base8String, base10String, base16String]
    }

}
