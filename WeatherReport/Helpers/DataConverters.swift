//
//  Converters.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/26/23.
//

import Foundation
import UIKit


final class DataConverters {
    
    static let shared = DataConverters()
    
    
    // Форматирование даты в формат:  17:48,  пт 16 апреля
    func formatDate1(unixDateToConvert: Int64) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(unixDateToConvert))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm,  E d MMMM"
        dateFormatter.timeZone = NSTimeZone() as TimeZone
        
        let localDate: String = dateFormatter.string(from: date as Date)
        return localDate
    }
    
    
    // Форматирование даты в формат:   20/01
    func formatDate2(unixDateToConvert: Int64) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(unixDateToConvert))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/M"
        dateFormatter.timeZone = NSTimeZone() as TimeZone
        
        let localDate: String = dateFormatter.string(from: date as Date)
        return localDate
    }
    
    
    // Форматирование даты в формат:  пт 16/04
    func formatDate3(unixDateToConvert: Int64) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(unixDateToConvert))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E d/M"
        dateFormatter.timeZone = NSTimeZone() as TimeZone
        
        let localDate: String = dateFormatter.string(from: date as Date)
        return localDate
    }
    
    
    
    // Определение картинки взависимости от типа осадков:
    // Тип осадков.0 — без осадков.1 — дождь.2 — дождь со снегом.3 — снег.4 — град.
    // В нашем задании соответствующих изображений нет, поэтому пока будем использовать пять вариантов дождя/недождя
    func getPrecPicture(byNumber: Int64?) -> UIImage {
        
        var precImage = UIImage()
        
        switch byNumber {
        case 0:
            precImage = UIImage(named: "conditionClear")!
        case 1:
            precImage = UIImage(named: "conditionClouds")!
        case 2:
            precImage = UIImage(named: "conditionRain")!
        case 3:
            precImage = UIImage(named: "conditionRainRain")!
        case 4:
            precImage = UIImage(named: "conditionThunder")!
        default:
            precImage = UIImage(named: "cloudness")!
        }
        return precImage
    }
    
    
    //  Определение описания погодных условий
    func getConditionDescription(byString: String) -> String {
        let conditionDescription: String
        switch byString {
        case "clear":
            conditionDescription = "Ясно"
        case "partly-cloudy":
            conditionDescription = "Малооблачно"
        case "cloudy":
            conditionDescription = "Облачно с прояснениями"
        case "overcast":
            conditionDescription = "Пасмурно"
        case "drizzle":
            conditionDescription = "Морось"
        case "light-rain":
            conditionDescription = "Небольшой дождь"
        case "rain":
            conditionDescription = "Дождь"
        case "moderate-rain":
            conditionDescription = "Умеренно сильный дождь"
        case "heavy-rain":
            conditionDescription = "Сильный дождь"
        case "continuous-heavy-rain":
            conditionDescription = "Длительный сильный дождь"
        case "showers":
            conditionDescription = "Ливень"
        case "wet-snow":
            conditionDescription = "Дождь со снегом"
        case "light-snow":
            conditionDescription = "Небольшой снег"
        case "snow":
            conditionDescription = "Снег"
        case "snow-showers":
            conditionDescription = "Снегопад"
        case "hail":
            conditionDescription = "Град"
        case "thunderstorm":
            conditionDescription = "Гроза"
        case "thunderstorm-with-rain":
            conditionDescription = "Дождь с грозой"
        case "thunderstorm-with-hail":
            conditionDescription = "Гроза с градом"
        default:
            conditionDescription = "Нет данных"
        }

        return conditionDescription
    }
    
    
    // Определение направлений ветра
    
    func getWindDirection(byString: String) -> String {
        let windDirDescription: String
        switch byString {
        case "nw":
            windDirDescription = "СЗ"
        case "n":
            windDirDescription = "С"
        case "ne":
            windDirDescription = "СВ"
        case "e":
            windDirDescription = "В"
        case "se":
            windDirDescription = "ЮВ"
        case "s":
            windDirDescription = "Ю"
        case "sw":
            windDirDescription = "ЮЗ"
        case "w":
            windDirDescription = "З"
        case "c":
            windDirDescription = "Штиль"
        default:
            windDirDescription = "Нет данных"
        }

        return windDirDescription
    }
    
    
    // Преобразования номера часа
    
    func getHourNumber(byString: String) -> String {
        let hourName: String
        switch byString {
        case "0":
            hourName = "00:00"
        case "1":
            hourName = "01:00"
        case "2":
            hourName = "02:00"
        case "3":
            hourName = "03:00"
        case "4":
            hourName = "04:00"
        case "5":
            hourName = "05:00"
        case "6":
            hourName = "06:00"
        case "7":
            hourName = "07:00"
        case "8":
            hourName = "08:00"
        case "9":
            hourName = "09:00"
        case "10":
            hourName = "10:00"
        case "11":
            hourName = "11:00"
        case "12":
            hourName = "12:00"
        case "13":
            hourName = "13:00"
        case "14":
            hourName = "14:00"
        case "15":
            hourName = "15:00"
        case "16":
            hourName = "16:00"
        case "17":
            hourName = "17:00"
        case "18":
            hourName = "18:00"
        case "19":
            hourName = "19:00"
        case "20":
            hourName = "20:00"
        case "21":
            hourName = "21:00"
        case "22":
            hourName = "22:00"
        case "23":
            hourName = "23:00"
        default:
            hourName = "Нет данных"
        }

        return hourName
    }
    
    
    
    
    // Конвертирование значений температуры Цельсий -> Фаренгейт с округлением
    func convertCelsiusToFahrenheit(Celsius: Float) -> Float {
        let celsiusDouble = Double(Celsius)
        let celsius = Measurement(value: celsiusDouble, unit: UnitTemperature.celsius)
        let fahrenheitDouble = celsius.converted(to: .fahrenheit).value
        let fahrenheit = Float(round(fahrenheitDouble * 10)/10)
        return fahrenheit
    }
    
    // Конвертирование километров в мили (метры в секунду конвертируем в ???)
//    func convertKilometersToMiles(kilometers: Float) -> Float {
//
//    }
}
