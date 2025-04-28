//
//  Array.swift
//  RealStory
//
//  Created by Eric Hong Tuan Ha on 28/04/2025.
//


extension Array where Element : Identifiable {
    func previousElement( _ element : Element?) -> Element?{
        guard let element = element else{
            return nil
        }
        guard let elementIndex = firstIndex(where:{  $0.id == element.id} )else{
            return nil
        }
        let previousElementIndex = elementIndex - 1
        if  indices.contains(previousElementIndex){
            return self[previousElementIndex]
        }
        else{
            return nil
        }
    }
    func nextElement( _ element : Element?) -> Element?{
        guard let element = element else{
            return nil
        }
        guard let elementIndex = firstIndex(where:{  $0.id == element.id} ) else{
            return nil
        }
        let nextElementIndex = elementIndex + 1
        if  indices.contains(nextElementIndex){
            return self[nextElementIndex]
        }
        else{
            return nil
        }
    }
    
}
