
import UIKit
let kMinute = 60
let kHour = kMinute * 60
let kDaySeconds = kHour * 24
let kDayMinutes = kMinute * 24
let kWeek = kDayMinutes * 7
let kMonth = kDayMinutes * 31
let kYear = kDayMinutes * 365
class DateValidator: NSObject
{
    
    class var sharedInstance:DateValidator
    {
        
        struct singleton_date
        {
            static let instance_new = DateValidator()
        }
        return singleton_date.instance_new
        
    }
    fileprivate func setDateFormat(_ dateFormatter : DateFormatter  ,dateFormat : String = "dd/MM/yyyy")
    {
        dateFormatter.dateFormat = dateFormat
    }
    //MARK: STRING TO DATE && DATE TO STRING
     func stringFromDate(_ date:Date,strDateFormat : String)-> String
     {
        let dateFormatter = DateFormatter()
        self.setDateFormat(dateFormatter,dateFormat: strDateFormat)
        let strDate =  dateFormatter.string(from: date)
        return strDate
    }
    func dateFromString(_ strDate:String,strDateFormat : String)-> Date?
    {
        let dateFormatter = DateFormatter()
        self.setDateFormat(dateFormatter,dateFormat: strDateFormat)
        let getNSDate =  dateFormatter.date(from: strDate)
        if((getNSDate) != nil)
        {
             return getNSDate!
        }else
        {
           
            return nil
        }
    }
    
    //MARK:TIMESTAMP FROM  (NSDATE AND STRINGDATE)
    func timestampFromDate(_ date : Date)->Int
    {
        let interval = Int(date.timeIntervalSince1970)
        return interval
    }
    func timestampFromDateString(_ strDate : String,strDateFormat : String)->Int
    {
    
        let dateFormatter = DateFormatter()
        self.setDateFormat(dateFormatter,dateFormat: strDateFormat)
        let date_new = dateFormatter.date(from: strDate)
        let interval = Int(date_new!.timeIntervalSince1970)
        return interval
    }
    
    //MARK:(NSDATE AND STRINGDATE) FROM TIMESTAMP
    func dateFromTimestamp(_ timeInterval : Double)->Date //JM EDITED INT TO DOUBLE
    {
        let date = Date(timeIntervalSince1970: TimeInterval(timeInterval))
        return date
    }
    func stringFromTimestamp(_ timeInterval : Double ,strDateFormat : String)->String //JM EDITED INT TO DOUBLE
    {
        let dateFormatter = DateFormatter()
        self.setDateFormat(dateFormatter,dateFormat: strDateFormat)
        let date = Date(timeIntervalSince1970: TimeInterval(timeInterval))
        return dateFormatter.string(from: date)
    }
    
    //MARK:CONVERT TIMESTAMP INTO (LOCAL AND UTC)
    func convertLocaleToUTCTimeZone(_ date : Date)->Date
    {
        let dateFormatter = DateFormatter()
         self.setDateFormat(dateFormatter,dateFormat: "dd/MM/yyyy hh:mm:ss")
        dateFormatter.timeZone = TimeZone(abbreviation:"UTC")!
        let strDate = dateFormatter.string(from: date)
       return dateFormatter.date(from: strDate)!
    }
    func convertUTCToLocaleTimeZone(_ date : Date)->Date
    {
        let dateFormatter = DateFormatter()
        self.setDateFormat(dateFormatter,dateFormat: "dd/MM/yyyy hh:mm:ss")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        let strDate = dateFormatter.string(from: date)
        return dateFormatter.date(from: strDate)!
    }
    
