# Your Task:
Create an iOS App "Products" implementing the Design from: https://xd.adobe.com/view/3baa5bee-4338-4368-acee-1c31d6f44d72-6ef9/

# The "Products" App
* After launch, the App should dynamically fetch products from https://shopreme.com/jobinterview/data/products_simple.json, and display them as cards in a vertically scrolling view.
* While the products are being loaded, an activity indicator and text shows the loading state.
* Tapping on one of the products opens a detail screen of the product.
* Tapping the upper right close button, or swiping from left to right from the screen, navigates back to the product overview.

## Architecture & Tools
- Deployment target: iOS 15
- Devices: iPhone only
- Portrait only
- MVVM
- Language: Swift 5.5
- UIKit

Don't be afraid to use libraries, but use them wisely.

# Data
The data returned from the backend is a json containing product infos. A product object looks like this: 
```json
{
    "id": "some id",
    "title": "Product title",
    "imageURL": "Url to image",
    "price": 1.59,
    "strikePrice": 2.0,
    "description": "Product description"
}
```
Take care that the `strikePrice` can be `nil`.

# Design
Your implementation doesn't have to be pixel perfect, but try to incorporate the margins, font sizes and colours from the design.
The grid layout should have two columns of products, regardless of screen size.

If you feel that something is not specified in enough detail, you can decide how you want to implement it – just be ready to explain your choices during the interview.

# Bonus Objectives
- Fancy transitions/animations where you think it would benefit the UX
- Use a different endpoint where products are contained within categories. The category titles should be displayed as headers. The endpoint for the categories is: https://shopreme.com/jobinterview/data/products_categories.json
- Handle and show errors ("No internet connection" etc.)
- Haptic feedback
- Unit tests for the ViewModels

These are some suggestions about improvements to the base app.
If you have another idea, feel free to get creative and surprise us!
You should try to incorporate at least some of the bonus objectives into your solution.
