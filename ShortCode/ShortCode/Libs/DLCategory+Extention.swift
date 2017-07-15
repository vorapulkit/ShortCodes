

import Foundation
import UIKit



struct Name {
    
    let lblName:UILabel? = nil
    let txtName:UITextField? = nil
    /* TextView and TextField both 95% property same so we can use it 'txt */
    let txtVwName:UITextView? = nil
    let tblDoctor:UITableView? = nil
    let clnDoctor:UICollectionView? = nil
     /* for view we can use objectname first than view objectname always Start with 'small' and view always 'capital'  */
    let subView:UIView? = nil
    let popupView:UIView? = nil
    let calenderView:UIView? = nil
    
    let scrollCalender:UIScrollView? = nil
     /* scrollview use 'Controller' name batter than name Main  */
    let scrollMain:UIScrollView? = nil
    let scrollHospital:UIScrollView? = nil
    
    
    let segmentDepartment:UISegmentedControl? = nil
    let progressClock:UIProgressView? = nil
    
    //Sid
    let strName:String = ""
    let intCounter:Int = 0
    let int8Counter:Int8 = 0
    let intCtr:NSInteger = 0
    let fltPercentage:Float = 1.0
    let fltWidth:CGFloat=0.0
    let dblLocation:Double = 1.0
    
    let arrList:NSMutableArray
    let arrData:NSArray
    let dicData:NSDictionary
    let objModelClass:Any
    let fontHelvetica:UIFont
    let clrRed:UIColor
}


extension UIView{
    
    
    

    
    @IBInspectable var DLCorneredius:CGFloat{
        
        get{
            return layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var DLBorderWidth:CGFloat{
        
        get{
            return layer.borderWidth
        }
        set{
            self.layer.borderWidth = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var DLBorderColor:UIColor{
        
        get{
            return self.DLBorderColor
        }
        set{
            self.layer.borderColor = newValue.cgColor
            
        }
    }
    @IBInspectable var DLRoundDynamic:Bool{
        
        get{
            return false
        }
        set{
            if newValue == true {
                
                self.perform(#selector(UIView.afterDelay), with: nil, afterDelay: 0.1)
            }
            
        }
        
    }
    func afterDelay(){
        
        let  Height =  self.frame.size.height
        self.layer.cornerRadius = Height/2;
        self.layer.masksToBounds = true;
        
        
    }
    @IBInspectable var DLRound:Bool{
        get{
            return false
        }
        set{
            if newValue == true {
                self.layer.cornerRadius = self.frame.size.height/2;
                self.layer.masksToBounds = true;
            }
            
        }
    }
    @IBInspectable var DLShadow:Bool{
        get{
            return false
        }
        set{
            if newValue == true {
                self.layer.masksToBounds = false
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
                self.layer.shadowOpacity = 0.6;
                
            }
            
        }
        
    }
    @IBInspectable var DLclipsToBounds:Bool{
        get{
            return false
        }
        set{
            if newValue == true {
                
                self.clipsToBounds = true;
            }else{
                self.clipsToBounds = false
            }
            
        }
        
    }
    
    
    func shadowWith(alph:Float){
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = alph
    }
    
}

extension UILabel{
    
    @IBInspectable var FontAutomatic:Bool{
        get{
            return true
        }
        set{
            
            if newValue == true {
                
                let  height = (self.frame.size.height*ScreenSize.SCREEN_HEIGHT)/568;
                self.font = UIFont(name:self.font.fontName, size:(height*self.font.pointSize)/self.frame.size.height )
            }
            
        }
        
    }
    
 
    
}
extension UITextView {
    
    @IBInspectable var FontAutomatic:Bool{
        get{
            return true
        }
        set{
            
            if newValue == true {
                
                let  height = (self.frame.size.height*ScreenSize.SCREEN_HEIGHT)/568;
                self.font = UIFont(name:self.font!.fontName, size:(height*self.font!.pointSize)/self.frame.size.height )
            }
            
        }
        
    }
    
    
    
    
    @IBInspectable var Pedding:Bool{
        get{
            return true
        }
        set{
            
            if newValue == true {
                
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: self.frame.height))
                self.addSubview(paddingView)
            }
            
        }
        
    }
    
    
    
}
extension UITextField{
    
    @IBInspectable var FontAutomatic:Bool{
        get{
            return true
        }
        set{
            
            if newValue == true {
                
                let  height = (self.frame.size.height*ScreenSize.SCREEN_HEIGHT)/568;
                self.font = UIFont(name:self.font!.fontName, size:(height*self.font!.pointSize)/self.frame.size.height )
            }
            
        }
        
    }
    

  
    func setBottomBorder(_ color:UIColor, height:CGFloat) {
        
        var view = self.viewWithTag(2525)
        if view == nil {
            
            view = UIView(frame:CGRect(x: 0, y: self.frame.size.height - height, width:  self.frame.size.width, height: 1))
            view?.backgroundColor = color
            view?.tag = 2525
            self .addSubview(view!)
        }
        
        
    }
    
    
    @IBInspectable var Pedding:Bool{
        get{
            return true
        }
        set{
            
            if newValue == true {
                
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: self.frame.height))
                self.leftView = paddingView
                self.leftViewMode = UITextFieldViewMode.always                }
            
        }
        
    }
    
    
    func leftButton(image:UIImage?) {
        
        let btn = UIButton.init(type: .custom)
        btn.setImage(image, for: .normal)
        btn.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.height, height:  self.frame.size.height)
        self.leftView = btn;
        self.leftViewMode = .always
        // return btn
        
    }
    
