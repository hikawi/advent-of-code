import Foundation

class Point: Hashable, CustomStringConvertible {
  let x: Int
  let y: Int

  public init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }

  public var description: String {
    return "(\(self.x), \(self.y))"
  }

  public var neighbors: [Point] {
    return [
      Point(x: x, y: y - 1),
      Point(x: x + 1, y: y),
      Point(x: x, y: y + 1),
      Point(x: x - 1, y: y),
    ]
  }

  public var fullNeighbors: [Point] {
    return neighbors + [
      Point(x: x - 1, y: y - 1),
      Point(x: x + 1, y: y + 1),
      Point(x: x - 1, y: y + 1),
      Point(x: x + 1, y: y - 1),
    ]
  }

  static func + (lhs: Point, rhs: Point) -> Point {
    return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
  }

  static func == (lhs: Point, rhs: Point) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(x)
    hasher.combine(y)
  }
}

// Read and convert data to a hash map.
let rawData = try! String.init(contentsOfFile: "./input.txt", encoding: String.Encoding.utf8).split(
  separator: "\n"
).map(String.init)
var data: [Point: Character] = [:]
let width = rawData[0].count
let height = rawData.count

for (y, line) in rawData.enumerated() {
  for (x, char) in line.enumerated() {
    if char == "." {
      continue
    }
    data[Point(x: x, y: y)] = char
  }
}

extension Point {
  func isInBounds() -> Bool {
    return x >= 0 && x < width && y >= 0 && y < height
  }
}

// The starting point is the one with the S character. It must exist, I'm pretty sure.
let start = data.filter({ $0.value == "S" }).first!.key

func traverse(start: Point, startingDirection: Point, distanceMap: inout [Point: Int]) {
  var direction = startingDirection
  var current = start
  var steps = 0

  repeat {
    // Update distanceMap
    if distanceMap[current] == nil || distanceMap[current]! > steps {
      distanceMap[current] = steps
    }
    current = current + direction

    // Oh no, there's a problem.
    if data[current] == nil {
      print(current, "Uh oh")
      return
    }

    switch data[current]! {
    case "7":
      // 7 connects top right.
      // That means if we're going right, we move down now.
      // If we're going up onto this, we move left.
      direction = direction.x == 1 ? Point(x: 0, y: 1) : Point(x: -1, y: 0)
      break
    case "J":
      // J connects bottom right.
      // That means if we're going right, we move up now.
      // If we're going down onto this, we move left.
      direction = direction.x == 1 ? Point(x: 0, y: -1) : Point(x: -1, y: 0)
      break
    case "L":
      // L connects bottom left.
      // That means if we're going left, we move up now.
      // If we're going down onto this, we move right.
      direction = direction.x == -1 ? Point(x: 0, y: -1) : Point(x: 1, y: 0)
      break
    case "F":
      // F connects top left.
      // That means if we're going left, we move down now.
      // If we're going up onto this, we move right.
      direction = direction.x == -1 ? Point(x: 0, y: 1) : Point(x: 1, y: 0)
      break
    default:
      break
    }

    steps += 1
  } while current != start
}

// The distance map is a map of points to the number of steps it takes to get there.
// If we do all directions, that means there can be multiple ways to start from the beginning.
// Else, we just care about what the loop is.
func retrieveDistanceMap(start: Point, doAllDirections: Bool = true) -> [Point: Int] {
  var distanceMap = [Point: Int]()
  var startingDirections = [Point]()

  // Direction -> Expected pipes
  let expectedPipes: [Point: [Character]] = [
    Point(x: -1, y: 0): ["-", "F", "L"],  // Only accepts these if going left at start.
    Point(x: 0, y: 1): ["|", "L", "J"],  // Only accepts these if going down at start.
    Point(x: 0, y: -1): ["|", "7", "F"],  // Only accepts these if going up at start.
    Point(x: 1, y: 0): ["-", "7", "J"],  // Only accepts these if going right at start.
  ]

  // Add starting directions if there are pipes we expected.
  for (dir, expects) in expectedPipes {
    let next = start + dir
    if let nextPipe = data[next] {
      if expects.contains(nextPipe) {
        startingDirections.append(dir)
      }
    }
  }

  // Traverse from the starting point in each direction.
  if !doAllDirections {
    startingDirections.removeSubrange(1..<startingDirections.count)
  }

  for dir in startingDirections {
    traverse(start: start, startingDirection: dir, distanceMap: &distanceMap)
  }

  return distanceMap
}

func solvePartOne() {
  let distanceMap = retrieveDistanceMap(start: start)

  // The maximum value in the distance map is the answer.
  if let furthest = distanceMap.max(by: { $0.value < $1.value }) {
    print(furthest.value)
  } else {
    print("No furthest point found")
  }
}

// Keeps going left and counting intersections.
func isInsideLoop(point: Point, loop: [Point: Int]) -> Bool {
  var lastCorner: Character? = nil
  var curr = point
  var intersections = 0

  while curr.isInBounds() {
    if loop[curr] == nil {
      curr = curr + Point(x: -1, y: 0)
      continue
    }

    switch data[curr] {
    case "|":  // True wall, definitely an intersection.
      intersections += 1
      break
    case ".":  // Don't care.
      break
    case "J":  // Bottom right corner.
      lastCorner = data[curr]
      break
    case "7":  // Top right corner.
      lastCorner = data[curr]
      break
    case "F":  // Top left corner. If before had a bottom right, then there's an intersection.
      if lastCorner == "J" {
        intersections += 1
      }
      lastCorner = nil
      break
    case "L":  // Bottom left corner. If before had a top right, then there's an intersection.
      if lastCorner == "7" {
        intersections += 1
      }
      lastCorner = nil
      break
    default:
      break
    }

    curr = curr + Point(x: -1, y: 0)
  }

  return intersections % 2 == 1
}

func solvePartTwo() {
  // This also contains the main loop. We don't care about min distance.
  let mainLoop = retrieveDistanceMap(start: start, doAllDirections: false)

  var count = 0
  for (x, y) in (0..<width).flatMap({ x in zip(repeatElement(x, count: height), 0..<height) }) {
    let point = Point(x: x, y: y)
    if mainLoop[point] != nil {
      continue
    }

    if isInsideLoop(point: point, loop: mainLoop) {
      count += 1
    }
  }

  print(count)
}

solvePartOne()
solvePartTwo()
