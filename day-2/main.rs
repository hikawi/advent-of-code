use regex::Regex;
use std::collections::HashMap;
use std::fs;

// Struct to hold the data for a single draw. Red balls, green balls, blue balls.
struct Draw {
    red: i32,
    green: i32,
    blue: i32,
}

fn read_data(path: &str) -> Vec<String> {
    // Read the data from file into a string, which is a Result type, unwrap yields a String.
    // Lines splits the string into an iterator over lines, map converts each line to a String.
    let data = fs::read_to_string(path);
    if data.is_err() {
        panic!("Could not read file!");
    }
    data.unwrap().lines().map(|s| s.to_string()).collect()
}

fn parse_pull(pull: &str) -> Draw {
    // A pull consists of multiples of a number and a color, e.g. 3 blue 2 green.
    let color_match = Regex::new(r"(\d+) (\w+)").unwrap();
    let mut draw = Draw {
        red: 0,
        green: 0,
        blue: 0,
    };

    for cap in color_match.captures_iter(pull) {
        let num = cap
            .get(1)
            .map(|m| m.as_str().parse::<i32>().unwrap())
            .unwrap();
        let color = cap.get(2).map(|m| m.as_str()).unwrap();

        match color {
            "red" => draw.red = num,
            "green" => draw.green = num,
            "blue" => draw.blue = num,
            _ => panic!("Unknown color!"),
        }
    }

    draw
}

fn parse_game_data(game_data: &str, id: i32, draws: &mut HashMap<i32, Vec<Draw>>) {
    // 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    let pulls: Vec<&str> = game_data.split(";").collect();
    for pull in pulls {
        let draw = parse_pull(pull);
        draws.get_mut(&id).unwrap().push(draw);
    }
}

fn parse_draws(s: String, draws: &mut HashMap<i32, Vec<Draw>>) {
    // Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    let game_match = Regex::new(r"Game (\d+): (.+)").unwrap();
    let game_match_caps = game_match.captures(s.as_str()).unwrap();

    // Read out id and game data.
    let id = game_match_caps
        .get(1)
        .map(|m| m.as_str().parse::<i32>().unwrap())
        .unwrap();
    let game_data = game_match_caps.get(2).unwrap().as_str();

    draws.insert(id, Vec::new());
    parse_game_data(game_data, id, draws);
}

// Part one is sum of all game ids where all draws are possible.
fn solve_part_one(draws: &mut HashMap<i32, Vec<Draw>>) {
    let max_red = 12;
    let max_green = 13;
    let max_blue = 14;

    // Local function to check if a draw is possible.
    let is_possible = |draw: &Draw| -> bool {
        draw.red <= max_red && draw.green <= max_green && draw.blue <= max_blue
    };

    let mut sum = 0;
    for (id, game_draws) in draws.iter() {
        // Increment sum if ALL draws are possible in 1 game.
        if game_draws.iter().map(is_possible).all(|it| it) {
            sum += id;
        }
    }

    println!("Part 1: {}", sum);
}

// Game power is max(reds) * max(greens) * max(blues)
fn get_game_power(draws: &Vec<Draw>) -> i32 {
    let reds = draws.iter().map(|d| d.red).max().unwrap();
    let greens = draws.iter().map(|d| d.green).max().unwrap();
    let blues = draws.iter().map(|d| d.blue).max().unwrap();
    reds * greens * blues
}

// Part two is sum of all game power.
fn solve_part_two(draws: &mut HashMap<i32, Vec<Draw>>) {
    let result: i32 = draws
        .iter()
        .map(|(_, game_draws)| get_game_power(game_draws))
        .sum();
    println!("Part 2: {}", result);
}

fn main() {
    let data = read_data("input.txt");
    let mut draws: HashMap<i32, Vec<Draw>> = HashMap::new();
    for line in data {
        parse_draws(line, &mut draws);
    }

    solve_part_one(&mut draws);
    solve_part_two(&mut draws);
}
