import fs from "fs";

// Read input file
const data = fs
  .readFileSync("./input.txt", "utf-8")
  .split("\n\n")
  .map((line) => line.trim());

// The data after parsing.
const seeds = [];
const seedToSoil = [];
const soilToFertilizer = [];
const fertilizerToWater = [];
const waterToLight = [];
const lightToTemperature = [];
const temperatureToHumidity = [];
const humidityToLocation = [];

// Parse a line of seeds ("seeds: 12 3 4 5")
function parseSeeds(line) {
  line
    .split(": ")[1]
    .split(" ")
    .forEach((seed) => seeds.push(parseInt(seed)));
}

// Parse a map of something to something and store it into an array.
function parseMapping(array, data) {
  data
    .split("\n")
    .slice(1, data.length)
    .map((comp) => comp.split(" ").map((c) => parseInt(c)))
    .forEach((mapping) => {
      array.push({
        desStart: mapping[0],
        srcStart: mapping[1],
        srcEnd: mapping[1] + mapping[2],
      });
    });
}

function parse() {
  parseSeeds(data[0]);
  parseMapping(seedToSoil, data[1]);
  parseMapping(soilToFertilizer, data[2]);
  parseMapping(fertilizerToWater, data[3]);
  parseMapping(waterToLight, data[4]);
  parseMapping(lightToTemperature, data[5]);
  parseMapping(temperatureToHumidity, data[6]);
  parseMapping(humidityToLocation, data[7]);
}

// Part 1.
// The lowest location for all seeds after mappings.
function safeMap(array, key) {
  const mapping = array.find(
    (item) => item.srcStart <= key && item.srcEnd > key
  );
  return mapping ? mapping.desStart + key - mapping.srcStart : key;
}

function getLocation(seed) {
  let location = seed;
  location = safeMap(seedToSoil, location);
  location = safeMap(soilToFertilizer, location);
  location = safeMap(fertilizerToWater, location);
  location = safeMap(waterToLight, location);
  location = safeMap(lightToTemperature, location);
  location = safeMap(temperatureToHumidity, location);
  location = safeMap(humidityToLocation, location);
  return location;
}

function solvePartOne() {
  const lowestLocation = seeds.map(getLocation).sort((a, b) => a - b)[0];
  console.log(lowestLocation);
}

// Part 2.
// The seeds are actually ranges of seeds also. For example, seeds: 51 5, means 5 seeds starting from 51.
function coerceRangeIn(range, mapper) {
  //   console.log("Mapping", range, "with", mapper);

  const { desStart, srcStart, srcEnd } = mapper;
  const { start, end } = range;

  // Can't be mapped if the ranges don't overlap.
  if (srcEnd <= start || srcStart >= end)
    return { mapped: [], unmapped: [range] };

  // What if the range includes the entire mapper?
  // The unmapped part would be the range before the mapper and the range after the mapper.
  if (start <= srcStart && end >= srcEnd) {
    const unmapped = [
      { start: start, end: srcStart },
      { start: srcEnd, end: end },
    ];
    return {
      mapped: [{ start: desStart, end: desStart + srcEnd - srcStart }],
      unmapped,
    };
  }

  // If the range is fully contained in the mapper, then it's fully mapped.
  if (srcStart <= start && srcEnd >= end) {
    const mappedRange = {
      start: desStart + start - srcStart,
      end: desStart + end - srcStart,
    };
    return { mapped: [mappedRange], unmapped: [] };
  }

  // Ok, it's only partially contained.
  // Partially contained, but the mapper is to the left of the range.
  if (srcStart <= start && srcEnd <= end) {
    const mappedRange = {
      start: desStart + start - srcStart,
      end: desStart + srcEnd - srcStart,
    };
    const unmappedRange = { start: srcEnd, end: end };
    return { mapped: [mappedRange], unmapped: [unmappedRange] };
  }

  // Partially contained, but the mapper is to the right of the range.
  if (srcStart >= start && srcEnd >= end) {
    const mappedRange = {
      start: desStart + srcStart - srcStart,
      end: desStart + end - srcStart,
    };
    const unmappedRange = { start: start, end: srcStart };
    return { mapped: [mappedRange], unmapped: [unmappedRange] };
  }

  // This should never happen.
  throw new Error("???");
}

// Maps a range of seeds to a range of something else.
function mapRange(array, range) {
  const unmapped = [range];
  const mapped = [];

  for (const mapper of array) {
    if (unmapped.length === 0) break;

    const { mapped: newMapped, unmapped: newUnmapped } = coerceRangeIn(
      unmapped.shift(),
      mapper
    );
    mapped.push(...newMapped);
    unmapped.unshift(...newUnmapped);
  }

  mapped.push(...unmapped);
  return mapped;
}

// Creates a partially applied mapRange function.
function mapRangeFunc(array) {
  return (range) => mapRange(array, range);
}

// The magical part.
// I DID IT
// OMG
// WAIT THIS IS HOT
function solvePartTwo() {
  const seedRanges = [];
  for (let i = 0; i < seeds.length; i += 2)
    seedRanges.push({ start: seeds[i], end: seeds[i] + seeds[i + 1] });

  const locations = seedRanges
    .flatMap(mapRangeFunc(seedToSoil))
    .flatMap(mapRangeFunc(soilToFertilizer))
    .flatMap(mapRangeFunc(fertilizerToWater))
    .flatMap(mapRangeFunc(waterToLight))
    .flatMap(mapRangeFunc(lightToTemperature))
    .flatMap(mapRangeFunc(temperatureToHumidity))
    .flatMap(mapRangeFunc(humidityToLocation));

  // Pick out the smallest location in each range returned.
  const lowestRange = locations.reduce((prev, cur) =>
    cur.start < prev.start ? cur : prev
  );
  console.log(lowestRange.start);
}

parse();
solvePartOne();
solvePartTwo();
