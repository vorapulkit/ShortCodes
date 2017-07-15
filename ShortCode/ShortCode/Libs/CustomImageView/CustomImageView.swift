

import UIKit

class CustomImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var imageURL: String?
    var btnReTry: UIButton?

    convenience init(imgURL : String?) {
        self.init()
        addTryButton()
        
        if imgURL != nil {
            self.imageURL = imgURL
            self.startDownlodingImage()
        }
        
    }
    
    
    private func addTryButton(){
        btnReTry = UIButton()
        btnReTry?.translatesAutoresizingMaskIntoConstraints = false;
        btnReTry?.addTarget(self, action: #selector(self.restartDownlodingImage), for: .touchUpInside)
        btnReTry?.backgroundColor = UIColor.red
        self.addSubview(btnReTry!)
        
    }
    
    @objc private func restartDownlodingImage(){
        
    }
    
    private func startDownlodingImage(){
        
    }
    
    
    
}
