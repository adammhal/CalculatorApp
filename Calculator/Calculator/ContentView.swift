//
//  ContentView.swift
//  Calculator
//
//  Created by Adam Mhal on 6/29/24.
//

import SwiftUI
import Foundation

var answer = 0.0

//let operators : Set = ["+","-","×","÷"]

let width = 70
let height = 70

struct ContentView: View {
    @State var toCalculate: String = ""
    @State private var didLongPress = false;
    @State var justCalculated = false;
    var body: some View {
        ZStack{
            Image("bg")
                .resizable()
                .ignoresSafeArea()
            VStack{
                ZStack{
                    Text(toCalculate)
                        .offset(y: 0)
                        .foregroundColor(.black)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .controlSize(.extraLarge)
                        .frame(width: 300, height: 200)
                    
                    HStack{
                        Spacer()
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 200)
                            .padding([.top, .leading, .trailing], 37.0)
                            .shadow(radius: 60)
                        Spacer()
                    }.foregroundColor(.secondary)
                }
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        addToString(x: 1)
                    }, label: {
                        Image("1")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    })
                    Button(action: {
                        addToString(x: 2)
                    }, label: {
                        Image("2")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    })
                    Button(action: {
                        addToString(x: 3)
                    }, label: {
                        Image("3")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    })
                    Button(action: {
                        if toCalculate != ""{
                            addToString(x: " + ")
                        }
                    }, label: {
                        Image("plus")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    })
                }
                HStack{
                    Spacer()
                    Button(action: {
                        addToString(x: 4)
                    }, label: {
                        Image("4")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    })
                    Button(action: {
                        addToString(x: 5)
                    }, label: {
                        Image("5")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    })
                    Button(action: {
                        addToString(x: 6)
                    }, label: {
                        Image("6")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    })
                    Button(action: {
                        if toCalculate != ""{
                            addToString(x: " - ")
                        }
                    }, label: {
                        Image("minus")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    })
                }
                HStack{
                    Spacer()
                    Button(action: {
                        addToString(x: 7)
                    }, label: {
                        Image("7")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    })
                    Button(action: {
                        addToString(x: 8)
                    }, label: {
                        Image("8")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    })
                    Button(action: {
                        addToString(x: 9)
                    }, label: {
                        Image("9")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    })
                    Button(action: {
                        if toCalculate != ""{
                            addToString(x: " × ")
                        }
                    }, label: {
                        Image("multi")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    })
                }
                HStack{
                    Spacer()
                    Button(action: {
                        addToString(x: 0)
                    }, label: {
                        Image("0")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    })
                    Button(action: {
                        if(isValid(num: toCalculate)){
                            if toCalculate != ""{
                                toCalculate = negate(num: toCalculate)
                            }
                        } else {
                            toCalculate = "INVALID INPUT"
                        }
                        
                    }, label: {
                        Image("plusminus")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    })
                    Button(action: {
                        if self.didLongPress {
                                self.didLongPress = false
                                  toCalculate = ""
                              } else {
                                  if toCalculate != ""{
                                      if(isValid(num: toCalculate)){
                                          calculate()
                                      } else {
                                          toCalculate = "INVALID INPUT"
                                      }
                                  }
                              }
                    }, label: {
                        Image("equal")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    }).simultaneousGesture(LongPressGesture().onEnded { _ in
                        self.didLongPress = true
                        let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                        impactHeavy.impactOccurred()
                    })
                    Button(action: {
                        if toCalculate != ""{
                            addToString(x: " ÷ ")
                        }
                    }, label: {
                        Image("divide")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                    })
                }
                
                Spacer()
                
                
                
                
                    
            }
        }
    }
    func addToString(x: Int) {
        if toCalculate == "INVALID INPUT"{
            toCalculate = ""
        }
        if(justCalculated){
            toCalculate = String(x)
            justCalculated = false
        } else {
            toCalculate += String(x)
        }
        
    }
    func addToString(x: String) {
        if toCalculate == "INVALID INPUT"{
            toCalculate = ""
            return
        }
        if(justCalculated){
            toCalculate += x
            justCalculated = false
        } else {
            toCalculate += x       
        }
    }
    
    func calculate(){
        var calculateArr = toCalculate.components(separatedBy: " ")
        answer = 0
        for i in 0..<calculateArr.count{
            if calculateArr[i] == "×"{
                let left = firstValidIndex(nums: calculateArr, start: i, left: true)
                let right = firstValidIndex(nums: calculateArr, start: i, left: false)
                let a:Double? = Double(calculateArr[left])
                let b:Double? = Double(calculateArr[right])
                answer =  a! * b!
                calculateArr[i] = String(answer)
                calculateArr[left] = "."
                calculateArr[right] = "."
//                print(calculateArr)
            }
            if calculateArr[i] == "÷"{
                let left = firstValidIndex(nums: calculateArr, start: i, left: true)
                let right = firstValidIndex(nums: calculateArr, start: i, left: false)
                let a:Double? = Double(calculateArr[left])
                let b:Double? = Double(calculateArr[right])
                if(b! == 0){
                    toCalculate = "INVALID INPUT"
                    return
                }
                answer =  a! / b!
                calculateArr[i] = String(answer)
                calculateArr[left] = "."
                calculateArr[right] = "."
//                print(calculateArr)
            }
        }
        for i in 0..<calculateArr.count{
            if calculateArr[i] == "+"{
                let left = firstValidIndex(nums: calculateArr, start: i, left: true)
                let right = firstValidIndex(nums: calculateArr, start: i, left: false)
                let a:Double? = Double(calculateArr[left])
                let b:Double? = Double(calculateArr[right])
                answer =  a! + b!
                calculateArr[i] = String(answer)
                calculateArr[left] = "."
                calculateArr[right] = "."
//                print(calculateArr)
            }
            if calculateArr[i] == "-"{
                let left = firstValidIndex(nums: calculateArr, start: i, left: true)
                let right = firstValidIndex(nums: calculateArr, start: i, left: false)
                let a:Double? = Double(calculateArr[left])
                let b:Double? = Double(calculateArr[right])
                answer =  a! - b!
                calculateArr[i] = String(answer)
                calculateArr[left] = "."
                calculateArr[right] = "."
//                print(calculateArr)
            }
        }
        
        let num = onlyNum(nums: calculateArr)
        
//        print(num)
        let temp = Double(num)!
        if(Int(temp) != -1){
            if isNotDecimal(num: Double(num)!){
                toCalculate = String(Int(temp))
                justCalculated = true;
            } else {
                toCalculate = num
                justCalculated = true;
            }
        }
    }
    func onlyNum(nums: [String]) -> String{
        var count = 0
        for c in nums{
//            print(Double(c) as Any)
            if Double(c) != nil{
                count+=1
            }
        }
        if count == 1{
            for c in nums{
                if Double(c) != nil{
                    return c
                }
            }
        }
        return String(-1)
    }
    
    func firstValidIndex(nums: [String], start: Int, left: Bool) -> Int{
        if(left){
            var i = start
            while Double(nums[i]) == nil {
                i-=1
            }
            return i
        }
        var i = start
        while Double(nums[i]) == nil {
            i+=1
        }
        return i
    }
    
    func isNotDecimal(num: Double) -> Bool{
        return num == floor(num)
    }
    
    func rebuildString(nums: [String]) -> String{
        var finalString = ""
        for i in 0..<nums.count{
            if i == 0{
                finalString += nums[0]
            } else {
                finalString += " " + nums[i]
            }
        }
        return finalString
    }
    
    func negate(num: String) -> String{
        var calculateArr = num.components(separatedBy: " ")
        if calculateArr.count == 1{
            let temp = Double(calculateArr[0])!
            if isNotDecimal(num: temp){
                return String(Int(temp) * -1)
            } else {
                return String(temp * -1)
            }
        } else {
            let temp = Double(calculateArr[calculateArr.count - 1])!
            if isNotDecimal(num: temp){
                calculateArr[calculateArr.count - 1] = String(Int(temp) * -1)
                return rebuildString(nums: calculateArr)
            } else {
                calculateArr[calculateArr.count - 1] = String(temp * -1)
                return rebuildString(nums: calculateArr)
            }
        }
    }
    
    func isValid(num: String) -> Bool{
        let calculateArr = num.components(separatedBy: " ")
        var alternate = false
        for i in 0..<calculateArr.count{
            if(!alternate){
                if Double(calculateArr[i]) == nil {
                    return false
                }
                alternate = !alternate
            } else {
                if Double(calculateArr[i]) != nil {
                    return false
                }
                alternate = !alternate
            }
        }
        if(Double(calculateArr[calculateArr.count - 1]) == nil){
            return false
        }
        return true
    }
}



#Preview {
    ContentView()
}
