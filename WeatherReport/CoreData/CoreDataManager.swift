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
    func setCoreDataCash(weather: Weather) {
        
        
        persistentContainer.performBackgroundTask { contextBackground in
            
            // Если не найдём способа освежить данные, то сначала cтираем старые данные из CoreData
            let fetchRequest = WeatherCached.fetchRequest()
            for object in (try? self.persistentContainer.viewContext.fetch(fetchRequest)) ?? [] {
                self.persistentContainer.viewContext.delete(object)
            }
            
            // наполняем базу CoreData свежими данными
            // пока просто запишем название страны в тектовый объект
            
            let country = WeatherCached(context: contextBackground)
            country.text = weather.geo_object.country.name
            print(country.text)
            try? contextBackground.save()

//            completion?()
        }
    }
    
    // Получение данных из базы CoreData
    func getCoreDataCash() -> String? {
        
        let fetchRequest = WeatherCached.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true)]
        let data = try? persistentContainer.viewContext.fetch(fetchRequest)
        
        let country = data?.first?.text
        print("DATA? \(String(describing: country))")

        return country
    }
    

}
