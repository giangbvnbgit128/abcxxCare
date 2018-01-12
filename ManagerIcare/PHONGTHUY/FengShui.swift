//
//  PHONGTHUY.swift
//  MOD
//
//  Created by Bui Giang on 12/2/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import Foundation

enum Languge:String {
    case EN = "en-GB"
    case CNH = "zh-Hans-GB"
    case CNHK = "zh-HK"
    case VN = "vi-GB"
}

class FengShui {
    
    var arrayMenh:[String] = ["Kim","Thuỷ","Hoả","Thổ","Mộc"]
    var arrayDiaChi:[String] = ["Tý","Sửu","Dần","Mão","Thìn","Tị","Ngọ","Mùi","Thân","Dậu","Tuất","Hợi"]
    var arrayCanChi:[String] = ["Canh","Tân","Nhâm","Quý","Giáp","Ất","Bính","Đinh","Mậu","Kỷ"]
    var arrayCanChiWithMonth = ["Giáp","Ất","Bính","Đinh","Mậu","Kỷ","Canh","Tân","Nhâm","Quý"]
    var arrayMonthWithFengShui = ["Dần","Mão","Thìn","Tị","Ngọ","Mùi","Thân","Dậu","Tuất","Hợi","Tý","Sửu"]
    let ArrayGoodHourd:[String] = ["23h-1h","1h-3h","3h-5h","5h-7h","7h-9h","9h-11h","11h-13h","13h-15h","15h-17h","17h-19h","19h-21h","21h-23h"]
    
    let arrayMenhCN:[String] = ["金属","水","火","地球","木"]
    let arrayMenhEN:[String] = ["Metal", "Water", "Fire", "Earth", "Wood"]
    
    let arrayDiaChiCN:[String] = ["老 鼠","牛","老 虎","兔子","龍","蛇","馬","羊","猴子","雞","狗","猪"]
    let arrayDiaChiEN:[String] = ["The Rat","The Ox","The Tiger","The Cat","The Dragon","The Snake","The Horse","The Goat","The Monkey","The Rooster","The Dog","The Pig"]
    
    let arrayCanChiWithMonthCN:[String] = ["甲","乙","丙","丁","戊","己","庚","辛","壬","癸"]
    let arrayCanChiWithMonthEN:[String] = ["甲","乙","丙", "Ding", "Pe", "Gai", "庚", "Xin", "Ren", "Gui"]
    
    let arrayCanChiCN:[String] = ["庚","辛","壬","癸","甲","乙","丙","丁","戊","己"]
    let arrayCanChiEN:[String] = ["庚", "Xin", "Ren", "Gui","甲","乙","丙", "Ding", "Pe", "Gai"]
    
    let arrayMonthWithFengShuiCN:[String] = ["老 虎","兔子","龍","蛇","馬","羊","猴子","雞","狗","猪","老 鼠","牛"]
    let arrayMonthWithFengShuiEN:[String] = ["The Tiger","The Cat","The Dragon","The Snake","The Horse","The Goat","The Monkey","The Rooster","The Dog","The Pig","The Rat","The Ox"]
    
    var strDate:String = "Ngày"
    var strMonth:String = "Tháng"
    var strYear:String = "Năm"
    
    init() {
        
    }
    
    init(checnkg:Languge) {
        switch checnkg {
        case .CNH:
            self.arrayMenh.removeAll()
            self.arrayMenh = self.arrayMenhCN
            
            self.arrayDiaChi.removeAll()
            self.arrayDiaChi = self.arrayDiaChiCN
            
            self.arrayCanChi.removeAll()
            self.arrayCanChi = self.arrayCanChiCN
            
            self.arrayCanChiWithMonth.removeAll()
            self.arrayCanChiWithMonth = self.arrayCanChiWithMonthCN
            
            self.arrayMonthWithFengShui.removeAll()
            self.arrayMonthWithFengShui = self.arrayMonthWithFengShuiCN
            
            self.strDate = "日期"
            self.strMonth = "月"
            self.strYear = "年"
        case .EN:
            
            self.arrayMenh.removeAll()
            self.arrayMenh = self.arrayMenhEN
            
            self.arrayDiaChi.removeAll()
            self.arrayDiaChi = self.arrayDiaChiEN
            
            self.arrayCanChi.removeAll()
            self.arrayCanChi = self.arrayCanChiEN
            
            self.arrayCanChiWithMonth.removeAll()
            self.arrayCanChiWithMonth = self.arrayCanChiWithMonthEN
            
            self.arrayMonthWithFengShui.removeAll()
            self.arrayMonthWithFengShui = self.arrayMonthWithFengShuiEN
            
            self.strDate = "Date"
            self.strMonth = "Month"
            self.strYear = "Year"
            
        default:
            break
        }
    }
    