    //MARK: DATE EXIST BETWEEN 2 DATES
    func isDateExist(StartDate startDate: Date, EndDate endDate: Date,selectedDate : Date) -> Bool
    {

        let isExist = startDate.compare(selectedDate) == selectedDate.compare(endDate)
        if(isExist == false)
        {
            
            if startDate.compare(selectedDate) == ComparisonResult.orderedSame || endDate.compare(selectedDate) == ComparisonResult.orderedSame
            {
                 return true
            }
        }
        return isExist
    }
    func daysBetween(_ minDate : Date, maxDate :Date)->Int
    {
        let calendar: Calendar = Calendar.current
        let date1 = calendar.startOfDay(for: minDate)
        let date2 = calendar.startOfDay(for: maxDate)
        let components = (calendar as NSCalendar).components(.day, from: date1, to: date2, options: [])
        return components.day! + 1
        
    }
    
    func daysBetween(StartindDate minDate : Date,EndingDate maxDate :Date)->Int
    {
        let calendar: Calendar = Calendar.current
        let date1 = calendar.startOfDay(for: minDate)
        let date2 = calendar.startOfDay(for: maxDate)
        let components = (calendar as NSCalendar).components(.day, from: date1, to: date2, options: [])
        return components.day!
        
    }

    func getDates(_ startDate:Date, endDate:Date, strDateFormat : String) -> NSArray
    {
        let arrDates = NSMutableArray()
      
        let cal = Calendar.current
        var days = DateComponents()
        var dayCount = 0
        let dateFormatter = DateFormatter()
         self.setDateFormat(dateFormatter,dateFormat: strDateFormat)
         arrDates.add(dateFormatter.string(from: startDate))
         arrDates.add(dateFormatter.string(from: endDate))
        while true
        {
            days.day = dayCount
            let date:Date = (cal as NSCalendar).date(byAdding: days, to: startDate, options: NSCalendar.Options())!
            if date.compare(endDate) == .orderedDescending
            {
                break
            }
            dayCount += 1
            
            let dateNew = dateFormatter.string(from: date)
            arrDates.add(dateNew)
            
        }
        
        return arrDates
    }
    func getTimes(_ strStartTime : String,strEndTime : String, durationInMinutes : Int,is24HoursFormat : Bool) -> NSArray
    {
        let arrTimes = NSMutableArray()
        let cal = Calendar.current
        var days = DateComponents()
        var daymin = 0
        let dateFormatter = DateFormatter()
        if(is24HoursFormat == true)
        {
            dateFormatter.dateFormat = "HH:mm:ss"
        }else
        {
            dateFormatter.dateFormat = "hh:mm:ss a"
        }
        
        
        var strstartTime_new = strStartTime.replacingOccurrences(of: " ", with: "")
        strstartTime_new = strstartTime_new.replacingOccurrences(of: "AM", with: "")
        strstartTime_new = strstartTime_new.replacingOccurrences(of: "PM", with: "")
        strstartTime_new = strstartTime_new.replacingOccurrences(of: "am", with: "")
        strstartTime_new = strstartTime_new.replacingOccurrences(of: "pm", with: "")
        
        var strendTime_new = strEndTime.replacingOccurrences(of: " ", with: "")
        strendTime_new = strendTime_new.replacingOccurrences(of: "AM", with: "")
        strendTime_new = strendTime_new.replacingOccurrences(of: "PM", with: "")
        strendTime_new = strendTime_new.replacingOccurrences(of: "am", with: "")
        strendTime_new = strendTime_new.replacingOccurrences(of: "pm", with: "")
        
        
        
        let date1 = Date()
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        //start date
        var components = (calendar as NSCalendar).components([.year, .month, .day], from: date1)
        let arrayTime = strstartTime_new.components(separatedBy: ":") as NSArray
        components.hour = Int(arrayTime.object(at: 0) as! String)!
        components.minute = Int(arrayTime.object(at: 1) as! String)!
        let startDate = calendar.date(from: components)
        
        //end date
        var componentsEnd = (calendar as NSCalendar).components([.year, .month, .day], from: date1)
        let arrayTimeEnd = strendTime_new.components(separatedBy: ":") as NSArray
        componentsEnd.hour = Int(arrayTimeEnd.object(at: 0) as! String)!
        componentsEnd.minute = Int(arrayTimeEnd.object(at: 1) as! String)!
        let endDate = calendar.date(from: componentsEnd)
        while true
        {
            // days.hour = dayCount
            days.minute = daymin
            let date:Date = (cal as NSCalendar).date(byAdding: days, to: startDate!, options: NSCalendar.Options())!
            if date.compare(endDate!) == .orderedDescending
            {
                break
            }
            daymin  += durationInMinutes
            let newDate = dateFormatter.string(from: date)
            arrTimes.add(newDate)
            
        }
        
        return arrTimes
    }
    
