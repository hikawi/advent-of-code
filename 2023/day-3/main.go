package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
	"unicode"
)

type Coord struct {
	x int
	y int
}

type Number struct {
	value string
	pos   Coord
}

type Grid struct {
	width, height int
	symbols       map[Coord]byte
	numbers       []Number
}

// Check if is digit.
func IsDigit(char byte) bool {
	return unicode.IsDigit(rune(char))
}

// Check if symbol and not a dot.
func IsSymbol(char byte) bool {
	return !IsDigit(char) && char != '.'
}

// Returns coords of all VALID neighbors.
func (g *Grid) GetNeighbors(coord Coord) (neighbors []Coord) {
	unchecked := []Coord{{coord.x + 1, coord.y}, {coord.x - 1, coord.y}, {coord.x, coord.y - 1}, {coord.x, coord.y + 1}, {coord.x - 1, coord.y - 1}, {coord.x - 1, coord.y + 1}, {coord.x + 1, coord.y - 1}, {coord.x + 1, coord.y + 1}}
	for _, pos := range unchecked {
		if pos.x < 0 || pos.x >= g.width || pos.y < 0 || pos.y >= g.height {
			continue
		}
		neighbors = append(neighbors, pos)
	}

	return neighbors
}

// Track the number and returns the index AFTER the number.
func (g *Grid) TrackNumber(line string, y int, x *int) {
	numberString := ""
	startingX := *x

	for *x < len(line) && unicode.IsDigit(rune(line[*x])) {
		numberString += string(line[*x])
		*x = *x + 1
	}

	// Add the number to the list.
	var num Number
	num.value = numberString
	num.pos.x = startingX
	num.pos.y = y
	g.numbers = append(g.numbers, num)
}

// Set data for a line.
func (g *Grid) TrackLine(line string, y int) {
	i := 0
	for i < len(line) {
		// If is symbol and not a dot, add to the list of symbols.
		if IsSymbol(line[i]) {
			g.symbols[Coord{i, y}] = line[i]
		} else if IsDigit(line[i]) {
			g.TrackNumber(line, y, &i)
			continue
		}

		i++
	}
}

// Check if there is a symbol around the position.
func (g *Grid) HasSymbolArround(pos Coord) bool {
	for _, neighbor := range g.GetNeighbors(pos) {
		if g.symbols[neighbor] != 0 {
			return true
		}
	}
	return false
}

// List out all coords of gears.
func (g *Grid) Stars() (stars []Coord) {
	for coord, symbol := range g.symbols {
		if symbol == '*' {
			stars = append(stars, coord)
		}
	}
	return stars
}

// Read data from file into a usable format.
func ReadData(fileName string) Grid {
	file, err := os.ReadFile(fileName)
	if err != nil {
		panic(err)
	}

	// Get the width and height of the grid.
	var grid Grid
	lines := strings.Split(string(file), "\n")
	grid.height = len(lines) - 1
	grid.width = len(lines[0])
	grid.symbols = make(map[Coord]byte)
	grid.numbers = make([]Number, 0)

	// Loop over each line to get the data.
	for y, line := range lines {
		grid.TrackLine(line, y)
	}

	return grid
}

// Part one is sum of all numbers that have at least a symbol around them.
func SolvePartOne(grid *Grid) {
	// Check surrounding for each number.
	total := 0
	for _, number := range grid.numbers {
		for x := number.pos.x; x < number.pos.x+len(number.value); x++ {
			if grid.HasSymbolArround(Coord{x, number.pos.y}) {
				val, err := strconv.Atoi(number.value)
				if err != nil {
					panic(err)
				}
				total += val
				break
			}
		}
	}

	// Print
	fmt.Println("Part 1:", total)
}

// Part two is sum of products of number pairs adjacent to "gears" (* symbol).
func SolvePartTwo(grid *Grid) {
	trackedStars := make(map[Coord][]int)

	// Loop over each number.
	for _, number := range grid.numbers {
		// Map to make sure we don't count the same gear twice.
		localGears := make(map[Coord]int)

		for x := number.pos.x; x < number.pos.x+len(number.value); x++ {
			// Log a gear if found.
			for _, neighbor := range grid.GetNeighbors(Coord{x, number.pos.y}) {
				if grid.symbols[neighbor] == '*' && localGears[neighbor] == 0 {
					localGears[neighbor] = 1
				}
			}
		}

		// Add to the count.
		for gear := range localGears {
			val, _ := strconv.Atoi(number.value)
			trackedStars[gear] = append(trackedStars[gear], val)
		}
	}

	// TrackedStars is now a map of <star, list of numbers around it>.
	// If the list count == 2, then it is a GEAR.
	// The power of a gear is the product of the two numbers around it.
	// The total is the sum of all powers, which is the result.
	total := 0
	for _, numbers := range trackedStars {
		if len(numbers) == 2 {
			total += numbers[0] * numbers[1]
		}
	}

	fmt.Println("Part 2:", total)
}

func main() {
	grid := ReadData("input.txt")

	SolvePartOne(&grid)
	SolvePartTwo(&grid)
}
