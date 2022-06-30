//
//  ContentView.swift
//  RGBController-Watch WatchKit Extension
//
//  Created by omg on 2022/06/29.
//

import SwiftUI


extension UIColor {
    class func rgba(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    func toHex() -> String {
        var red: CGFloat     = 1.0
        var green: CGFloat   = 1.0
        var blue: CGFloat    = 1.0
        var alpha: CGFloat   = 1.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let r = Int(String(Int(floor(red*100)/100 * 255)).replacingOccurrences(of: "-", with: ""))!
        let g = Int(String(Int(floor(green*100)/100 * 255)).replacingOccurrences(of: "-", with: ""))!
        let b = Int(String(Int(floor(blue*100)/100 * 255)).replacingOccurrences(of: "-", with: ""))!
        let a = Int(String(Int(floor(alpha*100)/100 * 255)).replacingOccurrences(of: "-", with: ""))!

        let result = String(r, radix: 16).leftPadding(toLength: 2, withPad: "0") + String(g, radix: 16).leftPadding(toLength: 2, withPad: "0") + String(b, radix: 16).leftPadding(toLength: 2, withPad: "0")
            //+ String(a, radix: 16).leftPadding(toLength: 2, withPad: "0")
        return result
    }
}

extension String {
    // 左から文字埋めする
    func leftPadding(toLength: Int, withPad character: Character) -> String {
        let stringLength = self.count
        if stringLength < toLength {
            return String(repeatElement(character, count: toLength - stringLength)) + self
        } else {
            return String(self.suffix(toLength))
        }
    }
}


struct ContentView: View {
    @State var color:UIColor = UIColor.white;
    @State var text = "";
    
    @State var red:Double=255
    @State var green:Double=0
    @State var blue:Double=0
    
    @State var isSliding = false;
    var jsScript=""

    var body: some View {
        VStack(){
            Circle()
                .foregroundColor(Color.init(red: red/255, green: green/255,blue: blue/255))
                .shadow(color : Color.init(red: red/255, green: green/255,blue: blue/255) ,radius: 50)
                .frame(width: 10, height: 10, alignment: .center)
                .padding()
            
            Slider(value: $red, in : 0...255,onEditingChanged:{Bool in
                self.isSliding = Bool
            }).padding(.horizontal).accentColor(.red)
            Slider(value: $green, in : 0...255,onEditingChanged:{Bool in
                self.isSliding = Bool
            }).padding(.horizontal).accentColor(.green)
            Slider(value: $blue, in : 0...255 , onEditingChanged:{Bool in
                self.isSliding = Bool
            }).padding(.horizontal).accentColor(.blue)
            
            Button(action: {
                color=UIColor.rgba(red: Int(red), green: Int(green),blue: Int(blue), alpha: 0)
                let url = URL(string : "http://192.168.3.200:3000/api/rgb/"+color.toHex())!
                print(url)
                let request = URLRequest(url: url)
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard let data = data else { return }
                    do {
                        //
                    } catch let error {
                        //
                    }
                }
                task.resume()
                
            }){
                Text("Apply").accentColor(Color.init(red: red/255, green: green/255,blue: blue/255))
            }.shadow(color:Color.init(red: red/255, green: green/255,blue: blue/255) , radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/).border(Color.init(red: red/255, green: green/255,blue: blue/255) , width: 2).padding()

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


