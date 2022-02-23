//
//  Transition.swift
//  BaseConversion
//
//  Created by 前田航汰 on 2021/08/13.
//

import Foundation

//n進数からn進数にするコード
class Transition{
    /*
    let numbers:Array = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    var testNum:String = "2986a"
    var testFromBase:Int = 16
    var testToBase:Int = 2
    var numArray:Array<String>!
    var ruizyouCount:Int = 0
    var sum10Base:Int = 0
    var joudge:String = "OK"
    var i:Int = 0
    var j:Int = 0
    
    var exponetiation = Exponentiation()
     */
    
    func transition(fromBase:Int, toBase:Int, beforeNum:String) throws -> String{
        if((fromBase<2 || 36<fromBase || toBase<2 || 36<toBase)){
            throw NSError(domain: "bigNum", code: -1, userInfo: nil)
        }else if(Int(beforeNum, radix: fromBase) == nil){
            throw NSError(domain: "bigNum", code: -1, userInfo: nil)
        }else if(beforeNum.isEmpty){
            throw NSError(domain: "bigNum", code: -1, userInfo: nil)
        }
        
        return String(Int(beforeNum, radix: fromBase)!, radix:toBase)
        
    }
    
    /*
    func transition2to95() -> Int{
        numArray = Array(arrayLiteral: testNum)
        ruizyouCount = testNum.count - 1
        sum10Base = 0
        
        //n進数から10進数へ
        //０〜渡された文字列の大きさ繰り返し
        for i in 0..<testNum.count{
            //値が正確な指定した進数で入力されているか判定
            if(joudge == "NO") {
                return(4444444444444444444)
            }
            joudge = "No"
            
            //０〜渡された進数の大きさまでの繰り返し、１文字ずつ表と照らし合わせる
            for j in 0..<testFromBase{
                if(numArray[i] == numbers[j]){
                    sum10Base += exponetiation.exponential(x: j, times: ruizyouCount)
                    ruizyouCount -= 1
                    joudge = "OK"
                }
            }
        }
        return sum10Base
    }
 */
}
