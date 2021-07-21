//
//  ViewController.swift
//  ChainAnimationForm
//
//  Created by Samuel Hyeman on 20/07/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var cointainerView: UIView!
    var currentPage:Int = 0
    var pages:Int = 2
    override func viewDidLoad() {
        super.viewDidLoad()
        let Page1 = CreatePage1VC()
        OpenPage(newPage: Page1,transitionfromLeft: true)
        // Do any additional setup after loading the view.
    }
    
    
    func ChangeState(oldPage:UIViewController,transitionFromLeft:Bool){
        RemovePage(oldPage: oldPage,transitionfromLeft: transitionFromLeft)
        switch currentPage {
        case 0:
            OpenPage(newPage: CreatePage1VC(),transitionfromLeft: transitionFromLeft)
        case 1:
            OpenPage(newPage: CreatePage2VC(),transitionfromLeft: transitionFromLeft)
        default:
            print("problem")
        }
    }

}

extension ViewController : PageDelegate{
    func next(child: UIViewController) {
        currentPage+=1
        ChangeState(oldPage: child,transitionFromLeft: true)
    }
    
    func previous(child: UIViewController) {
        currentPage-=1
        ChangeState(oldPage: child,transitionFromLeft: false)
    }
    
    
}






//All Pages
extension ViewController{
    
    func CreatePage1VC() -> Page1Controller {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
          // Instantiate View Controller
        let viewController = storyboard.instantiateViewController(withIdentifier: "Page1Controller") as! Page1Controller
        viewController.delegate = self
          // Add View Controller as Child View Controller
          return viewController
    }
    func CreatePage2VC() -> Page2Controller {
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
      // Instantiate View Controller
        let viewController = storyboard.instantiateViewController(withIdentifier: "Page2Controller") as! Page2Controller
        viewController.delegate = self
      // Add View Controller as Child View Controller
      return viewController
    }

    
}

//Page Fliping In and Out Animation
extension ViewController{
    
    func OpenPage(newPage : UIViewController?,transitionfromLeft:Bool) {
        var AnimationOptions = UIView.AnimationOptions()
        var xCordinate = CGFloat()
        if(transitionfromLeft){
            AnimationOptions = .transitionFlipFromLeft
            xCordinate = 1000
        }else{
            AnimationOptions = .transitionFlipFromRight
            xCordinate = -1000
        }
         addChild(newPage!)
        cointainerView.addSubview(newPage!.view)
        newPage!.view.frame = CGRect(x: xCordinate, y: 0, width: 0, height: 0)
        // call before adding child view controller's view as subview
        newPage!.didMove(toParent: self)
        
        UIView.animate(withDuration: 0.7, delay: 0.3, options: AnimationOptions) {
            newPage!.view.frame = self.cointainerView.bounds
            self.progressView.setProgress(Float(self.currentPage)/Float(self.pages), animated: true)
        
        }
    }
    
    
    
    
    
    func RemovePage(oldPage : UIViewController?,transitionfromLeft:Bool){
        var AnimationOptions = UIView.AnimationOptions()
        var xCordinate = CGFloat()
        if(transitionfromLeft){
            AnimationOptions = .transitionFlipFromLeft
            xCordinate = -1000
        }else{
            AnimationOptions = .transitionFlipFromRight
            xCordinate = 1000
        }
        UIView.animate(withDuration: 0.7, delay: 0.3, options: AnimationOptions,animations: {
            oldPage!.view.frame = CGRect(x: xCordinate, y:0, width: self.cointainerView.frame.width, height: self.cointainerView.frame.height)
        },completion: { (finished:Bool) in
            if(finished){
                oldPage?.willMove(toParent: nil)

                oldPage?.view.removeFromSuperview()

                            // call after removing child view controller's view from hierarchy
                oldPage?.removeFromParent()
            }
        })
                    // call before removing child view controller's view from hierarchy
    }
    
    
}