    func calculateTotalMinutes(_ strStartTime : String,strEndTime : String)->Int
    {
        var strstartTime_new = strStartTime.replacingOccurrences(of: " ", with: "")
        strstartTime_new = strstartTime_new.replacingOccurrences(of: "AM", with: "")
        strstartTime_new = strstartTime_new.replacingOccurrences(of: "PM", with: "")
        strstartTime_new = strstartTime_new.replacingOccurrences(of: "am", with: "")
        strstartTime_new = strstartTime_new.replacingOccurrences(of: "pm", with: "")
        
        var strendTime_new = strEndTime.replacingOccurrences(of: " ", with: "")
        strendTime_new = strendTime_new.replacingOccurrences(of: "AM", with: "")
        strendTime_new = strendTime_new.replacingOccurrences(of: "PM", with: "")
        strendTime_new = strendTime_new.replacingOccurrences(of: "am", with: "")
        strendTime_new = strendTime_new.replacingOccurrences(of: "pm", with: "")
        
        let arrStartData = strstartTime_new.components(separatedBy: ":") as NSArray
        let intStratHour = Int(arrStartData.object(at: 0) as! String)! * 60
        let totalstartMin = intStratHour + Int(arrStartData.object(at: 1) as! String)!
        
        let arrEndData = strendTime_new.components(separatedBy: ":") as NSArray
        let intEndHour = Int(arrEndData.object(at: 0) as! String)! * 60
        let totalEndMin = intEndHour + Int(arrEndData.object(at: 1) as! String)!
        
      
        
        var newHours = 0
        if(totalstartMin > totalEndMin)
        {
            newHours = totalstartMin - totalEndMin
            
        }else if (totalEndMin > totalstartMin)
        {
            newHours = totalEndMin - totalstartMin
        }
        
        return newHours
    }
    //MARK: CALENDAR FUNCTION
    func dayOfWeek(_ date : Date)->Int
    {
        
        let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let myComponents = (myCalendar as NSCalendar).components(.weekday, from: date)
        let weekDay = myComponents.weekday
        return weekDay!
    }
    func startDateOfMonth(_ date : Date)->Date
    {
        let calendar = Calendar.current
        let myComponents = (calendar as NSCalendar).components([.year, .month], from: date)
        let startOfMonth = calendar.date(from: myComponents)?.addingTimeInterval(-1)
        return startOfMonth!
    }
    func dateByAddingMonths(_ monthsToAdd: Int,selectedDate : Date) -> Date?
    {
        
        let calendar = Calendar.current
        var months = DateComponents()
        months.month = monthsToAdd
        return (calendar as NSCalendar).date(byAdding: months, to: selectedDate, options: NSCalendar.Options(rawValue: 0))
    }
    func dateByAddingWeeks(_ weeksToAdd: Int,selectedDate : Date) -> Date?
    {
        let calendar = Calendar.current
        var months = DateComponents()
        months.weekOfMonth = weeksToAdd
        return (calendar as NSCalendar).date(byAdding: months, to: selectedDate, options: NSCalendar.Options(rawValue: 0))
    }
    
    func dateByAddingDays(_ daysToAdd: Int,selectedDate : Date) -> Date?
    {
        let calendar = Calendar.current
        var months = DateComponents()
        months.day = daysToAdd
        return (calendar as NSCalendar).date(byAdding: months, to: selectedDate, options: NSCalendar.Options(rawValue: 0))
    }
    
