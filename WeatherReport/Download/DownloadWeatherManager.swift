//
//  DownloadManager.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/5/23.
//

import Foundation
    
    
struct WeatherDecodable : Decodable {
    var now : Int64                         // Время сервера в формате Unixtime.
//        var now_dt: String                // Время сервера в UTC
    var info: InfoDecodable                 // ❗️ ОБЪЕКТ информации о населенном пункте.
    var geo_object: GeoObjectDecodable      // ОБЪЕКТ с данными объекта гео-локации
    var fact: FactDecodable                 // ОБЪЕКТ фактической информации о погоде.
    var forecasts: [ForcastDecodable]    // ОБЪЕКТ прогнозной информации о погоде.
}
    

    struct InfoDecodable: Decodable {       //  ❗️
        var lat: Float                      // Широта (в градусах).
        var lon: Float                      // Долгота (в градусах)
//        var url: String                   // Страница населенного пункта на сайте Яндекс.Погода
    }


struct GeoObjectDecodable: Decodable {
    var country: GeoObjectDetailDecodable?
//    var district: String?                 // ответ поменялся при изменении координат
    var district: GeoObjectDetailDecodable?
    var locality: GeoObjectDetailDecodable?
    var province: GeoObjectDetailDecodable?
}
    
struct GeoObjectDetailDecodable: Decodable {
//        var id: Int64?
    var name: String?
}
   

struct FactDecodable: Decodable {
        
    var temp: Int64             // Температура (°C)
    var feels_like: Int64       // Ощущаемая температура (°C)
    var condition: String       // Код расшифровки погодного описания. Возможные значения 19 штук
    var wind_speed: Float       // Скорость ветра
    var wind_gust: Float        // Скорость порывов ветра
    var wind_dir: String        // Направление ветра 9 штук включая штиль (с)
    var pressure_mm: Int64      // Давление (в мм рт. ст.)
    var humidity: Int64         // Влажность воздуха (в процентах).
    //   var obs_time: Int64    // Время замера погодных данных в формате Unixtime
    var is_thunder: Bool        // Признак грозы. Возможные значения: true - гроза
    var prec_type: Int64        // Тип осадков: 0 — без осадков. 1 — дождь. 2 — дождь со снегом. 3 — снег. 4 — град.
    var prec_strength: Float    // Сила осадков: 0 — без. 0.25 — слаб дж/cн. 0.5 — д/с. 0.75 — сильн д/с.1 — ливень/сильн снег.
    var prec_prob: Int64        // Вероятность выпадения осадков %
    var cloudness: Float        // Облачность: 0 — ясно.0.25 — малообл. 0.5 и 0.75 — обл с прояснениями.1 — пасмурно.
    var uv_index: Int64
        
        /* не используются:
            daytime = d;
            icon = "bkn_d";
            "is_thunder" = 0; ?????
            polar = 0;
            "pressure_pa" = 1010;
            season = winter;
            source = station;
            "temp_water" = 11;
            uptime = 1673193744
         */
    }


struct ForcastDecodable: Decodable {
        
    var date: String            // Дата прогноза в формате ГГГГ-ММ-ДД.
    var date_ts: Int64          // Дата прогноза в формате Unixtime.
    var hours: [HourDecodable]  // ОБЪЕКТ почасового прогноза погоды.  строка.
    var parts: PartDecodable    // 12-ЧАСОВЫЕ ПРОГНОЗЫ. тип прогноза: night, day_short
    var sunrise: String?        // Время восхода Солнца, локальное время (может отсутствовать для полярных регионов).
    var sunset: String?         // Время заката Солнца, локальное время (может отсутствовать для полярных регионов).
    var moon_code: Int64        // Код фазы Луны. 0 — полнолуние.1-3 — убывающая .4 — последняя четверть.5-7 — убывающая .8 — новолуние.9-11 — растущая .12 — первая четверть.13-15 — растущая
        
//    var index: Int64            // предположительно, UV
        /* Не используются:
            biomet =
                condition = "magnetic-field_0";
                index = 0;
            "moon_text" = "moon-code-1";
            "rise_begin" = "06:56";
            "set_end" = "17:35";
            week = 1;
         */
    }
    
