import java.io.File
import kotlin.math.abs
import kotlin.math.absoluteValue

data class Instruction(val dir: Coord, val dist: Long, val hex: String) {
    // Part two has a rebuilding the instruction set part.
    fun rebuild(): Instruction {
        // Last character of the hex code is the direction.
        val newDir = getDirection(
            when (hex.last()) {
                '0' -> "R"
                '1' -> "D"
                '2' -> "L"
                '3' -> "U"
                else -> throw IllegalArgumentException("Invalid hex: $hex")
            }
        )
        
        // The previous 5 characters are the distance in base-16. The drop(1) is to drop the #.
        val newDist = hex.drop(1).take(5).toLong(16)
        return Instruction(newDir, newDist, hex)
    }
}

data class Coord(val x: Long, val y: Long) {
    operator fun plus(other: Coord) = Coord(x + other.x, y + other.y)
    operator fun times(scalar: Long) = Coord(x * scalar, y * scalar)
}

fun getDirection(dir: String): Coord = when (dir) {
    "R" -> Coord(1, 0)
    "L" -> Coord(-1, 0)
    "U" -> Coord(0, -1)
    "D" -> Coord(0, 1)
    else -> throw IllegalArgumentException("Invalid direction: $dir")
}

// The input.
val regex = Regex("(\\w+) (\\d+) \\((.+)\\)")
val input = File("./input.txt").readLines().map {
    regex.matchEntire(it)!!.destructured.let { (dir, dist, hex) -> Instruction(getDirection(dir), dist.toLong(), hex) }
}

// Create a polygon from the instructions.
// Consists of a list with coords where the edge stops.
fun makePolygon(instructions: List<Instruction>): List<Coord> {
    val coords = mutableListOf(Coord(0, 0))
    instructions.fold(Coord(0, 0)) { acc, instr ->
        (acc + instr.dir * instr.dist).also { coords.add(it) }
    }
    return coords
}

// Shoelace Formula
// The area of a polygon, given a list of coordinates.
// For each 2 consecutive coord, take x1 * y2 - x2 * y1.
// Sum all, we have two times the area.
// Absolute value because we don't know if the polygon is "positively-oriented", it will be negative if it's not. But area is still the same.
fun calculateArea(polygon: List<Coord>): Double = (polygon + polygon.first()).windowed(2).sumOf { (left, right) ->
    left.x * right.y - left.y * right.x
}.div(2.0).absoluteValue

// Count the number of points on the exterior of the polygon.
fun countExteriorPoints(polygon: List<Coord>): Long = (polygon + polygon.first()).windowed(2).sumOf { (left, right) ->
    if (left.x == right.x)
        abs(left.y - right.y)
    else
        abs(left.x - right.x)
}

// Solve using Pick's theorem.
// Area = InteriorPoints + ExteriorPoints / 2 - 1
// The interior points is the number of blocks we dug inside.
fun solve(rebuild: Boolean) {
    val polygon = makePolygon(if(rebuild) input.map { it.rebuild() } else input)
    val area = calculateArea(polygon)
    val exterior = countExteriorPoints(polygon)
    val interior = area + 1 - exterior / 2.0
    println((interior + exterior).toLong())
}

fun main() {
    solve(false) // Part 1: No rebuilding.
    solve(true)  // Part 2: With rebuilding.
}

