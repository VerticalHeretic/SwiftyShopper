//
//  Products.swift
//
//  Copyright © 2024 VerticalCoding Łukasz Stachnik.
//

import Foundation

struct Product: Codable {
    let id: UUID
    let name: String
    let price: Double
}

/// Global variable for file path
let filePath = "catalog.json"

func addProduct(id: UUID, name: String, price: Double) {
    let newProduct = Product(id: id, name: name, price: price)

    // Directly read from the file
    var products = readProductsFromFile(filePath)
    products.append(newProduct)

    // Directly write back to the file
    writeProductsToFile(filePath, products: products)
}

func deleteProduct(id: UUID) {
    var products = readProductsFromFile(filePath)
    products.removeAll(where: { $0.id == id })

    writeProductsToFile(filePath, products: products)
}

func showProducts() {
    let products = readProductsFromFile(filePath)

    products.forEach {
        print("| ID: \($0.id) | Name: \($0.name) | Price: \($0.price) |")
    }
}

func readProductsFromFile(_: String) -> [Product] {
    // Implementation for reading JSON from file
    let jsonDecoder = JSONDecoder()
    let manager = FileManager.default

    guard let data = manager.contents(atPath: filePath) else { return [] }

    guard let products = try? jsonDecoder.decode([Product].self, from: data) else { return [] }
    return products
}

func writeProductsToFile(_ path: String, products: [Product]) {
    // Implementation for writing JSON to file
    let jsonEncoder = JSONEncoder()
    let manager = FileManager.default

    guard let data = try? jsonEncoder.encode(products) else { return }

    manager.createFile(atPath: path, contents: data)
}
