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
    
//    var locationName : String = "Current Location"
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "WeatherReport")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                Alerts.defaultAlert.showOkAlert(
                    title: "Проблема!",
                    message: "Typical reasons for an error here include: \n* The parent directory does not exist, cannot be created, or disallows writing.\n* The persistent store is not accessible, due to permissions or data protection when the device is locked.\n* The device is out of space.\n* The store could not be migrated to the current model version.")
//                fatalError("Unresolved error \(error), \(error.userInfo)")
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
                Alerts.defaultAlert.showOkAlert(title: "Невозможно сохранить данные", message: "Возможно, закончилась память на телефоне?")
            }
        }
    }
    
    func setCoreDataCash(weather: WeatherDecodable, locationName: String, completion: (()->())?) {
        
        persistentContainer.performBackgroundTask { contextBackground in
            
            let fetchRequest = Weather.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "cityName", ascending: true)]
                        
            // наполняем базу CoreData свежими данными
            let newWeather = Weather(context: contextBackground)
            
            // Если определяем локацию - передаётся "Current location"
            // Если определяем по названию - передаётся название из ответа API
            newWeather.cityName = locationName
            
            newWeather.now = weather.now
            
            newWeather.geoProvinceName = weather.geo_object.province?.name
            newWeather.geoLocalityName = weather.geo_object.locality?.name
            newWeather.geoDistrictName = weather.geo_object.district?.name
            newWeather.geoCountryName = weather.geo_object.country?.name
            
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
                
                let newDayShort = DayShort(context: contextBackground)
                let dayShort = forecast.parts.day_short
                newDayShort.cloudness = dayShort.cloudness
                newDayShort.condition = dayShort.condition
                newDayShort.feelsLike = dayShort.feels_like
                newDayShort.humidity = dayShort.humidity
                newDayShort.precMM = dayShort.prec_mm
                newDayShort.precPeriod = dayShort.prec_period
                newDayShort.precStrength = dayShort.prec_strength
                newDayShort.precType = dayShort.prec_type
                newDayShort.pressureMM = dayShort.pressure_mm
                newDayShort.tempAverage = dayShort.temp_avg ?? 0
                newDayShort.tempMax = dayShort.temp_max ?? 0
                newDayShort.tempMin = dayShort.temp_min
                newDayShort.windGust = dayShort.wind_gust
                newDayShort.windDirection = dayShort.wind_dir
                newDayShort.windSpeed = dayShort.wind_speed
                
                newForecast.dayShort = newDayShort
                
                
                let newNight = Night(context: contextBackground)
                newNight.cloudness = forecast.parts.night.cloudness
                newNight.condition = forecast.parts.night.condition
                newNight.feelsLike = forecast.parts.night.feels_like
                newNight.humidity = forecast.parts.night.humidity
                newNight.precMM = forecast.parts.night.prec_mm
                newNight.precPeriod = forecast.parts.night.prec_period
                newNight.precStrength = forecast.parts.night.prec_strength
                newNight.precType = forecast.parts.night.prec_type
                newNight.pressureMM = forecast.parts.night.pressure_mm
                newNight.tempAverage = forecast.parts.night.temp_avg ?? 0
                newNight.tempMax = forecast.parts.night.temp_max ?? 0
                newNight.tempMin = forecast.parts.night.temp_min
                newNight.windGust = forecast.parts.night.wind_gust
                newNight.windDirection = forecast.parts.night.wind_dir
                newNight.windSpeed = forecast.parts.night.wind_speed
                
                newForecast.night = newNight
                
                var newHours: [Hour] = []
                
                for hour in forecast.hours {
                    let newHour = Hour(context: contextBackground)
                    newHour.cloudness = hour.cloudness
                    newHour.condition = hour.condition
                    newHour.feelsLike = hour.feels_like
//                    newHour.hour = hour.hour
                    newHour.hour = DataConverters.shared.getHourNumber(byString: hour.hour) // для удобства сортировки
                    newHour.humidity = hour.humidity
                    newHour.isThunder = hour.is_thunder
                    newHour.precMM = hour.prec_mm
                    newHour.precStrength = hour.prec_strength
                    newHour.precType = hour.prec_type
                    newHour.pressureMM = hour.pressure_mm
                    newHour.temp = hour.temp
                    newHour.windDir = hour.wind_dir
                    newHour.windSpeed = hour.wind_speed
                    
                    newHours.append(newHour)
                }
                
                newForecast.hours = NSSet.init(array: newHours)
                
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
        
        print("Всего погод в базе: \(String(describing: objects?.count))")
        
        return objects
    }
    
    
    // Стирание всех данных из базы
    func deleteCoreDataCash() {
        
        let fetchRequest1 = Weather.fetchRequest()
        for object in (try? self.persistentContainer.viewContext.fetch(fetchRequest1)) ?? [] {
            self.persistentContainer.viewContext.delete(object)
        }
        
        print("CoreDate base deleted")
    }
    
    
}
