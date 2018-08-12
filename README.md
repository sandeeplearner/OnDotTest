# OnDotTest

## Setup:
This project makes use of **Carthage** dependency manager. 

* Install Carthage by downloading the latest .pkg from [here](https://github.com/Carthage/Carthage/releases)
* Navigate to project's root folder. You should be seeing **Cartfile** when you list the rootfolder content. Now run `carthage update --platform iOS` on your terminal.
* Thats it! Now open the project by simply double clicking `OndotTest.xcodeproj`
* For more details about Carthage read [link1](https://www.raywenderlich.com/416-carthage-tutorial-getting-started), [link2](https://github.com/Carthage/Carthage)

## Why Carthage? Why Not Cocoapods?
This is a personal preference and completely opinion oriented answer. 
After using Cocoapods for almost 3+ years I have realized that cocoapods can be a curse,
if you dont fully understand all the project setting changes it makes to your project while creating workspace. 

Though Cocoapods makes the dependency setting as easy as typing two commands on terminal,
but it comes with the cost that, it creates a workspace and makes loads of setting changes under the hood. 
There might be cases especially when setting up CI/CD systems on your own or while adding 
external frameowkrs manually to project using Cocoapods, you will realize that some of the project settings modified by Cocoapods is not in sync with your requirement 
and might sometimes be a uphill task to fix it.

## MVVM and RxSift:
Project is designed to follow `MVVM` and extensively makes uses of `RxSwift` and its components. Though I personally prefer **VIPER**
over **MVVM** I couldnt justify the benifit **VIPER** would bring to table for such a small project. Hence sticked with **MVVM**
`RxSwift` happens to be one of the best programming component to use with **MVVM** and **VIPER**. 

`RxSwift` inherently supports **Pure Functional Programming** and works seemlesly with **MVVM**.
You can read all about RxSwift [here](https://github.com/ReactiveX/RxSwift).

## No Network Layer and Error handler added:
I could drag n drop my networklayer that is completely written in `RxSwift` and make it to respond with mock JSON if required. I believe its a overkill to
such a small assignment. If you are really interested in knowing how would I design my network and error handler layers you can read about in [my blog](https://learnwithmehere.blogspot.com/2016/09/simple-effective-and-robust-network.html)
Code is almost same with tiny bit of imporvements but completely restructured in compliance with RxSwift standards and makes use of `RxAlamofire`. 

If you want me to push the network layer for your assessment, feel free to comment/drop a mail, I will push the code ASAP.

# P.S:

Few of the actions like `loadRootVCAction` and `navigateToVC` might seem redundant, Because the assignment is really of two screens with limited features,
I have taken liberty to have redundant actions just to demonstrate multiple ways to acomplish the same task. Redundancy in the above mentioned actions are intentional :)

## Few of my own questions on SO that shaped my project design pattern
* https://stackoverflow.com/questions/48515599/how-to-avoid-force-type-casting-view-model-instance-in-child-view-controllers
* https://stackoverflow.com/questions/50232330/how-to-create-rxaction-to-enable-disable-button-if-text-in-uitextfield-is-va