     func endDateOfMonth(_ date : Date) -> Date
     {
        
        let calendar = Calendar.current
        let plusOneMonthDate = dateByAddingMonths(1,selectedDate: date)
        let plusOneMonthDateComponents = (calendar as NSCalendar).components([.year , .month], from: plusOneMonthDate!)
        let endOfMonth = calendar.date(from: plusOneMonthDateComponents)?.addingTimeInterval(-1)
        return endOfMonth!
    }
    
    //MARK: TIME AGO
    func shortDescriptionOfTime(_ date :Date)->String
    {
        
        let deltaSeconds = Int(Date().timeIntervalSince(date))
        let deltaMinutes = deltaSeconds / 60
        
        var value: Int!
        
        if deltaSeconds < kMinute
        {
            // Seconds
            return String(format:"%@%@", stringFromFormat("%%d%@", withValue: deltaSeconds), NSDateTimeAgoLocalizedStrings("s"))
            
        } else if deltaMinutes < kMinute {
            // Minutes
            return String(format:"%@%@", stringFromFormat("%%d%@", withValue: deltaMinutes), NSDateTimeAgoLocalizedStrings("m"))
        } else if deltaMinutes < kDayMinutes {
            // Hours
            value = Int(floor(Float(deltaMinutes / kMinute)))
            return String(format:"%@%@", stringFromFormat("%%d%@", withValue: value), NSDateTimeAgoLocalizedStrings("h"))
        } else if deltaMinutes < kWeek {
            // Days
            value = Int(floor(Float(deltaMinutes / kDayMinutes)))
            return String(format:"%@%@", stringFromFormat("%%d%@", withValue: value), NSDateTimeAgoLocalizedStrings("w"))
        } else if deltaMinutes < kMonth {
            // Weeks
            value = Int(floor(Float(deltaMinutes / kWeek)))
            return String(format:"%@%@", stringFromFormat("%%d%@", withValue: value), NSDateTimeAgoLocalizedStrings("d"))
        } else if deltaMinutes < kYear {
            // Month
            value = Int(floor(Float(deltaMinutes / kMonth)))
            return String(format:"%@%@", stringFromFormat("%%d%@", withValue: value), NSDateTimeAgoLocalizedStrings("mo"))
        }
        
        // Years
        value = Int(floor(Float(deltaMinutes / kYear)))
        return String(format:"%@%@", stringFromFormat("%%d%@", withValue: value), NSDateTimeAgoLocalizedStrings("yr"))
    }

    func midiumDescriptionOfTime(_ date :Date)->String
    {
        
        let deltaSeconds = Int(Date().timeIntervalSince(date))
        let deltaMinutes = deltaSeconds / 60
        
        var value: Int!
        
        if deltaSeconds < kMinute
        {
            // Seconds
           return String(format:"%@%@", stringFromFormat("%%d%@", withValue: deltaSeconds), NSDateTimeAgoLocalizedStrings("second"))

        } else if deltaMinutes < kMinute {
            // Minutes
            return String(format:"%@%@", stringFromFormat("%%d%@", withValue: deltaMinutes), NSDateTimeAgoLocalizedStrings("minute"))
        } else if deltaMinutes < kDayMinutes {
            // Hours
            value = Int(floor(Float(deltaMinutes / kMinute)))
            return String(format:"%@%@", stringFromFormat("%%d%@", withValue: value), NSDateTimeAgoLocalizedStrings("hour"))
        } else if deltaMinutes < kWeek {
            // Days
            value = Int(floor(Float(deltaMinutes / kDayMinutes)))
            return String(format:"%@%@", stringFromFormat("%%d%@", withValue: value), NSDateTimeAgoLocalizedStrings("day"))
        } else if deltaMinutes < kMonth {
            // Weeks
            value = Int(floor(Float(deltaMinutes / kWeek)))
            return String(format:"%@%@", stringFromFormat("%%d%@", withValue: value), NSDateTimeAgoLocalizedStrings("week"))
        } else if deltaMinutes < kYear {
            // Month
            value = Int(floor(Float(deltaMinutes / kMonth)))
            return String(format:"%@%@", stringFromFormat("%%d%@", withValue: value), NSDateTimeAgoLocalizedStrings("month"))
        }
        
        // Years
        value = Int(floor(Float(deltaMinutes / kYear)))
        return String(format:"%@%@", stringFromFormat("%%d%@", withValue: value), NSDateTimeAgoLocalizedStrings("year"))
    }
    
