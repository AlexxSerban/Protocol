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
    
    func addLocationDetailsToImage(_ image: UIImage, locationData: LocationData) -> UIImage? {
        // Create a graphics context
        UIGraphicsBeginImageContext(image.size)
        defer { UIGraphicsEndImageContext() }
        
        // Draw the original image
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        // Configure text attributes
        let textFont = UIFont.boldSystemFont(ofSize: 130) // Schimbați fontul și dimensiunea textului
        let textColor = UIColor.white // Culoarea textului
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left // Alinierea textului la stânga
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: textFont,
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle,
        ]
        
        // Configure the text rect (top left corner)
        let textRect = CGRect(x: 10, y: 10, width: image.size.width - 20, height: image.size.height - 20)
        
        // Calculate the rect for the black background
        let blackRectHeight: CGFloat = 700 // Înălțimea zonei cu fundal negru (puteți ajusta această valoare)
        let blackRect = CGRect(x: 0, y: 0, width: image.size.width, height: blackRectHeight)
        
        // Redefiniți culoarea neagră cu o componentă alfa mai mică (0.7 pentru 70% opacitate)
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
            let iconSize = CGSize(width: 600, height: 250) // Ajustați dimensiunile imaginii adăugate
            let iconRect = CGRect(x: image.size.width - iconSize.width - 10, y: image.size.height - iconSize.height - 10, width: iconSize.width, height: iconSize.height)
            
            // Draw the additional image on the image
            iconImage.draw(in: iconRect)
        }
        
        // Get the edited image from the graphics context
        let editedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        return editedImage
    }



}
