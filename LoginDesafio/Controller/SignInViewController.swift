//
//  ViewController.swift
//  LoginDesafio
//
//  Created by Idwall Go Dev 008 on 14/03/22.
//

import UIKit

class SignInViewController: UIViewController {
    
    lazy var signInView = SignInView()
    
    override func loadView() {
        self.view = signInView
    }
    
    //MARK: - File cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(signInView)
        // Do any additional setup after loading the view.
        //delegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(true)
       // Hide the Navigation Bar
       self.navigationController?.setNavigationBarHidden(true, animated: true)
   }

   override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(true)
       // Show the Navigation Bar
       self.navigationController?.setNavigationBarHidden(false, animated: false)
   }
    
}
