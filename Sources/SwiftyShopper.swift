import ArgumentParser

@main
struct SwiftyShopper: ParsableCommand {

  static func main() {
    addProduct(id: .init(), name: "Product 1", price: 21.37)
  }
}
