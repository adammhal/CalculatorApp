//
//  ContentView.swift
//  Calculator
//
//  Created by Adam Mhal on 6/29/24.
//

import SwiftUI
import Foundation

var answer = 0

let operators : Set = ["+","-","×","÷"]

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
                                      calculate()
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
        if(justCalculated){
            toCalculate = ""
            justCalculated = false
        }
        toCalculate += String(x)
    }
    func addToString(x: String) {
        if(justCalculated){
            toCalculate = ""
            justCalculated = false
            return
        }
        toCalculate += x
    }
    
    func calculate(){
        var calculateArr = toCalculate.components(separatedBy: " ")
        answer = 0
        for i in 0..<calculateArr.count{
            print(calculateArr[i])
            if calculateArr[i] == "×"{
                let a:Int? = Int(calculateArr[i-1])
                let b:Int? = Int(calculateArr[i+1])
                answer =  a! * b!
                calculateArr[i] = String(answer)
                print(i)
                calculateArr[i+1] = "."
                calculateArr[i-1] = "."
                print(calculateArr)
            }
        }
        
        let num = onlyNum(nums: calculateArr)
        
        if(Int(num)! != -1){
            toCalculate = num
            justCalculated = true;
        }
    }
    func onlyNum(nums: [String]) -> String{
        var count = 0
        for c in nums{
            if Int(c) != nil{
                count+=1
            }
        }
        if count == 1{
            for c in nums{
                if Int(c) != nil{
                    return c
                }
            }
        }
        return String(-1)
    }
}



#Preview {
    ContentView()
}
