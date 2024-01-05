import scala.collection.mutable
import scala.util.control.Breaks.{break, breakable}

type Grid = Array[Array[Char]]

// A simple read file. Just gives a 2D array of characters.
def readFile(): Grid =
  val list = mutable.ArrayBuffer[Array[Char]]()
  io.Source
    .fromFile("input.txt")
    .getLines
    .foreach(line => list += line.toCharArray)
  list.toArray

// Checks if we can roll a stone onto pos. If pos is out of bounds or already has a stone, then we can't.
def isEmpty(map: Grid, pos: (Int, Int)): Boolean =
  val (x, y) = pos
  x >= 0 && y >= 0 && y < map.length && x < map(y).length && map(y)(x) == '.'

// Tilt the entire matrix in a direction. We do this by iterating through the matrix in the direction we want to tilt.
// If we're tilting downwards to the left, we want to start with the rightmost column, etc.
def tilt(map: Grid, dir: (Int, Int)) =
  for
    y <- if dir._2 < 0 then 0 until map.length else (0 until map.length).reverse
    x <- if dir._1 < 0 then 0 until map(y).length else (0 until map(y).length).reverse
    if map(y)(x) == 'O'
  do move(map, (x, y), dir)
end tilt

// Try to move a single rock. Just iterating until we hit a wall or another rock.
def move(map: Grid, block: (Int, Int), dir: (Int, Int)): Unit =
  var (x, y) = block
  var (dx, dy) = dir
  while isEmpty(map, (x + dx, y + dy)) do
    x += dx
    y += dy
  map(block._2)(block._1) = '.'
  map(y)(x) = 'O'

// Calculate the load using the algorithm provided by the prompt.
def countLoad(map: Grid): Long =
  map.zipWithIndex.map((arr, y) => arr.count(_ == 'O') * (map.length - y)).sum

// Part one is tilting NORTH once.
def solvePartOne() =
  val rocks = readFile()
  tilt(rocks, (0, -1))
  println(countLoad(rocks))

// Tilt the map in a cycle of 4 directions: NORTH, WEST, SOUTH, EAST.
def tiltCycle(map: Grid, memo: mutable.Map[String, Grid] = mutable.Map()) =
  val dirs = List((0, -1), (-1, 0), (0, 1), (1, 0))
  dirs.foreach(dir => tilt(map, dir))

// Part two is tilting the map until we find a loop. Then we can calculate the load at the 1,000,000,000th iteration.
def solvePartTwo(): Unit =
  var rocks = readFile()
  val seenKeys = mutable.Map[String, Int]()

  var firstMatch = -1
  var secondMatch = -1

  // Try to find the loop first. Hope that it exists in the first 1000 iterations.
  breakable {
    for i <- 1 to 1_000 do
      tiltCycle(rocks)
      val key = rocks.map(_.mkString).mkString
      seenKeys.get(key) match
        case Some(value) =>
          firstMatch = value
          secondMatch = i
          break
        case None => seenKeys(key) = i
  }

  val loop = secondMatch - firstMatch
  val iterations = 1_000_000_000
  val at = (iterations - firstMatch) % loop + firstMatch

  // Reset and do it again, but at a much smaller scale
  rocks = readFile()
  println(s"Iteration #1,000,000,000 is the same at iteration #${at}")
  for i <- 1 to at do tiltCycle(rocks)
  println(countLoad(rocks))
end solvePartTwo

@main
def main(): Unit = {
  solvePartOne()
  solvePartTwo()
}
