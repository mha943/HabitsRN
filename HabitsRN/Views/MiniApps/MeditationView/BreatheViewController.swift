//
//  BreatheViewController.swift
//  HabitsRN
//
//  Created by Matthew Hall on 3/16/21.
//
import UIKit
import SwiftUI

class BreatheViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    
    let contentView = UIHostingController(rootView: myContentView())
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.view.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        
        addChild(contentView)
        view.addSubview(contentView.view)
        view.backgroundColor = UIColor.black
        
    }
}

struct myContentView : View {
    @State var isCenter = true
    @State var isCenter2 = true
    
    var body: some View{
        ZStack{
            let size: CGFloat = 150
            let shrink: CGFloat = 0.4
            let swell: CGFloat = 1.1
            
                //right
            Circle()
                .frame(width: size, height: size)
                .foregroundColor(Color.green.opacity(0.3))
                .offset(x: isCenter ? 0 : 75)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
                .scaleEffect(isCenter ? shrink : swell)
            Circle()//down
                .frame(width: size, height: size)
                .foregroundColor(Color.green.opacity(0.3))
                .offset(y: isCenter ? 0 : 75)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
                .scaleEffect(isCenter ? shrink : swell)
            Circle()//left
                .frame(width: size, height: size)
                .foregroundColor(Color.green.opacity(0.3))
                .offset(x: isCenter ? 0 : -75)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
                .scaleEffect(isCenter ? shrink : swell)
            Circle()//up
                .frame(width: size, height: size)
                .foregroundColor(Color.green.opacity(0.3))
                .offset(y: isCenter ? 0 : -75)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
                .scaleEffect(isCenter ? shrink : swell)
            Circle()//upleft
                .frame(width: size, height: size)
                .foregroundColor(Color.green.opacity(0.3))
                .offset(y: isCenter ? 0 : -60)
                .offset(x: isCenter ? 0 : -50)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
                .scaleEffect(isCenter ? shrink : swell)
            Circle()//upright
                .frame(width: size, height: size)
                .foregroundColor(Color.green.opacity(0.3))
                .offset(y: isCenter ? 0 : -60)
                .offset(x: isCenter ? 0 : 50)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
                .scaleEffect(isCenter ? shrink : swell)
            Circle()//downright
                .frame(width: size, height: size)
                .foregroundColor(Color.green.opacity(0.3))
                .offset(y: isCenter ? 0 : 60)
                .offset(x: isCenter ? 0 : 50)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
                .scaleEffect(isCenter ? shrink : swell)
            Circle()//downleft
                .frame(width: size, height: size)
                .foregroundColor(Color.green.opacity(0.3))
                .offset(y: isCenter ? 0 : 60)
                .offset(x: isCenter ? 0 : -50)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
                .scaleEffect(isCenter ? shrink : swell)
        }
        .onAppear(){
            let animation = Animation.linear(duration: 4).delay(0.75)
            withAnimation(animation.repeatForever(autoreverses: true)){
                self.isCenter = false
                self.isCenter2 = false
            }
            
            
        }
    }
}



