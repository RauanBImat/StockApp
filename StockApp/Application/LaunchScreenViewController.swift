//
//  LaunchScreenViewController.swift
//  StockApp
//
//  Created by Рауан Абишев on 17.06.2022.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    


    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.animate()
        })
    }
    
    private func animate() {
        
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 2
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            
            self.imageView.frame = CGRect(x: -(diffX/2), y: diffY/2, width: size, height: size)
        })
        
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 0

        },completion: {done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                    let viewController = Assembly.assembler.tabbarController()
                    viewController.modalTransitionStyle = .crossDissolve
                    viewController.modalPresentationStyle = .fullScreen

                    self.present(viewController,animated: true)
                })
            }
        })
        
    }

    



}

