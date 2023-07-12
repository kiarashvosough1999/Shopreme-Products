# The Task

I have created an iOS App "Shopreme-Products" and implemented the Design from ![XD Design](https://xd.adobe.com/view/3baa5bee-4338-4368-acee-1c31d6f44d72-6ef9/)

# The `Shopreme-Products` App

## Senarios

* After launch, the App dynamically fetch products from this ![API](https://shopreme.com/jobinterview/data/products_simple.json), and display them as cards in a vertically scrolling view.
* While the products are being loaded, an activity indicator and text shows the loading state.
* Tapping on one of the products opens a detail screen of the product.
* Tapping the upper right close button, or swiping from left to right from the screen, navigates back to the product overview.

## Architecture & Tools
- [x] Deployment target: iOS 15
- [x] Devices: iPhone only
- [x] Portrait only
- [x] MVVM + Clean
- [x] Language: Swift 5.5
- [x] UIKit

## Features and Bonuses

- [x] Design System(imported and used specified fonts and color and resuable compnnents) 
- [x] Two Columns List(Regarding the screen size)
- [x] Dynamic Page Routing
- [x] Unit-Tests
- [x] Dependency Managment
- [x] Self Implemented Network Layer
- [x] Fancy Animations and Transitions
- [x] Handled Errors
- [x] Used Sectioned Products List(from ![API](https://shopreme.com/jobinterview/data/products_categories.json))
- [x] Haptic Feedbacks
- [x] Image Caching

# Architecture Overview

![](./resources/diagram.png)
