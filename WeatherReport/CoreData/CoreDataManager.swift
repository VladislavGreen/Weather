//
//  CoreDataManager.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/10/23.
//

import CoreData


class CoreDataManager {
    
    static let dafaultManager = CoreDataManager()
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
    
    
    // Обновление базы CoreData
    func setCoreDataCash(weather: WeatherDecodable, completion: (()->())?) {
        
        persistentContainer.performBackgroundTask { contextBackground in
            
            // Получаем ID города
            // Ищем данные города в базе
                    // Если не находим - создаём новый объект
                    // Если находим - обновляем данные в найденном объекте
            
            // Пока просто сначала cтираем старые данные из CoreData
            let fetchRequest = Weather.fetchRequest()
            for object in (try? self.persistentContainer.viewContext.fetch(fetchRequest)) ?? [] {
                self.persistentContainer.viewContext.delete(object)
            }
            
                        
            // наполняем базу CoreData свежими данными
            let newWeather = Weather(context: contextBackground)
            
//            newWeather.city = "Current location"
            
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
            newWeather.factPressureMm = weather.fact.pressure_mm
            newWeather.factTemp = weather.fact.temp
            newWeather.factUVIndex = weather.fact.uv_index
            newWeather.factWindGust = weather.fact.wind_gust
            newWeather.factWindDirection = weather.fact.wind_dir
            newWeather.factWindSpeed = weather.fact.wind_speed
            
            try? contextBackground.save()

            completion?()
        }
    }
    
    // Получение данных из базы CoreData
    func getCoreDataCash() -> Weather? {
        
        let fetchRequest = Weather.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "factCloudness", ascending: true)]
        let data = try? persistentContainer.viewContext.fetch(fetchRequest)
        
        let newWeather = data?.first

        return newWeather
    }
    

}