    func FindYearForFengShui(year:Int) -> String {
        let can:Int = year%10
        var dia:Int = 0
        let arrayChar = Array("\(year)")
        var socuoi:Int = Int(String(arrayChar[2]) + String(arrayChar[3])) ?? 0
        if year >= 2000 {
            socuoi = socuoi + 1000
        }
        dia = socuoi%12
        return "\(arrayCanChi[can])"+" \(arrayDiaChi[dia])"
    }
    
    func SubtractionDateWithTowMonth(firstDate: Date, secondDate:Date) -> Int {
        let calendar = NSCalendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: firstDate)
        let date2 = calendar.startOfDay(for: secondDate)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day ?? 0
    }
    
    func CurrentDateTime() -> (Int,Int,Int) {
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        return (day,month,year)
    }
    
    func convertStringToDateInt(startDate:String) -> (Int,Int,Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DataConfig.DATEFORMART //Your date format
        var date:Date = Date()
        let defauleDate = dateFormatter.date(from: "07-10-2017")!
        date = dateFormatter.date(from: startDate) ?? defauleDate
        
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        return (day,month,year)
    }
    
    func defaulDateTime() -> Date {
    
        let dateString1 = "04-10-2017"
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = DataConfig.DATEFORMART
        dateFormatter1.timeZone   = TimeZone(abbreviation: "GMT")
        dateFormatter1.locale = Locale.current
        let s = dateFormatter1.date(from:dateString1)
        print(s!)
        return s!
    }
    
    func converStringToDate(date:String) -> Date {
        let dateString1 = date
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = DataConfig.DATEFORMART
        dateFormatter1.timeZone   = TimeZone(abbreviation: "GMT")
        dateFormatter1.locale = Locale.current
        let s = dateFormatter1.date(from:dateString1)
        print(s!)
        return s!
    }
    // ArrayDiachi
    func getDayDiaChi() ->(Int,Int) {
        
        let parentDate = defaulDateTime()
        //        let firtDate = converStringToDate(date: "06-11-2017")
        let dateCurrent = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = DataConfig.DATEFORMART
        
        let countDay = self.SubtractionDateWithTowMonth(firstDate: parentDate, secondDate: dateCurrent)
        let IndexCanDi = countDay%10
        let IndexDiaChi = countDay%12
        
        return (IndexCanDi,IndexDiaChi)
    }
    
    func getDateMonthYearhWithFengShui() -> String {
        let parentDate = defaulDateTime()
//        let firtDate = converStringToDate(date: "06-11-2017")
        let dateCurrent = Date()
        let formatter = DateFormatter()
       formatter.dateFormat = DataConfig.DATEFORMART
        
        let countDay = self.SubtractionDateWithTowMonth(firstDate: parentDate, secondDate: dateCurrent)
        
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: dateCurrent)
        let month = calendar.component(.month, from: dateCurrent)
        
        
        let indexCan = year%10
        let indexMoth = month - 1
        var canYear:String = ""
        var indexCanYear:Int = 0