    func longDescriptionOfTime(_ date :Date)->String
    {
      
        let deltaSeconds =  Int(Date().timeIntervalSince(date))
        let deltaMinutes = deltaSeconds / 60
        
        var value: Int!
        
        if deltaSeconds < 5 {
            // Just Now
            return NSDateTimeAgoLocalizedStrings("just now")
        } else if deltaSeconds < kMinute {
            // Seconds Ago
            return String(format:"%@%@", stringFromFormat("%%d %@", withValue: deltaSeconds), NSDateTimeAgoLocalizedStrings("seconds ago"))
        } else if deltaSeconds < 120 {
            // A Minute Ago
            return NSDateTimeAgoLocalizedStrings("one minute ago")
        } else if deltaMinutes < kMinute {
            // Minutes Ago
            return String(format:"%@%@", stringFromFormat("%%d %@", withValue: deltaMinutes),NSDateTimeAgoLocalizedStrings("minutes ago"))
        } else if deltaMinutes < 120 {
            // An Hour Ago
            return NSDateTimeAgoLocalizedStrings("one Hour ago")
        } else if deltaMinutes < kDayMinutes {
            // Hours Ago
            value = Int(floor(Float(deltaMinutes / kMinute)))
           return String(format:"%@%@", stringFromFormat("%%d %@", withValue: value), NSDateTimeAgoLocalizedStrings("hours ago"))
        } else if deltaMinutes < (kDayMinutes * 2) {
            // Yesterday
            return NSDateTimeAgoLocalizedStrings("yesterday")
        } else if deltaMinutes < kWeek
        {
            // Days Ago
            value = Int(floor(Float(deltaMinutes / kDayMinutes)))
            return String(format:"%@%@", stringFromFormat("%%d %@", withValue: value), NSDateTimeAgoLocalizedStrings("days ago"))
        } else if deltaMinutes < (kWeek * 2)
        {
            // Last Week
            return NSDateTimeAgoLocalizedStrings("last week")
        } else if deltaMinutes < kMonth {
            // Weeks Ago
            value = Int(floor(Float(deltaMinutes / kWeek)))
           
             return String(format:"%@%@", stringFromFormat("%%d %@", withValue: value), NSDateTimeAgoLocalizedStrings("weeks ago"))
        } else if deltaMinutes < (kDayMinutes * 61) {
            // Last month
            return NSDateTimeAgoLocalizedStrings("last month")
        } else if deltaMinutes < kYear {
            // Month Ago
            value = Int(floor(Float(deltaMinutes / kMonth)))
            return String(format:"%@%@", stringFromFormat("%%d %@", withValue: value), NSDateTimeAgoLocalizedStrings("months ago"))
            
        } else if deltaMinutes < (kDayMinutes * (kYear * 2)) {
            // Last Year
            return NSDateTimeAgoLocalizedStrings("last year")
        }
        
        // Years Ago
        value = Int(floor(Float(deltaMinutes / kYear)))
        return String(format:"%@%@", stringFromFormat("%%d %@", withValue: value),NSDateTimeAgoLocalizedStrings("years ago"))
        
    }
    
    fileprivate func NSDateTimeAgoLocalizedStrings(_ key: String) -> String {

       return  NSLocalizedString(key,comment:"")

    }
    fileprivate func stringFromFormat(_ format: String, withValue value: Int) -> String {
    
        let localeFormat = String(format: format, getLocaleFormatUnderscoresWithValue(Double(value)))
        let localizedString = localeFormat
         return String(format: localizedString, value)
    }
    
