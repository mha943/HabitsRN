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
        slider.value = 3.25
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
    
    var body: some View{
        ZStack{
            //sets size of circle and how much it shrinks/grows
            let size: CGFloat = 150
            let shrink: CGFloat = 0.25
            let swell: CGFloat = 1.1
            //let lightGreen = UIColor(displayP3Red: 0.1, green: 1, blue: 0.1, alpha: 0.2)

            Circle()//right
                .frame(width: size, height: size)
                .foregroundColor(Color.green.opacity(0.3))
                .offset(x: isCenter ? 0 : 75)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
                .scaleEffect(isCenter ? shrink : swell)
                .blur(radius: 1.0)
            Circle()//down
                .frame(width: size, height: size)
                .foregroundColor(Color.green.opacity(0.3))
                .offset(y: isCenter ? 0 : 75)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
                .scaleEffect(isCenter ? shrink : swell)
                .blur(radius: 1.0)
            Circle()//left
                .frame(width: size, height: size)
                .foregroundColor(Color.green.opacity(0.3))
                .offset(x: isCenter ? 0 : -75)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
                .scaleEffect(isCenter ? shrink : swell)
                .blur(radius: 1.0)
            Circle()//up
                .frame(width: size, height: size)
                .foregroundColor(Color.green.opacity(0.3))
                .offset(y: isCenter ? 0 : -75)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
                .scaleEffect(isCenter ? shrink : swell)
                .blur(radius: 1.0)
            Circle()//upleft
                .frame(width: size, height: size)
                .foregroundColor(Color.green.opacity(0.3))
                .offset(y: isCenter ? 0 : -60)
                .offset(x: isCenter ? 0 : -50)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
                .scaleEffect(isCenter ? shrink : swell)
                .blur(radius: 1.0)
            Circle()//upright
                .frame(width: size, height: size)
                .foregroundColor(Color.green.opacity(0.3))
                .offset(y: isCenter ? 0 : -60)
                .offset(x: isCenter ? 0 : 50)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
                .scaleEffect(isCenter ? shrink : swell)
                .blur(radius: 1.0)
            Circle()//downright
                .frame(width: size, height: size)
                .foregroundColor(Color.green.opacity(0.3))
                .offset(y: isCenter ? 0 : 60)
                .offset(x: isCenter ? 0 : 50)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
                .scaleEffect(isCenter ? shrink : swell)
                .blur(radius: 1.0)
            Circle()//downleft
                .frame(width: size, height: size)
                .foregroundColor(Color.green.opacity(0.3))
                .offset(y: isCenter ? 0 : 60)
                .offset(x: isCenter ? 0 : -50)
                .rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
                .scaleEffect(isCenter ? shrink : swell)
                .blur(radius: 1.0)
                
        }
        .onAppear(){
            let animation = Animation.linear(duration: BreatheViewController.speed).delay(0.5)
            withAnimation(animation.repeatForever(autoreverses: true)){
                self.isCenter = false
                self.isCenter2 = false
            }
        }
    }
}



