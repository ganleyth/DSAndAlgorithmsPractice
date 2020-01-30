class On2SortingChallenges {
    static func playground() {
        var array = [9, 4, 10, 3]
        bubbleSort(&array)
        print(array)
    }

    static func challenge1() {

        func moveAllInstancesToTheRight<T: MutableCollection>(targetElement: T.Element, collection: inout T) where T.Element: Equatable {

            // [3, 5, 6, 5, 4, 2, 5]

            // Check the easy scenario to exit early from
            guard collection.count >= 2 else { return }

            // Parse through the collection in reverse order
            for current in collection.indices.reversed() {
                // In the loop:
                // Find the first matching element
                guard collection[current] == targetElement else { continue }

                // Swap the element with elements to the right until you find the end of the collection or another matching element
                var other = collection.index(after: current)
                while other < collection.endIndex && collection[other] != targetElement {
                    collection.swapAt(current, other)
                    other = collection.index(after: other)
                }
            }
        }

        moveAllInstancesToTheRight(targetElement: 5, collection: [3, 5, 6, 5, 5, 4, 2])
    }
}