    fileprivate func getLocaleFormatUnderscoresWithValue(_ value: Double) -> String {
        
        let localeCode = Locale.preferredLanguages.first
        
        if localeCode == "ru" {
            let XY = Int(floor(value)) % 100
            let Y = Int(floor(value)) % 10
            
            if Y == 0 || Y > 4 || (XY > 10 && XY < 15) {
                return ""
            }
            
            if Y > 1 && Y < 5 && (XY < 10 || XY > 20) {
                return "_"
            }
            
            if Y == 1 && XY != 11 {
                return "__"
            }
        }
        
        return ""
    }
   
}
//********************Intput**************************

//  let startnewDate = dateOpertaion.dateFromString("15/5/2015", strDateFormat: "dd/MM/yyyy")
//  let endnewDate = dateOpertaion.dateFromString("18/5/2016", strDateFormat: "dd/MM/yyyy")
//  let selectedDate = dateOpertaion.dateFromString("18/5/2016", strDateFormat: "dd/MM/yyyy")

//  printLog(dateOpertaion.stringFromDate(NSDate(), strDateFormat: "EEEE MMMM yyyy hh:mm"))
//  printLog(dateOpertaion.dateFromString("22/12/2015 12:00:05", strDateFormat: "dd/MM/yyyy hh:mm:ss"))
//  printLog(dateOpertaion.timestampFromDate(NSDate()))
//  printLog(dateOpertaion.timestampFromDateString("01/01/2017"))
//  printLog(dateOpertaion.dateFromTimestamp(1453293776))
//  printLog(dateOpertaion.stringFromTimestamp(1453293776,strDateFormat: "dd MMMM yyyy"))
//  printLog(dateOpertaion.convertUTCToLocaleTimeZone(NSDate()))
//  printLog(dateOpertaion.convertLocaleToUTCTimeZone(NSDate()))
//  printLog(dateOpertaion.isDateExist(StartDate: startnewDate!, EndDate: endnewDate!, selectedDate: selectedDate!))
//  printLog(dateOpertaion.calculateTotalMinutes("1:00 PM", strEndTime: "5:00 AM"))
//  printLog(dateOpertaion.endDateOfMonth(startnewDate!))
//  printLog(dateOpertaion.startDateOfMonth(startnewDate!))
//  printLog(dateOpertaion.dayOfWeek(NSDate()))
//  printLog(dateOpertaion.dateByAddingMonths(-1, selectedDate: startnewDate!))
//  printLog(dateOpertaion.dateByAddingWeeks(-2, selectedDate: endnewDate!))
//  printLog(dateOpertaion.dateByAddingDays(-5, selectedDate: startnewDate!))
//  printLog(dateOpertaion.getTimes("1:00 AM", strEndTime: "18:00 PM", durationInMinutes:60, is24HoursFormat: false))
//  printLog(dateOpertaion.getDates(startnewDate!, endDate: endnewDate!, strDateFormat: "dd/MM/yyyy"))
//  printLog(dateOpertaion.longDescriptionOfTime(startnewDate!))
//  printLog(dateOpertaion.shortDescriptionOfTime(startnewDate!))




//***********Add below strings in application's localizable file**************

//    "second" = "s";
//    "minute" = "m";
//    "hour" = "h";
//    "week" = "w";
//    "day" = "d";
//    "month" = "mo";
//    "year" = "yr";
//
//    "justNow" = "Just now";
//    "secondsAgo" = "seconds ago";
//    "oneminuteAgo" = "A minute ago";
//    "minutesAgo" = "minutes ago";
//    "oneHourAgo" = "An hour ago";
//    "hoursAgo" = "hours ago";
//    "yesterday" = "Yesterday";
//    "daysAgo" = "days ago";
//    "lastWeek" = "Last week";
//    "weeksAgo" = "weeks ago";
//    "lastMonth" = "Last month";
//    "monthsago" = " months ago";
//    "lastYear" = "Last Year";
//    "yearsAgo" = "years ago";

//***************


