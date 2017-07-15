

import UIKit

// MARK:- SINGLETON classes

let QueueManagerClass : QueueManager = QueueManager.shared()


//let APPDELEGATE = (UIApplication.shared.delegate as! AppDelegate)
//let DBSINGLETON : DBSingleton = DBSingleton.sharedInstance

// MARK:- SCREEN SIZE
struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}
// MARK:- DEVICE TYPE
struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6_PLUS     = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}

//MARK: DB NAME JM
func getDataBaseName()->String
{
    return "AppDBName.sqlite"
}

// MARK: Set object in NSuserDefault :-
func kNSuserDefault(_ value:AnyObject, key:NSString){
    UserDefaults.standard.set(value, forKey: key as String )
    UserDefaults.standard.synchronize()
}

func kNSUserDefaultGetValue(_ key:String?)->AnyObject?{
    return UserDefaults.standard.value(forKey: key!) as AnyObject?
    
}

func kNSUserDefaultRemoveValueForkey(_ key:String?){
    UserDefaults.standard.removeObject(forKey: key!)
    UserDefaults.standard.synchronize()
}

//MARK: - Read Localozed File
func read_Localizable(_ title:String)->String{
    return  NSLocalizedString(title, comment: "")
}


// For WhiteSpace
func removeWhiteSpace(_ string : String) -> String
{
    return string.trimmingCharacters(in: CharacterSet.whitespaces)
}

func getDocumentDirectory() -> String {
    let paths: [Any] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory: String? = (paths[0] as? String)
    return documentsDirectory!
}

