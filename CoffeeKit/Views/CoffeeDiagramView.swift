//  Copyright © 2019 SwiftPeerLabSydney. All rights reserved.

import SwiftUI

struct CoffeeIngredient {
    var name: String
    var color: Color
}

struct CoffeeContent {
    var ingredient: CoffeeIngredient
    var percent: CGFloat
}

struct CoffeeDiagramView: View {
    //====================
    // Constants
    //====================
    let cupColor: Color = Color(red: 66/255, green: 42/255, blue: 26/255)
    let cupLineWidth: CGFloat = 5
    
    let labelColor: Color = Color(red: 66/255, green: 42/255, blue: 26/255)
    
    let handleSizeRate: CGFloat = 0.15
    let safeHorizontalPaddingRate: CGFloat = 0.05
    
    //====================
    // Variables
    //====================
    var contents: [CoffeeContent]
    
    //====================
    // Cup
    //====================
    struct Cup: Shape {
        func path(in rect: CGRect) -> Path {
            let bottomRadius: CGFloat = min(rect.width, rect.height) * 0.1
            var path = Path()
            
            //Top Line
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            
            //Right Bottom Arc
            path.addArc(center: CGPoint(x: rect.maxX - bottomRadius, y: rect.maxY - bottomRadius),
                        radius: bottomRadius,
                    startAngle: .degrees(0),
                      endAngle: .degrees(90),
                     clockwise: false)
            
            //Left Bottom Arc
            path.addArc(center: CGPoint(x: rect.minX + bottomRadius, y: rect.maxY - bottomRadius),
                        radius: bottomRadius,
                        startAngle: .degrees(90),
                        endAngle: .degrees(180),
                        clockwise: false)
            
            //Left Line
            path.closeSubpath()
            
            return path
        }
    }
    
    struct Content: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
            path.closeSubpath()
            
            return path
        }
    }
    
    //====================
    // Handle
    //====================
    struct Handle: Shape {
        func path(in rect: CGRect) -> Path {
            let handleSize: CGFloat = min(rect.width, rect.height)
            let handleRadius = handleSize
            var path = Path()

            //Outter Arc
            path.addArc(center: CGPoint(x: rect.minX, y: rect.minY + handleRadius),
                radius: handleRadius,
            startAngle: .degrees(-90),
              endAngle: .degrees(90),
             clockwise: false)
            
            return path
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                //=========================
                // HStack (Cup + Handle)
                //=========================
                HStack(alignment: .top, spacing: 0) {
                    ZStack {
                        //===========================
                        // VStack (Contents)
                        //=========================
                        VStack(spacing: 0) {
                            ForEach(0 ..< self.contents.count) { i in
                                ZStack {
                                    Content()
                                        .fill(self.contents[i].ingredient.color)
                                    
                                    Text(self.contents[i].ingredient.name)
                                        .padding(EdgeInsets(top: 0,
                                                            leading: self.cupLineWidth / 2,
                                                            bottom: 0,
                                                            trailing: self.cupLineWidth / 2))
                                        .lineLimit(1)
                                        .font(.system(size: 10))
                                        .minimumScaleFactor(0.01)
                                        .foregroundColor(self.labelColor)
                                }
                                .frame(width: geometry.size.width, height: geometry.size.height * self.contents[i].percent)
                            }
                        }
                        .frame(width: geometry.size.width - geometry.size.height * self.handleSizeRate,
                               height: geometry.size.height  - self.cupLineWidth, alignment: .bottom)
                        .mask(Cup())
                        
                        //====================
                        // Cup Border Stroke
                        //====================
                        Cup()
                            .stroke(self.cupColor, lineWidth: self.cupLineWidth)
                            .frame(width: geometry.size.width - geometry.size.height * self.handleSizeRate,
                                   height: geometry.size.height - self.cupLineWidth)
                    }
                    
                    //====================
                    // Handle Stroke
                    //====================
                    Handle()
                        .stroke(self.cupColor, lineWidth: self.cupLineWidth)
                        .frame(width: geometry.size.height * self.handleSizeRate, height: geometry.size.height * self.handleSizeRate - self.cupLineWidth)
                }
                .padding(EdgeInsets(top: 0,
                                    leading: geometry.size.width * (self.safeHorizontalPaddingRate),
                                    bottom: 0,
                                    trailing: geometry.size.width * self.safeHorizontalPaddingRate))
            }
        }
    }
}

