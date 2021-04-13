//
//  BreatheViewController.swift
//  HabitsRN
//
//  Created by Matthew Hall on 3/16/21.
//
import UIKit
import SwiftUI

class BreatheViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    
    static var speed: Double!
    
    // used to host a SwiftUI view into a UIViewController
    var contentView = UIHostingController(rootView: myContentView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setValues()
        startAnimating()
        
    }
    
    func setValues(){
        slider.value = 3.15
        view.backgroundColor = UIColor.black
        BreatheViewController.speed = Double(slider.value)
    }
    
    func startAnimating(){
        //sets the view to the center of the screen and starts animation
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
extension BreatheViewController{
    // sets the title and then adds a done button
    func setupNavBar(){
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:#selector(pressDone(_:)))
        navigationItem.rightBarButtonItem = doneButton
    }
    // done button returns to the main page
    @objc func pressDone(_ sender: UIBarButtonItem){
         navigationController?.popToRootViewController(animated: true)
    }
}



