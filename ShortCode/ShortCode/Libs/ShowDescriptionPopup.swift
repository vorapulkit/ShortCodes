

import UIKit

class ShowDescriptionPopup: UIView {
    /** Default SimpleSelection*/
//    var selectionType : PopType = PopType.simpleSelect
//    var delegate : PopUpDelegate?
    var arrButtonTile : NSMutableArray = NSMutableArray()
    var baseView = UIView()
    var selction:Int?
    var arrSelectedOBJ = NSMutableArray()
    var popupArrowColor : UIColor! = UIColor.clear
    /** Defaul Font Raleway Regular And Size 15 */
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(descriptionText discription:String,toView temView : UIView,withFont font:UIFont,withColor popupColor:UIColor) {
        super.init(frame : ((UIApplication.shared.delegate as! AppDelegate).window?.frame)!)
        print(temView)
        self.popupArrowColor = popupColor

        //self.frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - (64 + (UIScreen.main.bounds.size.height * 0.07) ))
       (UIApplication.shared.delegate as! AppDelegate).window?.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        (UIApplication.shared.delegate as! AppDelegate).window?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[self]|", options: [], metrics: nil, views: ["self" : self]))
        (UIApplication.shared.delegate as! AppDelegate).window?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[self]|", options: [], metrics: nil, views: ["self" : self]))
        self.alpha = 0.01
        var topr = 2
        let bwidth = UIScreen.main.bounds.size.width * 0.23
        var bheight = discription.boundingRect(with:  CGSize(width: bwidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil).size.height + 17
        
        if bheight > UIScreen.main.bounds.size.height * 0.4 {
           bheight = UIScreen.main.bounds.size.height * 0.4
        }
        var point = temView.superview!.convert(temView.center, to: nil)
        let c = point.x
        var displayPoint = CGPoint(x: bwidth/2 , y: point.y) //let displayPoint = CGPoint(x: point.x , y: point.y)
        
        point.y = point.y + (temView.frame.size.height / 2) + 11
        point.x = point.x - (bwidth / 2)// - 15
        //if (point.y + bheight) > UIScreen.main.bounds.size.height {
            point.y = point.y - temView.frame.size.height - bheight - 21
            topr = 2
       // }
        if (point.x + bwidth) > UIScreen.main.bounds.size.width {
            
            point.x = point.x - 10 - (((point.x + bwidth) - (UIScreen.main.bounds.size.width)))
            displayPoint.x = c - point.x
        }
        self.backgroundColor = UIColor.clear
        baseView.frame = CGRect(x: point.x, y: point.y, width: bwidth, height: bheight)
        baseView.layer.cornerRadius = 5
        baseView.backgroundColor = popupArrowColor
        self.addSubview(baseView)
        let shapeLayer = CAShapeLayer()
        let pat = UIBezierPath()
        point.x = point.x - 7
        pat.move(to: CGPoint(x: 5, y: 0))

        pat.addQuadCurve(to: CGPoint(x:baseView.frame.size.width , y: 5), controlPoint: CGPoint(x: baseView.frame.size.width, y: 0))
        pat.addLine(to: CGPoint(x: baseView.frame.size.width, y: baseView.frame.size.height - 5))
        pat.addQuadCurve(to: CGPoint(x: baseView.frame.size.width - 5, y: baseView.frame.size.height), controlPoint: CGPoint(x: baseView.frame.size.width, y: baseView.frame.size.height))        
        if topr == 2  {
            pat.addLine(to: CGPoint(x: displayPoint.x + 5, y: baseView.frame.size.height))
            pat.addLine(to: CGPoint(x: displayPoint.x , y: baseView.frame.size.height + 10))
            pat.addLine(to: CGPoint(x: displayPoint.x - 5, y: baseView.frame.size.height))
            pat.addLine(to: CGPoint(x: 5, y: baseView.frame.size.height))
        }
//        else {
//            pat.addLine(to: CGPoint(x: 5, y: baseView.frame.size.height))
//        }
        pat.addQuadCurve(to: CGPoint(x: 0, y: baseView.frame.size.height - 5), controlPoint: CGPoint(x: 0, y: baseView.frame.size.height))
        pat.addLine(to: CGPoint(x: 0, y: 5))
        pat.addQuadCurve(to: CGPoint(x: 5, y: 0), controlPoint: CGPoint(x: 0, y: 0))
        pat.addLine(to: CGPoint(x: 5, y: 0))
        
        shapeLayer.fillColor = popupArrowColor.cgColor
        shapeLayer.path = pat.cgPath
        shapeLayer.lineWidth = 1
        shapeLayer.strokeColor = popupArrowColor.withAlphaComponent(1.0).cgColor
        shapeLayer.cornerRadius = 35
        shapeLayer.shadowOpacity = 0.3
        shapeLayer.shadowOffset = CGSize(width: -0.02,height: -2.5)
        //shapeLayer.shadowRadius = 3
        //shapeLayer.borderColor = UIColor.grayColor() .CGColor
        shapeLayer.shadowPath = pat.cgPath
        shapeLayer.shouldRasterize = true
        baseView.layer.addSublayer(shapeLayer) //insertSublayer(shapeLayer, atIndex: 0)
        
        print(discription)
        
        let lblTitle = self.getLabel(withTextColot: UIColor.white, withFont: font)
        lblTitle.text = discription
        lblTitle.textAlignment = .center
        lblTitle.numberOfLines = 0
        lblTitle.backgroundColor = popupArrowColor
        baseView.addSubview(lblTitle)
        

        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[lblTitle]-5-|", options: [], metrics: nil, views: ["lblTitle" : lblTitle]))
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lblTitle]|", options: [], metrics: nil, views: ["lblTitle" : lblTitle]))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        removePopView()
    }
    