//====================
// Ingredients
//====================
let hotWater = CoffeeIngredient(name: "HOT WATER", color: Color(red: 129/255, green: 194/225, blue: 172/255))
let espresso = CoffeeIngredient(name: "ESPRESSO", color: Color(red: 227/255, green: 99/225, blue: 24/255))
let milkForm = CoffeeIngredient(name: "MILK FORM", color: Color(red: 202/255, green: 219/225, blue: 180/255))
let steamedMilk = CoffeeIngredient(name: "STEAMED MILK", color: Color(red: 153/255, green: 128/225, blue: 64/255))
let whippedCream = CoffeeIngredient(name: "WHIPPED CREAM", color: Color(red: 189/255, green: 234/225, blue: 227/255))
let chocolateSyrup = CoffeeIngredient(name: "CHOCOLATE SYRUP", color: Color(red: 196/255, green: 218/225, blue: 180/255))
let milk = CoffeeIngredient(name: "MILK", color: Color(red: 231/255, green: 228/225, blue: 227/255))
let coffee = CoffeeIngredient(name: "COFFEE", color: Color(red: 233/255, green: 202/225, blue: 146/255))

//====================
// Coffee Contentsgr
//====================
var espressoContent: [CoffeeContent] = [CoffeeContent(ingredient: espresso, percent: 0.3)]

var macchiatoContent: [CoffeeContent] = [
    CoffeeContent(ingredient: milkForm, percent: 0.2),
    CoffeeContent(ingredient: espresso, percent: 0.3),
]

var conPannaContent: [CoffeeContent] = [
    CoffeeContent(ingredient: whippedCream, percent: 0.2),
    CoffeeContent(ingredient: espresso, percent: 0.3),
]

var caffeLatteContent: [CoffeeContent] = [
    CoffeeContent(ingredient: espresso, percent: 0.3),
    CoffeeContent(ingredient: steamedMilk, percent: 0.5),
    CoffeeContent(ingredient: whippedCream, percent: 0.2),
]

var flatCoffeeContent: [CoffeeContent] = [
    CoffeeContent(ingredient: steamedMilk, percent: 0.4),
    CoffeeContent(ingredient: espresso, percent: 0.3)]

var caffeBreveContent: [CoffeeContent] = [
    CoffeeContent(ingredient: milkForm, percent: 0.3),
    CoffeeContent(ingredient: steamedMilk, percent: 0.4),
    CoffeeContent(ingredient: espresso, percent: 0.3)]

var cappuccinoContent: [CoffeeContent] = [
    CoffeeContent(ingredient: milkForm, percent: 0.5),
    CoffeeContent(ingredient: steamedMilk, percent: 0.2),
    CoffeeContent(ingredient: espresso, percent: 0.3)]

var cafeMochaContent: [CoffeeContent] = [
    CoffeeContent(ingredient: whippedCream, percent: 0.15),
    CoffeeContent(ingredient: steamedMilk, percent: 0.3),
    CoffeeContent(ingredient: chocolateSyrup, percent: 0.15),
    CoffeeContent(ingredient: espresso, percent: 0.4)]

var americanoContent: [CoffeeContent] = [
    CoffeeContent(ingredient: hotWater, percent: 0.7),
    CoffeeContent(ingredient: espresso, percent: 0.3)]

var latteMacchiato: [CoffeeContent] = [
    CoffeeContent(ingredient: espresso, percent: 0.25),
    CoffeeContent(ingredient: steamedMilk, percent: 0.75)]

var redEyeContent: [CoffeeContent] = [
    CoffeeContent(ingredient: coffee, percent: 0.70),
    CoffeeContent(ingredient: espresso, percent: 0.30)]

var cafeAuLaitContent: [CoffeeContent] = [
    CoffeeContent(ingredient: milk, percent: 0.50),
    CoffeeContent(ingredient: coffee, percent: 0.50)]

struct CoffeeDiagramView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeDiagramView(contents: americanoContent)
    }
}