struct PartDecodable: Decodable {
        
    var night: NightDecodable            // ОБЪЕКТ с прогнозом погоды на ночь.
    var day_short: Day_shortDecodable    // ОБЪЕКТ с 12-часовым прогнозом на день
        
        /* Не используются:
            day
            evening
            morning
            "night_short"
         */
}
    


struct NightDecodable: Decodable {
    var temp_min: Int64             // Минимальная температура для времени суток (°C)
    var temp_max: Int64?            // Максимальная температура для времени суток (°C)
    var temp_avg: Int64?            // Средняя температура для времени суток (°C)
    var feels_like: Int64           // Ощущаемая температура (°C)
    var condition: String           // Код расшифровки погодного описания clear — ясно. partly-cloudy — малооблачно. etc
    var wind_speed: Float           // Скорость ветра (в м/с)
    var wind_gust: Float            // Скорость порывов ветра (в м/с)
    var wind_dir: String            // Направление ветра 9 штук включая штиль (с)
    var pressure_mm: Int64          // Давление (в мм рт. ст.).
    var humidity: Int64             // Влажность воздуха (в процентах)
    var prec_mm: Float              // Прогнозируемое количество осадков (в мм).
    var prec_period: Int64
    var prec_type: Int64            // Тип осадков.0 — без осадков.1 — дождь.2 — дождь со снегом.3 — снег.4 — град.
    var prec_strength: Float        // Сила осадков: 0 — без. 0.25 — слаб дж/cн. 0.5 — д/с. 0.75 — сильн д/с.1 — ливень/сильн сн.
    var cloudness: Float            // Облачность: 0 — ясно.0.25 — малообл.0.5 и.0.75 — обл с прояснениями.1 — пасмурно.
    
    
//    var uv_index: Int64             // В документации к API отсутствует, по факту есть не всегда и если есть, то 0
    
        /*  Не задействованы:
             "_source" = "22,23,0,1,2,3,4,5";
             daytime = n;
             "fresh_snow_mm" = 0;
             icon = "ovc_ra";
             polar = 0;
             "prec_prob" = 70;
             "pressure_mm" = 753;
             "pressure_pa" = 1003;
             "temp_water" = 11;

         */
}
    
struct Day_shortDecodable: Decodable {
    var temp_min: Int64
    var temp_max: Int64?
    var temp_avg: Int64?
    var feels_like: Int64
    var condition: String
    var wind_speed: Float
    var wind_gust: Float
    var wind_dir: String
    var pressure_mm: Int64
    var humidity: Int64
    var prec_mm: Float
    var prec_period: Int64
    var prec_type: Int64
    var prec_strength: Float
    var cloudness: Float
//    var uv_index: Int64
}
    