    func showPopView(){
        self.alpha = 0.0
        (UIApplication.shared.delegate as! AppDelegate).window?.addSubview(self)
        UIView .animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: { () -> Void in
            self.alpha = 1
        }) { (flag : Bool) -> Void in
        }
    }
    
    func removePopView() {
        
        UIView .animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: { () -> Void in
            self.alpha = 0.01
        }) { (flag : Bool) -> Void in
            if flag {
                self.removeFromSuperview()
            }
        }
    }
    
    //MARK: get label
    private func getLabel(withTextColot objClr:UIColor,withFont objFont:UIFont) -> UILabel
    {
        let objLbl = UILabel()
        objLbl.translatesAutoresizingMaskIntoConstraints = false
        objLbl.font = objFont
        objLbl.clipsToBounds  =  true
        objLbl.textColor = objClr
        objLbl.backgroundColor = UIColor.clear
        return objLbl
    }
    
    fileprivate func checkTouching(_ point : CGPoint)->Bool {
        if point.x > baseView.frame.origin.x + baseView.frame.size.width || point.x < baseView.frame.origin.x {
            return true
        }
        else if point.y > baseView.frame.origin.y + baseView.frame.size.height || point.y < baseView.frame.origin.y {
            return true
        }
        return false
    }
    
    func addConstraintFunction(_ firstItem : AnyObject,FirstItemAttribure fAttribute:NSLayoutAttribute,relationIs relation:NSLayoutRelation,secondItem secondV:AnyObject?,SecondItemAttribure sAttribute:NSLayoutAttribute,multiplayer mu:CGFloat,constraint co:CGFloat,identifire strId:String?,addIn viewR:UIView)->Void {
        let horizontalConstraint = NSLayoutConstraint(item: firstItem, attribute:fAttribute, relatedBy: relation, toItem: secondV, attribute: sAttribute, multiplier: mu, constant: co)
        if strId != nil{
            horizontalConstraint.identifier = strId
        }
        viewR.addConstraint(horizontalConstraint)
    }
}