//        ["Canh","Tân","Nhâm","Quý","Giáp","Ất","Bính","Đinh","Mậu","Kỷ"]
//        let arrayCanChiWithMonthCN:[String] = ["甲","乙","丙","丁","戊","己","庚","辛","壬","癸"]
//        let arrayCanChiWithMonthEN:[String] = ["甲","乙","丙", "Ding", "Pe", "Gai", "G", "Xin", "Ren", "Gui"]
        switch indexCan {
        case 4,9: // arrayCanchi
            canYear = arrayCanChi[6]
            indexCanYear = 6
        case 0,5:
            canYear = arrayCanChi[8]
            indexCanYear = 8
        case 1,6:
            canYear = arrayCanChi[0]
            indexCanYear = 0
        case 2,7:
            canYear = arrayCanChi[2]
            indexCanYear = 2
        case 3,8:
            canYear = arrayCanChi[4]
            indexCanYear = 4
        default:
            canYear = arrayCanChi[6]
            indexCanYear = 0
        }
        
        var indexCanChiWMonth:Int = indexCanYear + indexMoth
        if indexCanChiWMonth > 10 {
            indexCanChiWMonth = indexCanChiWMonth - 10
        }
        
        let MothWithFengShui:String = "\(arrayCanChi[indexCanChiWMonth]) \(self.arrayMonthWithFengShui[indexMoth])"
        
        
        let IndexCanDi = countDay%10
        let IndexDiaChi = countDay%12
        
        return "\(strDate) \(self.arrayCanChiWithMonth[IndexCanDi]) \(self.arrayDiaChi[IndexDiaChi]), \(strMonth) \(MothWithFengShui), \(strYear) \(FindYearForFengShui(year: year))"
    }
    
    
    func getDateMonthYearhWithFengShui(currentDate:Date) -> String {
        let parentDate = defaulDateTime()
        //        let firtDate = converStringToDate(date: "06-11-2017")
        let dateCurrent = currentDate
        let formatter = DateFormatter()
        formatter.dateFormat = DataConfig.DATEFORMART
        
        let countDay = self.SubtractionDateWithTowMonth(firstDate: parentDate, secondDate: dateCurrent)
        
        let calendar = Calendar.current
        
        let year = dateCurrent.year//calendar.component(.year, from: dateCurrent)
        let month = dateCurrent.month//calendar.component(.month, from: dateCurrent)
        
        let indexCan = year%10
        let indexMoth = month - 1
        var canYear:String = ""
        var indexCanYear:Int = 0
        //        ["Canh","Tân","Nhâm","Quý","Giáp","Ất","Bính","Đinh","Mậu","Kỷ"]
        //        let arrayCanChiWithMonthCN:[String] = ["甲","乙","丙","丁","戊","己","庚","辛","壬","癸"]
        //        let arrayCanChiWithMonthEN:[String] = ["甲","乙","丙", "Ding", "Pe", "Gai", "G", "Xin", "Ren", "Gui"]
        switch indexCan {
        case 4,9: // arrayCanchi
            canYear = arrayCanChi[6]
            indexCanYear = 6
        case 0,5:
            canYear = arrayCanChi[8]
            indexCanYear = 8
        case 1,6:
            canYear = arrayCanChi[0]
            indexCanYear = 0
        case 2,7:
            canYear = arrayCanChi[2]
            indexCanYear = 2
        case 3,8:
            canYear = arrayCanChi[4]
            indexCanYear = 4
        default:
            canYear = arrayCanChi[6]
            indexCanYear = 0
        }
        
        var indexCanChiWMonth:Int = indexCanYear + indexMoth
        if indexCanChiWMonth > 10 {
            indexCanChiWMonth = indexCanChiWMonth - 10
        }
        
        let MothWithFengShui:String = "\(arrayCanChi[indexCanChiWMonth]) \(self.arrayMonthWithFengShui[indexMoth])"
        
        
        let IndexCanDi = countDay%10
        let IndexDiaChi = countDay%12
        
        return "\(strDate) \(self.arrayCanChiWithMonth[IndexCanDi]) \(self.arrayDiaChi[IndexDiaChi]), \(strMonth) \(MothWithFengShui), \(strYear) \(FindYearForFengShui(year: year))"
    }
    
