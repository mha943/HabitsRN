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
    @IBOutlet weak var slider: UISlider!
    
    static var speed: Double!
    var contentView = UIHostingController(rootView: myContentView())
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.value = 3.15
        startAnimating()
        view.backgroundColor = UIColor.black
        BreatheViewController.speed = Double(slider.value)
        
    }
    
    func startAnimating(){
        contentView = UIHostingController(rootView: myContentView())
        let screenWidth  = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        contentView.view.center = CGPoint(x: screenWidth/2, y: screenHeight/2)
        addChild(contentView)
        view.addSubview(contentView.view)
    }
    //https://www.swiftbysundell.com/basics/child-view-controllers/
    // turn off animation when navigating away.
    func stopAnimating(content: UIViewController) {
        content.willMove(toParent: nil)
        content.view.removeFromSuperview()
        content.removeFromParent()
    }
    
    @IBAction func sliderRelease(_ sender: Any) {
        stopAnimating(content: contentView)
        BreatheViewController.speed = Double(slider.value)
        startAnimating()
    }
    
}

// SwiftUI code for Breathe Animation
struct myContentView : View {
    @State var isCenter = true
    @State var isCenter2 = true
    //    @State var randomColor: Color = Color(red: Double.random(in: 100...255)/255, green: Double.random(in: 150...255)/255, blue: Double.random(in: 100...255)/255, opacity: 0.2)
    @State var circleColor: Color = Color(red: 0/255, green: 255/255, blue: 100/255, opacity: 0.25)
    
    var body: some View{
        ZStack{
            //sets size of circle and how much it shrinks/grows
            let size: CGFloat = 150
            let shrink: CGFloat = 0.3
            let swell: CGFloat = 1.1
            
            Circle()//Background Circle
                .frame(width: size, height: size)
                .foregroundColor(self.circleColor)
                .scaleEffect(isCenter ? shrink/4 : swell*2.2)
                .blur(radius: 5)
            
            Circle()//right
                .frame(width: size, height: size)
                .foregroundColor(self.circleColor)
                .offset(x: isCenter ? 0 : 70)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : -270))
                .scaleEffect(isCenter ? shrink : swell)
                .blur(radius: 1)
            
            Circle()//down
                .frame(width: size, height: size)
                .foregroundColor(self.circleColor)
                .offset(y: isCenter ? 0 : 70)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : -270))
                .scaleEffect(isCenter ? shrink : swell)
                .blur(radius: 1)
            
            Circle()//left
                .frame(width: size, height: size)
                .foregroundColor(self.circleColor)
                .offset(x: isCenter ? 0 : -70)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : -270))
                .scaleEffect(isCenter ? shrink : swell)
                .blur(radius: 1)
            
            Circle()//up
                .frame(width: size, height: size)
                .foregroundColor(self.circleColor)
                .offset(y: isCenter ? 0 : -70)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : -270))
                .scaleEffect(isCenter ? shrink : swell)
                .blur(radius: 1)
            
            Circle()//upleft
                .frame(width: size, height: size)
                .foregroundColor(self.circleColor)
                .offset(y: isCenter ? 0 : -50)
                .offset(x: isCenter ? 0 : -50)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : -270))
                .scaleEffect(isCenter ? shrink : swell)
                .blur(radius: 1)
            
            Circle()//upright
                .frame(width: size, height: size)
                .foregroundColor(self.circleColor)
                .offset(y: isCenter ? 0 : -50)
                .offset(x: isCenter ? 0 : 50)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : -270))
                .scaleEffect(isCenter ? shrink : swell)
                .blur(radius: 1)
            
            Circle()//downright
                .frame(width: size, height: size)
                .foregroundColor(self.circleColor)
                .offset(y: isCenter ? 0 : 50)
                .offset(x: isCenter ? 0 : 50)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : -270))
                .scaleEffect(isCenter ? shrink : swell)
                .blur(radius: 1)
            
            Circle()//downleft
                .frame(width: size, height: size)
                .foregroundColor(self.circleColor)
                .offset(y: isCenter ? 0 : 50)
                .offset(x: isCenter ? 0 : -50)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : -270))
                .scaleEffect(isCenter ? shrink : swell)
                .blur(radius: 1)
        }
        .onAppear(){
//            let animation = Animation.easeInOut(duration: BreatheViewController.speed).delay(0.5)
            let animation = Animation.linear(duration: BreatheViewController.speed).delay(0.5)
            withAnimation(animation.repeatForever(autoreverses: true)){
                self.isCenter = false
                self.isCenter2 = false
            }
        }
    }
}



