

import UIKit
import CoreGraphics

/**
Adds framework-related methods to `UIImage`.
*/
public extension UIImage {
    /// Returns a copy of the image, taking into account its orientation
    public var imgly_normalizedImage: UIImage {
        if imageOrientation == .up {
            return self
        }
        
        return imgly_normalizedImageOfSize(size: size)
    }
    
    /**
    Returns a rescaled copy of the image, taking into account its orientation
    
    - parameter size: The size of the rescaled image.
    
    - returns: The rescaled image.
    
    :discussion: The image will be scaled disproportionately if necessary to fit the bounds specified by the parameter.
    */
    public func imgly_normalizedImageOfSize(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage!        
    }
    // 1200
    
    public func generateLowResolutionImage(maxLowResolutionSideLength:CGFloat) -> UIImage
    {
        let highResolutionImage = self
        let lowResolutionImage:UIImage;
        if highResolutionImage.size.width > maxLowResolutionSideLength || highResolutionImage.size.height > maxLowResolutionSideLength  {
            let scale: CGFloat
            
            if(highResolutionImage.size.width > highResolutionImage.size.height) {
                scale = maxLowResolutionSideLength / highResolutionImage.size.width
            } else {
                scale = maxLowResolutionSideLength / highResolutionImage.size.height
            }
            
            let newWidth  = CGFloat(roundf(Float(highResolutionImage.size.width) * Float(scale)))
            let newHeight = CGFloat(roundf(Float(highResolutionImage.size.height) * Float(scale)))
            
            lowResolutionImage = highResolutionImage.imgly_normalizedImageOfSize(size: CGSize(width: newWidth, height: newHeight))
        } else {
            lowResolutionImage = highResolutionImage.imgly_normalizedImage
        }
        return lowResolutionImage;
    }
}



extension UIImageOrientation: CustomStringConvertible {
    public var description: String {
        switch self {
        case .up: return "Up"
        case .down: return "Down"
        case .left: return "Left"
        case .right: return "Right"
        case .upMirrored: return "UpMirrored"
        case .downMirrored: return "DownMirrored"
        case .leftMirrored: return "LeftMirrored"
        case .rightMirrored: return "RightMirrored"
        }
    }
}
