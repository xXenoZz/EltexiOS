import Foundation

    // Enum для типа груза
    enum CargoType: Equatable {
        case fragile(temperatureRequirement: Int)
        case perishable(temperatureRequirement: Int)
        case bulk
        
        var description: String {
            switch self {
            case .fragile(let temp):
                return "Хрупкий груз с повышенным температурным режимом: \(temp)°C"
            case .perishable(let temp):
                return "Скоропортящийся груз с требуемой температурой: \(temp)°C"
            case .bulk:
                return "Сыпучий груз"
            }
        }
    }
    
    // Структура для груза
    struct Cargo {
        let description: String
        let weight: Int
        let type: CargoType
        
        init?(description: String, weight: Int, type: CargoType) {
            guard weight >= 0 else { return nil }
            self.description = description
            self.weight = weight
            self.type = type
        }
    }
    
    // Базовый класс для транспортного средства
    class Vehicle {
        var make: String
        var model: String
        var year: Int
        var capacity: Int
        var types: [CargoType]?
        var currentLoad: Int = 0
        
        init(make: String, model: String, year: Int, capacity: Int, types: [CargoType]? = nil) {
            self.make = make
            self.model = model
            self.year = year
            self.capacity = capacity
            self.types = types
        }
        
        func loadCargo(cargo: Cargo) {
            if let types = types, !types.contains(cargo.type) {
                print("Ошибка: Тип груза не поддерживается.")
                return
            }
            
            if currentLoad + cargo.weight > capacity {
                print("Ошибка: Слишком большая нагрузка! Не удалось загрузить \(cargo.description).")
                return
            }
            
            currentLoad += cargo.weight
            print("Загружено \(cargo.description) в \(make) \(model). Текущая нагрузка: \(currentLoad) кг.")
        }
        
        func unloadCargo() {
            currentLoad = 0
            print("Выгрузил весь груз из \(make) \(model).")
        }
    }
    
    // Класс для грузовика
    class Truck: Vehicle {
        var trailerAttached: Bool
        var trailerCapacity: Int?
        var trailerTypes: [CargoType]?
        
        init(make: String, model: String, year: Int, capacity: Int, trailerAttached: Bool, trailerCapacity: Int? = nil, trailerTypes: [CargoType]? = nil) {
            self.trailerAttached = trailerAttached
            self.trailerCapacity = trailerCapacity
            self.trailerTypes = trailerTypes
            super.init(make: make, model: model, year: year, capacity: capacity)
        }
        
        override func loadCargo(cargo: Cargo) {
            if trailerAttached {
                if let trailerTypes = trailerTypes, !trailerTypes.contains(cargo.type) {
                    print("Ошибка: Тип груза, не поддерживается для прицепа.")
                    return
                }
                
                if currentLoad + cargo.weight > capacity + (trailerCapacity ?? 0) {
                    print("Ошибка: Слишком большая нагрузка, включая прицеп! Не удалось загрузить \(cargo.description).")
                    return
                }
            } else {
                super.loadCargo(cargo: cargo)
                return
            }
            
            currentLoad += cargo.weight
            print("Загружено \(cargo.description) в грузовик \(make) \(model). Текущая нагрузка: \(currentLoad) кг.")
        }
    }
    
    // Класс для автопарка
    class Fleet {
        private var vehicles: [Vehicle] = []
        
        func addVehicle(_ vehicle: Vehicle) {
            vehicles.append(vehicle)
        }
        
        func totalCapacity() -> Int {
            return vehicles.reduce(0) { $0 + $1.capacity }
        }
        
        func totalCurrentLoad() -> Int {
            return vehicles.reduce(0) { $0 + $1.currentLoad }
        }
        
        func info() {
            print("Информация о автопарке:")
            print("Общая вместимость: \(totalCapacity()) кг")
            print("Общая текущая нагрузка: \(totalCurrentLoad()) кг")
            
            for vehicle in vehicles {
                print("\(vehicle.make) \(vehicle.model): Текущая нагрузка - \(vehicle.currentLoad) кг")
            }
        }
    }
    // Пример использования программы в функции main
    func maine() {
        let fleet = Fleet()
        
        let truck1 = Truck(make: "Volvo", model: "FH", year: 2020, capacity: 10000, trailerAttached: true, trailerCapacity: 5000)
        let truck2 = Truck(make: "Scania", model: "R", year: 2019, capacity: 12000, trailerAttached: false)
        
        fleet.addVehicle(truck1)
        fleet.addVehicle(truck2)
        
        guard let cargo1 = Cargo(description: "Электроника", weight: 3000, type: .fragile(temperatureRequirement: 20)),
              let cargo2 = Cargo(description: "Фрукты", weight: 2000, type: .perishable(temperatureRequirement: 5)),
              let cargo3 = Cargo(description: "Песок", weight: 8000, type: .bulk) else {
            print("Не удалось создать груз.")
            return
        }
        
        truck1.loadCargo(cargo: cargo1)
        truck1.loadCargo(cargo: cargo2)
        truck2.loadCargo(cargo: cargo3)
        
        fleet.info()
    }
maine()