struct HourDecodable: Decodable {
    var cloudness: Float
    var hour: String                    // Значение часа, для которого дается прогноз (0-23), локальное время.
//        var hour_ts: Int64                // Время прогноза в Unixtime.
    var temp: Int64
    var feels_like: Int64
    var condition: String
    var wind_speed: Float
    var wind_dir: String
    var pressure_mm: Int64
    var humidity: Int64
    var prec_mm: Float
    var prec_type: Int64
    var prec_strength: Float
    var is_thunder: Bool
}
 
    
func downloadWeatherInfo(lat: Float, lon: Float, completion: ((_ weather: WeatherDecodable?, _ errorString: String?)->Void)?) {
    // Первый ключ (закончился): 8175584b-3e7a-48de-9009-04343f71bd8a
    // Второй ключ: 0e1163fd-af84-4988-883b-5ccf50fb5050
    let headers = [
        "X-Yandex-API-Key": "0e1163fd-af84-4988-883b-5ccf50fb5050",
        "X-Yandex-API-Host": "https://api.weather.yandex.ru/v2/forecast/"
    ]
        
    let request = NSMutableURLRequest(
        url: NSURL(string: "https://api.weather.yandex.ru/v2/forecast?lat=\(lat)&lon=\(lon)&lang=ru_RU&hours=true&extra=true")! as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            
        if let error {
            print(error.localizedDescription)
            completion?(nil, error.localizedDescription)
            return
        }
            
        let httpResponse = response as? HTTPURLResponse
        if httpResponse?.statusCode != 200 {
            print("Status Code = \(String(describing: httpResponse?.statusCode ?? 0))")
            DispatchQueue.main.async {
                Alerts.defaultAlert.showOkAlert(
                    title: "Невозможно получить данные",
                    message: "Возможно, закончился тестовый период API")
            }
            completion?(nil, "Status Code = \(String(describing: httpResponse?.statusCode ?? 0))")
            return
        }
            
        guard let unwrappedData = data  else {
            print("data = nil")
            completion?(nil, "data = nil")
            return
        }
            
        do {
////             Смотрим, что в JSON
//                let serializadJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
//                print(serializadJSON)
            
            let weather = try JSONDecoder().decode(WeatherDecodable.self, from: unwrappedData)
            completion?(weather, nil)
                    
        } catch let error {
            print(error)
            print("Ошибка докодирования JSON")
            completion?(nil, error.localizedDescription)
        }
    }
    dataTask.resume()
}


func getLocationFromCityName(cityName: String, completion: ((_ latLongArray: [String]?, _ errorString: String?)->Void)?) {
    
    var latLongArray: [String] = []
    
    let headers = [
        "X-Yandex-API-Key": "d7a9fbf5-7b4a-4241-8af7-11f0fec35278",
        "X-Yandex-API-Host": "https://geocode-maps.yandex.ru/1.x/"
    ]
    
    guard let urlString = NSURL(string: "https://geocode-maps.yandex.ru/1.x/?apikey=d7a9fbf5-7b4a-4241-8af7-11f0fec35278&format=json&geocode=\(cityName)")
    else {
        Alerts.defaultAlert.showOkAlert(
            title: "Не удаётся найти локацию",
            message: "Попробуйте убрать мягкие знаки или ввести название латиницей")
        return
    }
    
    let request = NSMutableURLRequest(
            url: urlString as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0)
    
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            
        if let error {
            print(error.localizedDescription)
            completion?(nil, error.localizedDescription)
            return
        }
            
        let httpResponse = response as? HTTPURLResponse
        if httpResponse?.statusCode != 200 {
            print("Status Code = \(String(describing: httpResponse?.statusCode ?? 0))")
            completion?(nil, "Status Code = \(String(describing: httpResponse?.statusCode ?? 0))")
        }
            
        guard let unwrappedData = data  else {
            print("data = nil")
            completion?(nil, "data = nil")
            return
        }
            
        do {
                // Смотрим, что в JSON
//                let serializadJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
//                print(serializadJSON)

                
            guard let dictionary = try JSONSerialization.jsonObject(with: unwrappedData as Data, options: .mutableContainers) as? [String: AnyObject] else {
                    print ("Error")
                    return
                }
            if
                let response = dictionary["response"] as? [String: AnyObject],
                let geoObjectCollection = response["GeoObjectCollection"] as? [String: AnyObject],
                let featureMember = geoObjectCollection["featureMember"] as? [[String: AnyObject]],
                !featureMember.isEmpty,
                let geoObject = featureMember[0]["GeoObject"] as? [String: AnyObject],
                let point = geoObject["Point"] as? [String: AnyObject],
                let jsonCoordinatesString = point["pos"] as? String
            {
                        
                latLongArray = jsonCoordinatesString.components(separatedBy: " ")
                        
                if let locationName = geoObject["name"] as? String {
                    latLongArray.append(locationName)
                }
            } else {
                print("что могло пойти не так?")
                DispatchQueue.main.async {
                    Alerts.defaultAlert.showOkAlert(title: "Не удаётся найти локацию", message: "Попробуйте изменить запрос")
                }
                return
            }
            completion?(latLongArray, nil)
                    
        } catch let error {
            print(error)
            completion?(nil, error.localizedDescription)
        }
    }
    dataTask.resume()
}



