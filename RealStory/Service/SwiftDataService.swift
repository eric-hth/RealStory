//
//  SwiftDataService.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//

import SwiftData
 
@MainActor
struct SwiftDataService{
    private static var modelContainer_ : ModelContainer?
    static var modelList :  [ any PersistentModel.Type] =  [ Story.self ]
      static var modelContainer : ModelContainer{
        get throws {
            if let modelContainer_ = modelContainer_{
                return modelContainer_
            }
            else{
                modelContainer_  = try ModelContainer(  for: Schema(modelList) )
                return modelContainer_!
            }
        }
    }
      static func deleteAll(){
        do{
            for model in  modelList{
                try modelContainer.mainContext.delete(model:model)
            }
        }
        catch{
            print(error)
        }
    }
}