    func rightButton(imageName:String) {
        
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        btn.frame = CGRect.init(x:  (ScreenSize.SCREEN_WIDTH - self.frame.size.height), y: 0, width: self.frame.size.height, height:  self.frame.size.height)
        self.rightView = btn;
        self.rightViewMode = .always
        // return btn
        
    }
       
    
    
}
extension UIButton{
    
    @IBInspectable var FontAutomatic:Bool{
        get{
            return true
        }
        set{
            
            if newValue == true {
                
                let  height = (self.frame.size.height*ScreenSize.SCREEN_HEIGHT)/568;
                self.titleLabel!.font = UIFont(name:self.titleLabel!.font!.fontName, size:(height*self.titleLabel!.font!.pointSize)/self.frame.size.height )!
            }
            
        }
        
    }
    
    
    
}
extension String{
    
    func isValidEmail() -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    func isValidName() -> Bool {
        
        if characters.count > 0 {
            return true
        }
        return false
        
        
    }
    func isValidPassWord() -> Bool {
        
        if characters.count > 4 {
            return true
        }
        return false
        
    }
    func isValidFullname() -> Bool {
        
        let emailRegEx = "^[A-Za-z]+(?:\\s[A-Za-z]+)"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
        
    }
    func isValidZipcode() -> Bool {
        
        if characters.count == 5 || characters.count == 6 {
            return true
        }
        return false
        
    }
    
    func isValidMobile() -> Bool {
        
        
        if characters.count == 10 {
            return true
        }
        return false
        
    }
    
    func isEmptyText() -> Bool {
        
        let string = self.trimmingCharacters(in: NSCharacterSet.whitespaces)
        return string.isEmpty
    }
    
    
}
extension UIScrollView{
    
    func AumaticScroller() {
        
        var contentRect = CGRect.zero
        for view in self.subviews{
            contentRect = contentRect.union(view.frame);
        }
        
        self.contentSize = contentRect.size;
    }
    func AumaticScrollerFaxible() {
        
        var contentRect = CGRect.zero
        for view in self.subviews{
            contentRect = contentRect.union(view.frame);
        }
        
        self.contentSize = CGSize(width: contentRect.width, height: contentRect.height + 60)
    }
    
    
}
extension UIImage{
    
    func DLresizeImage(_ newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    
}
extension UIViewController {
    
    func showNavigationBar(){
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.01938943379, green: 0.4767298698, blue: 0.2441024482, alpha: 1)
      //   self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white,NSFontAttributeName:UIFont.app_reguler(withSize: FONTSIZE.regulerSize)]
        self.navigationController?.navigationBar.isTranslucent = false;
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        
        
        
    }
    func showNavigationBarWithBack(){
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.01938943379, green: 0.4767298698, blue: 0.2441024482, alpha: 1)
        // self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white,NSFontAttributeName:UIFont.app_reguler(withSize: FONTSIZE.regulerSize)]
            self.navigationController?.navigationBar.isTranslucent = false;
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        
        let backItem = UIBarButtonItem.init(image:#imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(UIViewController.backViewController))
        backItem.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = backItem
        
        
        
    }
    
    func leftBarItem(image:UIImage,name:String?) -> UIBarButtonItem {
        
        let leftItem = UIBarButtonItem.init(image: image, style: .plain, target: self, action: nil)
        leftItem.title = name
        leftItem.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftItem
        return leftItem
    }
    func rightBarItem(image:UIImage?,name:String?) -> UIBarButtonItem {
        
        let rightItem = UIBarButtonItem.init(image: image, style: .plain, target: self, action: nil)
        rightItem.title = name
        rightItem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightItem
        return rightItem
    }
    
    func getBarButtonItem(image:UIImage?,name:String?)  -> UIBarButtonItem {
        
        let rightItem = UIBarButtonItem.init(image: image, style: .plain, target: self, action: nil)
        rightItem.title = name
        rightItem.tintColor = UIColor.white
        return rightItem
        
    }

    func backViewController() {
        
        self.navigationController!.popViewController(animated: true)
    }
    
    
}
