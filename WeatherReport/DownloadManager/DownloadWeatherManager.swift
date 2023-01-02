//
//  DownloadManager.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/5/23.
//

import Foundation
    
    /*
     Необходимо получить:
     - название населённого пункта
     - координаты => населённый пункт
     - время запроса
     - разброс температур за день
     - текущая температура
     - температура по ощущениям
     - влажность %
     - усреднённая информация об осадках (Вероятность осадков?)
     - уровень облачности %
     - текущая фаза луны? (картинка)
     - направление ветра
     - скорость ветра
     - уровень влажности
     - время восхода Солнца
     - время заката Солнца
     - почасовой (раз в три часа?) прогноз по пунктам:
     - день/ночь
     - температура
     - температура по ощущениям
     - ветер: скорость, направление
     - атмосферные осадки вероятность %
     - облачность %
     - осадки: тип и вероятность
     - солнце и луна
     - УФ индекс
     - качество воздуха
     */
    
    /*
     https://yandex.ru/dev/weather/doc/dg/concepts/forecast-test.html#req-example
     
     ЗАПРОС
     GET https://api.weather.yandex.ru/v2/forecast?
     lat=<широта>
     & lon=<долгота>
     & [lang=<язык ответа>]
     & [limit=<срок прогноза>] - максимум 7 дней
     & [hours=<наличие почасового прогноза>]
     & [extra=<подробный прогноз осадков>]
     
     X-Yandex-API-Key: <значение ключа>
     При отправке запросов к API добавляйте значение полученного ключа в заголовок X-Yandex-API-Key: <значение ключа>
     8175584b-3e7a-48de-9009-04343f71bd8a
     */
    
    
    struct Weather : Codable {
        var now : Int               // Время сервера в формате Unixtime.
        var now_dt: String          // Время сервера в UTC
        var info: Info              // ОБЪЕКТ информации о населенном пункте.
        var fact: Fact              // ОБЪЕКТ фактической информации о погоде.
        var geo_object: GeoObject   // ОБЪЕКТ с данными объекта гео-локации
        var forecasts: [Forcast]    // ОБЪЕКТ прогнозной информации о погоде.
    }
    

    struct Info: Codable {
        var lat: Float              // Широта (в градусах).
        var lon: Float              // Долгота (в градусах)
        var url: String             // Страница населенного пункта на сайте Яндекс.Погода
    }


    struct GeoObject: Codable {
        var country: GeoObjectDetail
        var district: String?
        var locality: GeoObjectDetail
        var province: GeoObjectDetail
    }
    
    struct GeoObjectDetail: Codable {
        var id: Int?
        var name: String?
    }
   

    struct Fact: Codable {
        
        var temp: Int               // Температура (°C)
        var feels_like: Int         // Ощущаемая температура (°C)
        var condition: String       // Код расшифровки погодного описания. Возможные значения 19 штук
        var wind_speed: Float       // Скорость ветра
        var wind_gust: Float        // Скорость порывов ветра
        var wind_dir: String        // Направление ветра 9 штук включая штиль (с)
        var pressure_mm: Int        // Давление (в мм рт. ст.)
        var humidity: Int           // Влажность воздуха (в процентах).
        var obs_time: Int           // Время замера погодных данных в формате Unixtime
        var is_thunder: Bool        // Признак грозы. Возможные значения: true - гроза
        var prec_type: Int          // Тип осадков: 0 — без осадков. 1 — дождь. 2 — дождь со снегом. 3 — снег. 4 — град.
        var prec_strength: Float    // Сила осадков: 0 — без. 0.25 — слаб дж/cн. 0.5 — д/с. 0.75 — сильн д/с.1 — ливень/сильн снег.
        var cloudness: Float        // Облачность: 0 — ясно.0.25 — малообл. 0.5 и 0.75 — обл с прояснениями.1 — пасмурно.
        var uv_index: Int
        
        /* не используются:
            daytime = d;
            icon = "bkn_d";
            "is_thunder" = 0; ?????
            polar = 0;
            "prec_prob" = 0;
            "pressure_pa" = 1010;
            season = winter;
            source = station;
            "temp_water" = 11;
            uptime = 1673193744
         */
    }


    struct Forcast: Codable {
        
        var date: String            // Дата прогноза в формате ГГГГ-ММ-ДД.
        var date_ts: Int            // Дата прогноза в формате Unixtime.
        var hours: [Hour]           // ОБЪЕКТ почасового прогноза погоды.  строка.
        var parts: Part             // 12-ЧАСОВЫЕ ПРОГНОЗЫ. тип прогноза: night, day_short
        var sunrise: String?        // Время восхода Солнца, локальное время (может отсутствовать для полярных регионов).
        var sunset: String?         // Время заката Солнца, локальное время (может отсутствовать для полярных регионов).
        var moon_code: Int          // Код фазы Луны. 0 — полнолуние.1-3 — убывающая .4 — последняя четверть.5-7 — убывающая .8 — новолуние.9-11 — растущая .12 — первая четверть.13-15 — растущая
        
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
    
    struct Part: Codable {
        
        var night: Night            // ОБЪЕКТ с прогнозом погоды на ночь.
        var day_short: Day_short   // ОБЪЕКТ с 12-часовым прогнозом на день
        
        /* Не используются:
            day
            evening
            morning
            "night_short"
         */
    }
    


    struct Night: Codable {
        var temp_min: Int               // Минимальная температура для времени суток (°C)
        var temp_max: Int?              // Максимальная температура для времени суток (°C)
        var temp_avg: Int?              // Средняя температура для времени суток (°C)
        var feels_like: Int             // Ощущаемая температура (°C)
        var condition: String           // Код расшифровки погодного описания clear — ясно. partly-cloudy — малооблачно. etc
        var wind_speed: Float           // Скорость ветра (в м/с)
        var wind_gust: Float            // Скорость порывов ветра (в м/с)
        var wind_dir: String            // Направление ветра 9 штук включая штиль (с)
        var pressure_mm: Int            // Давление (в мм рт. ст.).
        var humidity: Int               // Влажность воздуха (в процентах)
        var prec_mm: Float              // Прогнозируемое количество осадков (в мм).
        var prec_period: Int
        var prec_type: Int              // Тип осадков.0 — без осадков.1 — дождь.2 — дождь со снегом.3 — снег.4 — град.
        var prec_strength: Float        // Сила осадков: 0 — без. 0.25 — слаб дж/cн. 0.5 — д/с. 0.75 — сильн д/с.1 — ливень/сильн сн.
        var cloudness: Float            // Облачность: 0 — ясно.0.25 — малообл.0.5 и.0.75 — обл с прояснениями.1 — пасмурно.
        
        /*  Не задействованы пока:
             "_source" = "22,23,0,1,2,3,4,5";
             daytime = n;
             "fresh_snow_mm" = 0;
             icon = "ovc_ra";
             polar = 0;
             "prec_prob" = 70;
             "pressure_mm" = 753;
             "pressure_pa" = 1003;
             "temp_water" = 11;
             "uv_index" = 0;
         */
    }
    
    struct Day_short: Codable {
        var temp_min: Int
        var temp_max: Int?
        var temp_avg: Int?
        var feels_like: Int
        var condition: String
        var wind_speed: Float
        var wind_gust: Float
        var wind_dir: String
        var pressure_mm: Int
        var humidity: Int
        var prec_mm: Float
        var prec_period: Int
        var prec_type: Int
        var prec_strength: Float
        var cloudness: Float
    }
    
    struct Hour: Codable {
        var hour: String                // Значение часа, для которого дается прогноз (0-23), локальное время.
        var hour_ts: Int                // Время прогноза в Unixtime.
        var temp: Int
        var feels_like: Int
        var condition: String
        var wind_speed: Float
        var wind_dir: String
        var pressure_mm: Int
        var humidity: Int
        var prec_mm: Float
        var prec_type: Int
        var prec_strength: Float
        var is_thunder: Bool
        var cloudness: Float
    }
    
    
func downloadWeatherInfo(lat: Float, lon: Float, completion: ((_ weather: Weather?, _ errorString: String?)->Void)?) {
        
        let headers = [
            "X-Yandex-API-Key": "8175584b-3e7a-48de-9009-04343f71bd8a",
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
                completion?(nil, "Status Code = \(String(describing: httpResponse?.statusCode ?? 0))")
                return
            }
            
            guard let unwrappedData = data  else {
                print("data = nil")
                completion?(nil, "data = nil")
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: unwrappedData)
//                print(weather.now_dt)
//                print(weather.fact.temp)
//                print(weather.geo_object.locality)
                
                completion?(weather, nil)
                    
            } catch let error {
                print(error)
                completion?(nil, error.localizedDescription)
            }
        }
        dataTask.resume()
        
    }
    
