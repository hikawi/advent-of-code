import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayDeque;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.stream.Stream;
import java.util.Arrays;

class Main {

    private static int MAX_WIDTH;
    private static int MAX_HEIGHT;

    private record Coord(int x, int y) {
    }

    private enum Direction {
        UP(0, -1), DOWN(0, 1), LEFT(-1, 0), RIGHT(1, 0);

        final int x;
        final int y;

        Direction(int x, int y) {
            this.x = x;
            this.y = y;
        }
    }

    private record Beam(Coord position, Direction direction) {
        public Beam move() {
            return new Beam(new Coord(position.x + direction.x, position.y + direction.y), direction);
        }

        public Beam[] hit(char ch) {
            var self = new Beam[] { this };
            return switch (direction) {
                case DOWN -> switch (ch) {
                    case '|' -> new Beam[] { new Beam(position, Direction.DOWN) };
                    case '/' -> new Beam[] { new Beam(position, Direction.LEFT) };
                    case '\\' -> new Beam[] { new Beam(position, Direction.RIGHT) };
                    case '-' -> new Beam[] { new Beam(position, Direction.LEFT), new Beam(position, Direction.RIGHT) };
                    default -> self;
                };
                case UP -> switch (ch) {
                    case '|' -> new Beam[] { new Beam(position, Direction.UP) };
                    case '/' -> new Beam[] { new Beam(position, Direction.RIGHT) };
                    case '\\' -> new Beam[] { new Beam(position, Direction.LEFT) };
                    case '-' -> new Beam[] { new Beam(position, Direction.LEFT), new Beam(position, Direction.RIGHT) };
                    default -> self;
                };
                case LEFT -> switch (ch) {
                    case '|' -> new Beam[] { new Beam(position, Direction.UP), new Beam(position, Direction.DOWN) };
                    case '/' -> new Beam[] { new Beam(position, Direction.DOWN) };
                    case '\\' -> new Beam[] { new Beam(position, Direction.UP) };
                    case '-' -> new Beam[] { new Beam(position, Direction.LEFT) };
                    default -> self;
                };
                case RIGHT -> switch (ch) {
                    case '|' -> new Beam[] { new Beam(position, Direction.UP), new Beam(position, Direction.DOWN) };
                    case '/' -> new Beam[] { new Beam(position, Direction.UP) };
                    case '\\' -> new Beam[] { new Beam(position, Direction.DOWN) };
                    case '-' -> new Beam[] { new Beam(position, Direction.RIGHT) };
                    default -> self;
                };
                default -> self;
            };
        }
    }

    private static Map<Coord, Character> readInput() throws Exception {
        var map = new HashMap<Coord, Character>();
        var lines = Files.readAllLines(Path.of("input.txt"));

        MAX_HEIGHT = lines.size();
        MAX_WIDTH = lines.get(0).length();

        for (int y = 0; y < lines.size(); y++) {
            var line = lines.get(y);
            for (int x = 0; x < line.length(); x++)
                if (line.charAt(x) != '.')
                    map.put(new Coord(x, y), line.charAt(x));
        }
        return map;
    }

    private static int moveBeam(final Map<Coord, Character> map, final Coord startPosition,
            final Direction startDirection) {
        var cache = new HashMap<Coord, Direction>();
        var deque = new ArrayDeque<Beam>();
        deque.add(new Beam(startPosition, startDirection));

        while (!deque.isEmpty()) {
            var next = deque.pollFirst();
            if (next.position.x < 0 || next.position.x >= MAX_WIDTH || next.position.y < 0
                    || next.position.y >= MAX_HEIGHT)
                continue;
            if (cache.getOrDefault(next.position, null) == next.direction)
                continue;

            cache.put(next.position, next.direction);
            var beams = next.hit(map.getOrDefault(next.position, '.'));
            deque.addAll(Stream.of(beams).map(Beam::move).toList());
        }

        return cache.size();
    }

    private static void solvePartOne(final Map<Coord, Character> map) {
        System.out.println(moveBeam(map, new Coord(0, 0), Direction.RIGHT));
    }

    // Oh bruteforce is fast enough... Cool I guess. I wouldn't know how to even
    // optimize this.
    private static void solvePartTwo(final Map<Coord, Character> map) {
        int max = 0;

        // Check all top row.
        for (int x = 0; x < MAX_WIDTH; x++)
            max = Math.max(max, moveBeam(map, new Coord(x, 0), Direction.DOWN));

        // Check all bottom row.
        for (int x = 0; x < MAX_WIDTH; x++)
            max = Math.max(max, moveBeam(map, new Coord(x, MAX_HEIGHT - 1), Direction.UP));

        // Check all left column.
        for (int y = 0; y < MAX_HEIGHT; y++)
            max = Math.max(max, moveBeam(map, new Coord(0, y), Direction.RIGHT));

        // Check all right column.
        for (int y = 0; y < MAX_HEIGHT; y++)
            max = Math.max(max, moveBeam(map, new Coord(MAX_WIDTH - 1, y), Direction.LEFT));

        System.out.println(max);
    }

    public static void main(String[] args) throws Exception {
        var input = readInput();
        solvePartOne(input);
        solvePartTwo(input);
    }

}
