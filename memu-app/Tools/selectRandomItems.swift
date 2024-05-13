//
//  selectRandomItems.swift
//  memu-app
//
//  Created by David on 13/5/2024.
//

import Foundation

func selectRandomItems<T>(from list: [T], count n: Int) -> [T] {
    guard list.count >= n else {
        return list
    }
    
    return Array(list.shuffled().prefix(n))
}
