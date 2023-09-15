//
//  CameraCaptureModelView.swift
//  Protocol
//
//  Created by Alex Serban on 14.09.2023.
//

import Foundation
import Photos
import UIKit

class CameraCaptureModelView: ObservableObject {
    
    @Published var entryImagesData = EntryImagesData()
    
    func addLocationDetailsToImage(_ image: UIImage, locationData: LocationData) -> UIImage? {
        // Create a graphics context
        UIGraphicsBeginImageContext(image.size)
        defer { UIGraphicsEndImageContext() }
        
        // Draw the original image
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        // Configure text attributes
        let textFont = UIFont.boldSystemFont(ofSize: 130) // Change the font and text size
        let textColor = UIColor.white // Text color
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left // Align text to the left
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: textFont,
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle,
        ]
        
        // Configure the text rect (top left corner)
        let textRect = CGRect(x: 10, y: 10, width: image.size.width - 20, height: image.size.height - 20)
        
        // Calculate the rect for the black background
        let blackRectHeight: CGFloat = 700 // Height of the black background area (you can adjust this value)
        let blackRect = CGRect(x: 0, y: 0, width: image.size.width, height: blackRectHeight)
        
        // Redefine black color with lower alpha component (0.7 for 70% opacity)
        let blackColor = UIColor.black.withAlphaComponent(0.9)
        
        // Create a black background with the adjusted color
        blackColor.setFill()
        UIRectFill(blackRect)
        
        // Text with location details
        let formattedText = """
        \(locationData.time)
        \(locationData.latitude)N \(locationData.longitude)E
        \(locationData.street) \(locationData.streetNumber), \(locationData.postalCode) \(locationData.city), \(locationData.country)
        """
        
        // Draw the text on the image with white color
        formattedText.draw(in: textRect, withAttributes: textAttributes)
        
        // Load the additional image from the assets
        if let iconImage = UIImage(named: "IconTechnoskopic") {
            // Calculate the position and size of the additional image
            let iconSize = CGSize(width: 600, height: 250) // Adjust the dimensions of the added image
            let iconRect = CGRect(x: image.size.width - iconSize.width - 10, y: image.size.height - iconSize.height - 10, width: iconSize.width, height: iconSize.height)
            
            // Draw the additional image on the image
            iconImage.draw(in: iconRect)
        }
        
        // Get the edited image from the graphics context
        let editedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        return editedImage
    }
    
    func saveImageData(image: UIImage) {
        if entryImagesData.firstImage == nil {
            entryImagesData.firstImage = image
        } else if entryImagesData.secondImage == nil {
            entryImagesData.secondImage = image
        }
    }
}

