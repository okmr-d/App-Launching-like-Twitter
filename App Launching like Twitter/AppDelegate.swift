//
//  AppDelegate.swift
//  App Launching like Twitter
//
//  Created by Daiki Okumura on 2015/05/08.
//  Copyright (c) 2015 Daiki Okumura. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1)
        self.window!.makeKeyAndVisible()
        
        // rootViewController from StoryBoard
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var navigationController = mainStoryboard.instantiateViewControllerWithIdentifier("navigationController") as! UINavigationController
        self.window!.rootViewController = navigationController
        
        // logo mask
        navigationController.view.layer.mask = CALayer()
        navigationController.view.layer.mask.contents = UIImage(named: "logo.png")!.CGImage
        navigationController.view.layer.mask.bounds = CGRect(x: 0, y: 0, width: 60, height: 60)
        navigationController.view.layer.mask.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        navigationController.view.layer.mask.position = CGPoint(x: navigationController.view.frame.width / 2, y: navigationController.view.frame.height / 2)
        
        // logo mask background view
        var maskBgView = UIView(frame: navigationController.view.frame)
        maskBgView.backgroundColor = UIColor.whiteColor()
        navigationController.view.addSubview(maskBgView)
        navigationController.view.bringSubviewToFront(maskBgView)
        
        // logo mask animation
        let transformAnimation = CAKeyframeAnimation(keyPath: "bounds")
        transformAnimation.delegate = self
        transformAnimation.duration = 1
        transformAnimation.beginTime = CACurrentMediaTime() + 1 //add delay of 1 second
        let initalBounds = NSValue(CGRect: navigationController.view.layer.mask.bounds)
        let secondBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 50, height: 50))
        let finalBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 2000, height: 2000))
        transformAnimation.values = [initalBounds, secondBounds, finalBounds]
        transformAnimation.keyTimes = [0, 0.5, 1]
        transformAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        transformAnimation.removedOnCompletion = false
        transformAnimation.fillMode = kCAFillModeForwards
        navigationController.view.layer.mask.addAnimation(transformAnimation, forKey: "maskAnimation")
        
        // logo mask background view animation
        UIView.animateWithDuration(0.1,
            delay: 1.35,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {
                maskBgView.alpha = 0.0
            },
            completion: { finished in
                maskBgView.removeFromSuperview()
        })
        
        // root view animation
        UIView.animateWithDuration(0.25,
            delay: 1.3,
            options: UIViewAnimationOptions.TransitionNone,
            animations: {
                self.window!.rootViewController!.view.transform = CGAffineTransformMakeScale(1.05, 1.05)
            },
            completion: { finished in
                UIView.animateWithDuration(0.3,
                    delay: 0.0,
                    options: UIViewAnimationOptions.CurveEaseInOut,
                    animations: {
                        self.window!.rootViewController!.view.transform = CGAffineTransformIdentity
                    },
                    completion: nil
                )
        })
        
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        // remove mask when animation completes
        self.window!.rootViewController!.view.layer.mask = nil
    }

}

