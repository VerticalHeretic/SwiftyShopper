//
//  SwiftyShopper.swift
//
//  Copyright © 2024 VerticalCoding Łukasz Stachnik.
//

import ArgumentParser
import Foundation

struct UnwrapError: Error {}

@main
struct SwiftyShopper: ParsableCommand {

  static var configuration = CommandConfiguration(
    abstract: "A products managment CLI tool",
    subcommands: [ReadProducts.self, AddProduct.self, DeleteProduct.self],
    defaultSubcommand: ReadProducts.self
  )
}

extension SwiftyShopper {
  struct ReadProducts: ParsableCommand {

    static var configuration = CommandConfiguration(
      commandName: "read",
      abstract: "Read products"
    )

    func run() throws {
      showProducts()
    }
  }

  struct AddProduct: ParsableCommand {

    static var configuration = CommandConfiguration(
      commandName: "add",
      abstract: "Add product"
    )

    @Argument(help: "Name of the product")
    var name: String

    @Argument(help: "Price of the product")
    var price: Double

    func run() throws {
      addProduct(id: .init(), name: name, price: price)
    }
  }

  struct DeleteProduct: ParsableCommand {

    static var configuration = CommandConfiguration(
      commandName: "delete",
      abstract: "Delete product"
    )

    @Argument(help: "UUID of the product to delete")
    var id: String

    func run() throws {
      guard let id = UUID(uuidString: id) else { throw UnwrapError() }
      deleteProduct(id: id)
    }
  }
}
