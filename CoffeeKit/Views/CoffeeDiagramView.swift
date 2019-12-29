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
    
    let steamSizeRate: CGFloat = 0.2
    let coasterSizeRate: CGFloat = 0.07
    let titleAreaSizeRate: CGFloat = 0.2
    
    let handleSizeRate: CGFloat = 0.15
    
    //====================
    // Variables
    //====================
    var title: String
    var contents: [CoffeeContent]
    
    //==============================
    // Rect for content and margin
    //==============================
    struct Rect: Shape {
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
    
    //====================
    // Coaster
    //====================
    struct Coaster: Shape {
        func path(in rect: CGRect) -> Path {
            let bottomRadius: CGFloat = min(rect.width, rect.height)
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
    
    //==============================
    // Steam
    //==============================
    struct Steam: Shape {
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
    
    //===================================
    // Animation
    //-----------------------------------
    // <#Need to solve the rotation issue#>
    //===================================
    @State private var animationFinished = false
    
    func contentAnimation(dealy: Double) -> Animation {
        return Animation.spring(dampingFraction: 1)
            .speed(1.5)
            .delay(dealy * 0.5)
    }
    
    //========================================
    // View Body
    //----------------------------------------
    // swiftlint:disable function_body_length
    //========================================
    var body: some View {
        GeometryReader { proxy in
            self.useProxy(proxy)
        }
        .onAppear {
            //UIView.animate
            self.animationFinished.toggle()
        }
    }

    func useProxy(_ proxy: GeometryProxy) -> some View {
        let handleSize = proxy.size.height * self.handleSizeRate
        
        let steamWidth = proxy.size.width / 3
        let steamHeight = proxy.size.height * self.steamSizeRate
        
        let coasterWidth = proxy.size.width
        let coasterHeight = proxy.size.height * self.coasterSizeRate
        
        let titleAreaWidth = proxy.size.width
        let titleAreaHeight = proxy.size.height * self.titleAreaSizeRate
        
        let cupWidth = proxy.size.width - handleSize * 2 - self.cupLineWidth
        let cupHeight = proxy.size.height - steamHeight - coasterHeight - titleAreaHeight - self.cupLineWidth
        
        let contentTotalWidth = cupWidth - self.cupLineWidth
        let contentTotalHeight = cupHeight - self.cupLineWidth
        
        return VStack {
            VStack(spacing: 0) {
                //=========================
                // Steam (Temp)
                //=========================
                Steam()
                    .fill(Color.red)
                    .frame(width: steamWidth, height: steamHeight)
                
                //=========================
                // HStack (Cup + Handle)
                //=========================
                HStack(alignment: .top, spacing: 0) {
                    //====================
                    // Left Space
                    //====================
                    Handle()
                        .fill(Color.clear)
                        .frame(width: handleSize, height: handleSize)
                    
                    ZStack {
                        //===========================
                        // VStack (Contents)
                        //=========================
                        VStack(spacing: 0) {
                            ForEach(0 ..< self.contents.count) { i in
                                ZStack {
                                    Rect()
                                        .fill(self.contents[i].ingredient.color)
                                    
                                    Text(self.contents[i].ingredient.name)
                                        .padding(EdgeInsets(top: 0,
                                                            leading: self.cupLineWidth,
                                                            bottom: 0,
                                                            trailing: self.cupLineWidth))
                                        .lineLimit(1)
                                        .font(.system(size: 8))
                                        .minimumScaleFactor(0.01)
                                        .foregroundColor(self.labelColor)
                                }
                                .frame(width: contentTotalWidth, height: contentTotalHeight * self.contents[i].percent)
                                .scaleEffect(x: 1.0, y: self.animationFinished ? 1.0 : 0, anchor: .bottom)
                                .animation(self.contentAnimation(dealy: Double(self.contents.count - i)))
                            }
                            
                            //Bottom Margin
                            Rect()
                                .frame(width: contentTotalWidth, height: self.cupLineWidth / 2)
                        }
                        .frame(width: cupWidth, height: cupHeight, alignment: .bottom)
                        .mask(Cup())
                        
                        //====================
                        // Cup Border Stroke
                        //====================
                        Cup()
                            .stroke(self.cupColor, lineWidth: self.cupLineWidth)
                            .frame(width: cupWidth - self.cupLineWidth, height: cupHeight)
                    }
                    
                    //====================
                    // Handle Stroke
                    //====================
                    Handle()
                        .stroke(self.cupColor, lineWidth: self.cupLineWidth)
                        .frame(width: handleSize, height: handleSize)
                }
                
                //Bottom Margin
                Rect()
                    .fill(Color.clear)
                    .frame(width: cupWidth, height: self.cupLineWidth / 2)
                
                //=========================
                // Coaster
                //=========================
                Coaster()
                    .fill(self.cupColor)
                    .frame(width: coasterWidth, height: coasterHeight)
                
                //=========================
                // Title Area
                //=========================
                Text(self.title)
                    .frame(width: titleAreaWidth, height: titleAreaHeight)
                    .font(.system(size: 15))
            }
        }
    }
    // swiftlint:enable function_body_length
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
// Coffee Contents
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
        CoffeeDiagramView(title: "Americano", contents: americanoContent)
    }
}