func getCityNameFromLocation(lat: Double, lon: Double, completion: ((_ locationName: String?, _ errorString: String?)->Void)?) {
    
    var locationName: String?
    
    let headers = [
        "X-Yandex-API-Key": "d7a9fbf5-7b4a-4241-8af7-11f0fec35278",
        "X-Yandex-API-Host": "https://geocode-maps.yandex.ru/1.x/"
    ]
    
    guard let urlString = NSURL(string: "https://geocode-maps.yandex.ru/1.x/?apikey=d7a9fbf5-7b4a-4241-8af7-11f0fec35278&format=json&geocode=\(lon),\(lat)")
    else {
        Alerts.defaultAlert.showOkAlert(
            title: "Не удаётся найти локацию",
            message: "Попробуйте убрать мягкие знаки или ввести название латиницей")
        return
    }
    
    let request = NSMutableURLRequest(
            url: urlString as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0)
    
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            
        if let error {
            print(error.localizedDescription)
            completion?(nil, error.localizedDescription)
            return
        }
            
        let httpResponse = response as? HTTPURLResponse
        if httpResponse?.statusCode != 200 {
            print("Status Code = \(String(describing: httpResponse?.statusCode ?? 0))")
            completion?(nil, "Status Code = \(String(describing: httpResponse?.statusCode ?? 0))")
        }
            
        guard let unwrappedData = data  else {
            print("data = nil")
            completion?(nil, "data = nil")
            return
        }
            
        do {
                
            guard let dictionary = try JSONSerialization.jsonObject(with: unwrappedData as Data, options: .mutableContainers) as? [String: AnyObject] else {
                    print ("Error")
                    return
                }
            if
                /*
                 response
                         GeoObjectCollection
                             featureMember
                                     GeoObject
                                         metaDataProperty
                                             GeocoderMetaData
                                                 AddressDetails
                                                     Country
                                                         AdministrativeArea
                                                             AdministrativeAreaName = "\U041c\U043e\U0441\U043a\U0432\U0430";
                 */
                let response = dictionary["response"] as? [String: AnyObject],
                let geoObjectCollection = response["GeoObjectCollection"] as? [String: AnyObject],
                let featureMember = geoObjectCollection["featureMember"] as? [[String: AnyObject]],
                !featureMember.isEmpty,
                let geoObject = featureMember[0]["GeoObject"] as? [String: AnyObject],
            
                let metaDataProperty = geoObject["metaDataProperty"] as? [String: AnyObject],
                let geocoderMetaData = metaDataProperty["GeocoderMetaData"] as? [String: AnyObject],
                let addressDetails = geocoderMetaData["AddressDetails"] as? [String: AnyObject],
                let country = addressDetails["Country"] as? [String: AnyObject],
                let administrativeArea = country["AdministrativeArea"] as? [String: AnyObject],
                let administrativeAreaName = administrativeArea["AdministrativeAreaName"] as? String
//                let locality = administrativeArea["Locality"] as? [String: AnyObject],
//                let localityName = locality["LocalityName"] as? String

            {
                locationName = administrativeAreaName
//                print(administrativeAreaName)
                
            } else {
                print("что могло пойти не так?")
            }
            
            completion?(locationName, nil)
                    
        } catch let error {
            print(error)
            completion?(nil, error.localizedDescription)
        }
    }
    dataTask.resume()
}
    

