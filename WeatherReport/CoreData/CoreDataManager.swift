//
//  CoreDataManager.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/10/23.
//

import CoreData


class CoreDataManager {
    
    static let defaultManager = CoreDataManager()
    private init() {
        
    }
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "WeatherReport")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func setCoreDataCash(weather: WeatherDecodable, completion: (()->())?) {
        
        
        
        persistentContainer.performBackgroundTask { contextBackground in
            
            // Пока всё проектируется - стираем старые данные из CoreData
            self.deleteCoreDataCash()
            
            let fetchRequest = Weather.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "cityName", ascending: true)]
                        
            // наполняем базу CoreData свежими данными
            let newWeather = Weather(context: contextBackground)
            
            // Здесь будет метод определения города по координатам
            newWeather.cityName = "Current Location"
            
            newWeather.now = weather.now
            
            newWeather.geoProvinceName = weather.geo_object.province.name
            newWeather.geoLocalityName = weather.geo_object.locality.name
            newWeather.geoDistrictName = weather.geo_object.district
            newWeather.geoCountryName = weather.geo_object.country.name
            
            newWeather.factCloudness = weather.fact.cloudness
            newWeather.factCondition = weather.fact.condition
            newWeather.factFeelsLike = weather.fact.feels_like
            newWeather.factHumidity = weather.fact.humidity
            newWeather.factIsThunder = weather.fact.is_thunder
            newWeather.factPrecStrength = weather.fact.prec_strength
            newWeather.factPrecType = weather.fact.prec_type
            newWeather.factPrecProb = weather.fact.prec_prob
            newWeather.factPressureMm = weather.fact.pressure_mm
            newWeather.factTemp = weather.fact.temp
            newWeather.factUVIndex = weather.fact.uv_index
            newWeather.factWindGust = weather.fact.wind_gust
            newWeather.factWindDirection = weather.fact.wind_dir
            newWeather.factWindSpeed = weather.fact.wind_speed
            
            
            var newForecasts: [Forecast] = []
            
            for forecast in weather.forecasts {
                let newForecast = Forecast(context: contextBackground)
                newForecast.date = forecast.date
                newForecast.dateTS = forecast.date_ts
                newForecast.sunrise = forecast.sunrise
                newForecast.sunset = forecast.sunset
                
                newForecast.dayShort?.cloudness = forecast.parts.day_short.cloudness
                newForecast.dayShort?.condition = forecast.parts.day_short.condition
                newForecast.dayShort?.feelsLike = forecast.parts.day_short.feels_like
                newForecast.dayShort?.humidity = forecast.parts.day_short.humidity
                newForecast.dayShort?.precMM = forecast.parts.day_short.prec_mm
                newForecast.dayShort?.precPeriod = forecast.parts.day_short.prec_period
                newForecast.dayShort?.precStrength = forecast.parts.day_short.prec_strength
                newForecast.dayShort?.precType = forecast.parts.day_short.prec_type
                newForecast.dayShort?.pressureMM = forecast.parts.day_short.pressure_mm
                newForecast.dayShort?.tempAverage = forecast.parts.day_short.temp_avg ?? 0      // пока так
                newForecast.dayShort?.tempMax = forecast.parts.day_short.temp_max ?? 0          // пока так
                newForecast.dayShort?.tempMin = forecast.parts.day_short.temp_min
                newForecast.dayShort?.windGust = forecast.parts.day_short.wind_gust
                newForecast.dayShort?.windDirection = forecast.parts.day_short.wind_dir
                newForecast.dayShort?.windSpeed = forecast.parts.day_short.wind_speed
                
                newForecast.night?.cloudness = forecast.parts.night.cloudness
                newForecast.night?.condition = forecast.parts.night.condition
                newForecast.night?.feelsLike = forecast.parts.night.feels_like
                newForecast.night?.humidity = forecast.parts.night.humidity
                newForecast.night?.precMM = forecast.parts.night.prec_mm
                newForecast.night?.precPeriod = forecast.parts.night.prec_period
                newForecast.night?.precStrength = forecast.parts.night.prec_strength
                newForecast.night?.precType = forecast.parts.night.prec_type
                newForecast.night?.pressureMM = forecast.parts.night.pressure_mm
                newForecast.night?.tempAverage = forecast.parts.night.temp_avg ?? 0      // пока так
                newForecast.night?.tempMax = forecast.parts.night.temp_max ?? 0          // пока так
                newForecast.night?.tempMin = forecast.parts.night.temp_min
                newForecast.night?.windGust = forecast.parts.night.wind_gust
                newForecast.night?.windDirection = forecast.parts.night.wind_dir
                newForecast.night?.windSpeed = forecast.parts.night.wind_speed

// Номер не проходит:
                
//                var newHours: [Hour] = []
//
//                for hour in forecast.hours {
//                    let newHour = Hour(context: contextBackground)
//                    newHour.cloudness = forecast.hours.cloudness
//                    newHour.condition
//                    newHour.feelsLike
//                    newHour.hour
//                    newHour.humidity
//                    newHour.isThunder
//                    newHour.precMM
//                    newHour.precStrength
//                    newHour.precType
//                    newHour.pressureMM
//                    newHour.temp
//                    newHour.windDir
//                    newHour.windDir
//
//                    newHours.append(newHour)
//                }
                
                
                newForecasts.append(newForecast)
            }
            
            newWeather.forecasts = NSSet.init(array: newForecasts)
            
            try? contextBackground.save()
            completion?()
        }
    }
    
  

    
    // Получение данных из базы CoreData
    func getCoreDataCash() -> [Weather]? {
        
        let fetchRequest = Weather.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "cityName", ascending: true)]
        
        let objects = try? persistentContainer.viewContext.fetch(fetchRequest)
        
        print("Всего погод в кэше: \(String(describing: objects?.count))")
        
        return objects
    }
    
        
        // Формирование прогнозов
//    func getForecast(forDate: String, context: NSManagedObjectContext) -> Forecast {
//        let fetchRequest = Forecast.fetchRequest()
//
//        fetchRequest.predicate = NSPredicate(format: "date == %@", forDate)
//
//        let forecast = try? context.fetch(fetchRequest).first
//        return forecast!
//    }
    
    
    // Стирание всех данных из базы
    func deleteCoreDataCash() {
        
        let fetchRequest1 = Weather.fetchRequest()
        for object in (try? self.persistentContainer.viewContext.fetch(fetchRequest1)) ?? [] {
            self.persistentContainer.viewContext.delete(object)
        }
        
//        let fetchRequest2 = Forecast.fetchRequest()
//        for object in (try? self.persistentContainer.viewContext.fetch(fetchRequest2)) ?? [] {
//            self.persistentContainer.viewContext.delete(object)
//        }
        
        print("CoreDate base deleted")
    }
    
    
}
