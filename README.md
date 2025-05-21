
# pod2

[![CI Status](https://img.shields.io/travis/Sushil Milak/pod2.svg?style=flat)](https://travis-ci.org/Sushil Milak/pod2)
[![Version](https://img.shields.io/cocoapods/v/pod2.svg?style=flat)](https://cocoapods.org/pods/pod2)
[![License](https://img.shields.io/cocoapods/l/pod2.svg?style=flat)](https://cocoapods.org/pods/pod2)
[![Platform](https://img.shields.io/cocoapods/p/pod2.svg?style=flat)](https://cocoapods.org/pods/pod2)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

pod2 is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'pod2'
```

## Author

Sushil Milak, sushil.milak@va.gov

## License

pod2 is available under the MIT license. See the LICENSE file for more info.


## Notes

#######
# Pods folder. This is where MODEL is put. DEFINATION
## This is where initial model is kept.
## To use our ACS dependencies, open command prompt at Pods/Podfile  and 'pod install'.  Pods/Development Pods/pod1/Source/VFMPMainViewR cannot find ACS library error goes away.


### Where are my pods?

#### Command to create pods
/Users/sushil/Desktop/repo/login_module/pods/myPod/pod1
pod lib create pod1
make ios development target 16 at all places (targets, Pods project).

create repo at Github or Bitbucket.
For Github.
Create repo. Commit. Put tag. Commit. Once ready for release, DO A RELEASE before creating PUBLIC pod.
git init
git add -A
git commit -m "Message"
git remote add origin https://github.com/S**/blah.git ~
git push -u origin master

GIT release

Now publish for pod.
pod trunk register 'your email-id'
pod lib lint podlibrary**.podspec (from the project folder)
pod trunk push podlibrary**.podspec

now pod should be available, if it is public. Need to see how to do for PRIVATE.
We can do local as well.

How to use in other project:
Check the PodFile inside /Pods folder. Use this as a starter
OtherProject: pod init. Update pod file. pod install. pod update.

pod cache clean --all
pod --verbose --allow-warnings --no-clean  lib lint

Questions:
Where to put Firebase dependencies (podspec file or Package).
Trying adding SPM firebase (look inside beneproto podfile )


# pod2


//
//  AppDelegate.swift
//  pod2
//
//  Created by Sushil Milak on 05/21/2025.
//  Copyright (c) 2025 Sushil Milak. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

####

//
//  ViewController.swift
//  pod2
//
//  Created by Sushil Milak on 05/21/2025.
//  Copyright (c) 2025 Sushil Milak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

