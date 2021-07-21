//
//  Page2Controller.swift
//  ChainAnimationForm
//
//  Created by Samuel Hyeman on 21/07/2021.
//

import UIKit

class Page2Controller: UIViewController {

    var delegate:PageDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func continueButtonPressed(_ sender: Any) {
        delegate?.next(child: self)
    }
    
    @IBAction func previousButtonPressed(_ sender: Any) {
        delegate?.previous(child: self)
    }
}
