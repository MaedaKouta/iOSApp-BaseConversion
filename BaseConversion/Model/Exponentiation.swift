//
//  Exponentiation.swift
//  BaseConversion
//
//  Created by 前田航汰 on 2021/08/13.
//

import Foundation

//累乗を行う
class Exponentiation{
    var num = 1
    func exponential(x:Int ,times:Int) -> Int{
        if(times == 0){
            return 1
        }else{
            for _ in 1..<times{
                num *= x
            }
            return num
        }
    }
}
