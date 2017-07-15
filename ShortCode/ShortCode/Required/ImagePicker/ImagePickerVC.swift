
import UIKit
import MobileCoreServices
import PhotosUI
import AVKit
import AVFoundation

/*
 How to use image picker vc class
func presentVC(CompletionBlock:@escaping (_ result: AnyObject) -> Void) {
    let vc = ImagePickerVC()
    vc.completionBlock = CompletionBlock
    vc.isEditingAllowed = true
    vc.isImageProcessing = true
    self.present(vc, animated: true, completion: nil)
}
 
 
 self.presentVC { (result) in
 if let Img = result as? UIImage{
 print("Image is captured")
 }
 if let video = result as? String{
 print("Image is stored")
 }
 }
 
*/

let APPDELEGATE = (UIApplication.shared.delegate as! AppDelegate)


typealias CompletionBlock = (_ result: AnyObject) -> Void
typealias ImageimgPicker = (_ image:AnyObject?) -> Void


class ImagePickerVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    //MARK:
    //MARK: Variables
    
    var completionBlock : CompletionBlock?
    var isEditingAllowed : Bool?
    var isImageProcessing : Bool?
    
    fileprivate let maxResolution = CGSize(width: 3000, height: 3000)
    fileprivate let resetImageSize = CGFloat(1000.0)
    fileprivate var imgPicker: ImageimgPicker?
    fileprivate let videoCaption = "TestVideo"


    //MARK:
    //MARK:UI
    
    override func viewDidLoad() {
        super.viewDidLoad()

        defaultInit()
 
        // Do any additional setup after loading the view.
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    fileprivate func defaultInit(){
        self.showImagePickerOption(self.view) { (obj) in
            
            if (obj != nil){
                self.completionBlock!(obj!)
            }
            
            self.dismiss(animated: true, completion:nil)
        }
    }
    
    //MARK:- Show Image Optionals
    fileprivate func showImagePickerOption(_ sourceView:UIView,completionHandler handler:ImageimgPicker?) {
        
        let galleryAction = UIAlertAction(title:"Gallery", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
            self.checkPermisssionForImage(UIImagePickerControllerSourceType.photoLibrary,PermissionProvided: { (result) in
                if(result){
                    self.showCameraOrGallery(UIImagePickerControllerSourceType.photoLibrary)
                }
            })
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (UIAlertAction) -> Void in
            self.dismiss(animated: true, completion: nil)
        })
        
        let alerActionSheet = UIAlertController(title:"Profile Imag", message:"please select option", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
                self.checkPermisssionForImage(UIImagePickerControllerSourceType.camera,PermissionProvided:{(result) in
                    if(result){
                        self.showCameraOrGallery(UIImagePickerControllerSourceType.camera)
                    }
                })
            })
            alerActionSheet.addAction(cameraAction)
        }
        
        alerActionSheet.addAction(galleryAction)
        alerActionSheet.addAction(cancelAction)
        alerActionSheet.popoverPresentationController?.sourceView = sourceView
        alerActionSheet.popoverPresentationController?.sourceRect = CGRect(x: sourceView.bounds.width / 2.0, y: sourceView.bounds.height / 2.0, width: 1.0, height: 1.0)
        APPDELEGATE.window?.rootViewController?.present(alerActionSheet, animated: true, completion: nil)
        imgPicker = handler
    }
    fileprivate func showCameraOrGallery(_ source:UIImagePickerControllerSourceType) {
        let imag = UIImagePickerController()
        imag.delegate = self
        imag.sourceType = source;
        imag.mediaTypes = (isImageProcessing == true ? [kUTTypeImage as String] : [kUTTypeMovie as String])
        imag.allowsEditing = isEditingAllowed!
        APPDELEGATE.window?.rootViewController?.present(imag, animated: true, completion: nil)
    }
    
    //MARK:- Image Picker Delegate Method
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if (isImageProcessing)!{
            let success = validateImage(info: info).0
            let img = validateImage(info: info).1
            
            if let handler = imgPicker {
                handler(img)
            }
            if(!success)
            {
                print("validation failed")
            }
        }else{
            
            let success = validateVideo(info: info).0
            let videoData = validateVideo(info: info).1
            
            if let handler = imgPicker {
                handler(videoData as AnyObject?)
            }
            if(!success)
            {
                print("validation failed")
            }
        }
        

        self.dismiss(animated: true, completion: nil)

        imgPicker = nil
    }
    
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        if let handler = imgPicker {
            handler(nil)
        }
        imgPicker = nil
    }
    
    //MARK:- Check Permission Method
    
    fileprivate func checkPermisssionForImage(_ sourceType:UIImagePickerControllerSourceType,PermissionProvided:@escaping (_ result: Bool) -> Void) {
        if(sourceType == .camera){
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted:Bool) in
                if(granted){
                    
                    DispatchQueue.main.async(execute: {
                        PermissionProvided(true)
                    })
                } else {
                    let permissionAlert = UIAlertController(title: "Permission", message: "App don't have a permission to access the Camera please go to the setting give the permission.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    let settingAction = UIAlertAction(title: "Setting", style: .default, handler: { (UIAlertAction) -> Void in
                        
                        let url = URL(string:UIApplicationOpenSettingsURLString)!
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                        
                    })

                    permissionAlert.addAction(okAction)
                    permissionAlert.addAction(settingAction)
                    
                    DispatchQueue.main.async(execute: {
                        APPDELEGATE.window?.rootViewController!.present(permissionAlert, animated: true, completion: nil)
                        PermissionProvided(false)
                    })
                }
            })
            
        } else {
            
            PHPhotoLibrary.requestAuthorization({(status:PHAuthorizationStatus)in
                switch status
                {
                case .notDetermined , .authorized :
                    DispatchQueue.main.async(execute: {
                        PermissionProvided(true)
                    })
                    break
                    
                case .denied , .restricted:
                    let permissionAlert = UIAlertController(title: "Permission", message: "App don't have a permission to access the photos please go to the setting give the permission.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    let settingAction = UIAlertAction(title: "Setting", style: .default, handler: { (UIAlertAction) -> Void in
                        
                        
                        let url = URL(string:UIApplicationOpenSettingsURLString)!
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                        
                    })
                    
                    permissionAlert.addAction(okAction)
                    permissionAlert.addAction(settingAction)
                    DispatchQueue.main.async(execute: {
                        APPDELEGATE.window?.rootViewController!.present(permissionAlert, animated: true, completion: nil)
                        PermissionProvided(false)
                    })
                    break
                }
            })
        }
    }
    
    //MARK:- Validate Image
   fileprivate func validateImage(info : [String : Any])->(Bool,UIImage?){
        
        var image : UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage

        //Resolution will be Priorotise first
        if (image.size.width) > maxResolution.width || (image.size.height) > maxResolution.height //Max Resolution
        {
            image = image.generateLowResolutionImage(maxLowResolutionSideLength: resetImageSize)
            return (true,image)
        }
        
        if (isEditingAllowed == true){//Edited Image
            if let img = info[UIImagePickerControllerEditedImage] as? UIImage
            {
                image = img
                return (true,img)
            }
        }
 
        //Original Image
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            return (true,img)
        }
        
        return (false,nil)
        
    }
    //MARK:- Validate Image
    fileprivate func validateVideo(info : [String : Any])->(Bool,String?){
        
        let vedioUrl = info[UIImagePickerControllerMediaURL] as? URL
        let asset = AVAsset(url: vedioUrl!)
        let currentVideoDuration : CMTime = asset.duration
        
        let durationInSeconds: Double = CMTimeGetSeconds(currentVideoDuration)
        let minutes: Double = floor(durationInSeconds / 60)

        if (minutes > 1)//If greated than 1 Min
        {
            return (false,nil)
        }else{
            let myVideoVarData = try! Data(contentsOf: vedioUrl!)
            
            let tempPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let tempDocumentsDirectory: AnyObject = tempPath[0] as AnyObject
            let tempDataPath = tempDocumentsDirectory.appendingPathComponent(String(format:"%@.mov",videoCaption)) as String
            try? myVideoVarData.write(to: URL(fileURLWithPath: tempDataPath), options: [])
            return (true,getDefaultVedioPath())
        }
        
        
    }
    
    func getDefaultVedioPath()->String{
        return String(format:"%@/%@.mov",getDocumentDir(),videoCaption);
    }
 
  //MARK:Common Video
   fileprivate func getDocumentDir()->String{
        let tempPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let tempDocumentsDirectory: AnyObject = tempPath[0] as AnyObject
        return (tempDocumentsDirectory as? String)!
        
    }
    deinit{
        print("Deallocated ImagePickerVC")
    }
}