//    let arrayDiaChi:[String] = ["Tý","Sửu","Dần","Mão","Thìn","Tị","Ngọ","Mùi","Thân","Dậu","Tuất","Hợi"]
    func getGoodHourd() -> String {
        let indexDiaChi = self.getDayDiaChi()
        var goodHoud:String = ""
        
        switch indexDiaChi.1 {
        case 2,8:
            goodHoud = self.ArrayGoodHourd[0] + ", " + self.ArrayGoodHourd[1] + ", " + self.ArrayGoodHourd[4] + ", " + self.ArrayGoodHourd[5] + ", " + self.ArrayGoodHourd[7] + ", " + self.ArrayGoodHourd[10]
        case 3,9:
            goodHoud = self.ArrayGoodHourd[0] + ", " + self.ArrayGoodHourd[2] + ", " + self.ArrayGoodHourd[3] + ", " + self.ArrayGoodHourd[6] + ", " + self.ArrayGoodHourd[7] + ", " + self.ArrayGoodHourd[9]
        case 4,10:
            goodHoud = self.ArrayGoodHourd[2] + ", " + self.ArrayGoodHourd[4] + ", " + self.ArrayGoodHourd[5] + ", " + self.ArrayGoodHourd[8] + ", " + self.ArrayGoodHourd[9] + ", " + self.ArrayGoodHourd[11]
        case 5,11:
            goodHoud = self.ArrayGoodHourd[1] + ", " + self.ArrayGoodHourd[4] + ", " + self.ArrayGoodHourd[6] + ", " + self.ArrayGoodHourd[7] + ", " + self.ArrayGoodHourd[10] + ", " + self.ArrayGoodHourd[11]
        case 6,0:
            goodHoud = self.ArrayGoodHourd[0] + ", " + self.ArrayGoodHourd[1] + ", " + self.ArrayGoodHourd[3] + ", " + self.ArrayGoodHourd[6] + ", " + self.ArrayGoodHourd[8] + ", " + self.ArrayGoodHourd[9]
        default:
            goodHoud = self.ArrayGoodHourd[2] + ", " + self.ArrayGoodHourd[3] + ", " + self.ArrayGoodHourd[5] + ", " + self.ArrayGoodHourd[8] + ", " + self.ArrayGoodHourd[10] + ", " + self.ArrayGoodHourd[11]
        }
        return goodHoud
    }
    
    func menhWithFengShui(yearOrBirth:Int) -> String {
        let can:Int = yearOrBirth%10
        var dia:Int = 0
        let arrayChar = Array("\(yearOrBirth)")
        var socuoi:Int = Int(String(arrayChar[2]) + String(arrayChar[3])) ?? 0
        if yearOrBirth >= 2000 {
            socuoi = socuoi + 1000
        }
        dia = socuoi%12
        
        var canNumber:Int = 0
        var diaNumber:Int = 0
        
//        ["Canh","Tân","Nhâm","Quý","Giáp","Ất","Bính","Đinh","Mậu","Kỷ"]
        
        switch can {
        case 4,5:
            canNumber = 1
        case 6,7:
            canNumber = 2
        case 8,9:
            canNumber = 3
        case 0,1:
            canNumber = 4
        case 2,3:
            canNumber = 5
        default:
            break
        }
//        ["Tý","Sửu","Dần","Mão","Thìn","Tị","Ngọ","Mùi","Thân","Dậu","Tuất","Hợi"]
        switch dia {
        case 0,1,6,7:
            diaNumber = 0
        case 2,3,8,9:
            diaNumber = 1
        case 4,5,10,11:
            diaNumber = 2
        default:
            break
        }
        var numberIndexMenh = canNumber + diaNumber
        if numberIndexMenh > 5 {
            numberIndexMenh = numberIndexMenh - 5
        }
        
        numberIndexMenh = numberIndexMenh - 1
        return "\(arrayMenh[numberIndexMenh])"
    }
    
    func numberLucky(yearOfBirth:Int) -> String {
        var dia:Int = 0
        let arrayChar = Array("\(yearOfBirth)")
        var socuoi:Int = Int(String(arrayChar[2]) + String(arrayChar[3])) ?? 0
        if yearOfBirth >= 2000 {
            socuoi = socuoi + 1000
        }
        dia = socuoi%12
        let arraysLuckNumber:[String] = ["00, 12, 24, 36, 48, 60, 72, 84, 96","01, 13, 25, 37, 49, 61, 73, 85, 97","02, 14, 26, 38, 50, 62, 74, 86, 98","03, 15, 27, 39, 51, 63, 75, 87, 99","04, 16, 28, 40, 52, 64, 76, 88","05, 17, 29, 41, 53, 65, 77, 89","06, 18, 30, 42, 54, 66, 78, 90","07, 19, 31, 43, 55, 67, 79, 91","08, 20, 32, 44, 56, 68, 80, 92","09, 21, 33, 45, 57, 69, 81, 93","10, 22, 34, 46, 58, 70, 82, 94","11, 23, 35, 47, 59, 71, 83, 95"]
        
        return arraysLuckNumber[dia]
    }
    
}
