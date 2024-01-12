import * as fs from "fs";

const [workflows, parts] = fs
  .readFileSync("./input.txt")
  .toString()
  .split("\n\n")
  .map((part) => part.split("\n").filter((line) => line.length > 0));

// =============================
// For handling parts.
// =============================
const partRegex = /\{x=(.+),m=(.+),a=(.+),s=(.+)\}/g;
const machineParts: Part[] = [];
const propertyDictionary: any = {
  x: 0,
  m: 1,
  a: 2,
  s: 3,
};
const defaultRange = { min: 1, max: 4000 };

class Part {
  properties: number[];

  constructor(line: string) {
    const groups = line.matchAll(partRegex).next().value;
    this.properties = groups.slice(1, 5).map((i: any) => parseInt(i));
  }

  sum(): number {
    return this.properties.reduce((a, b) => a + b, 0);
  }
}

parts.map((p) => new Part(p)).forEach((p) => machineParts.push(p));

class PartRange {
  propertyRanges: { min: number; max: number }[] = [defaultRange, defaultRange, defaultRange, defaultRange];

  // Clone a part range.
  clone(): PartRange {
    const copy = new PartRange();
    copy.propertyRanges = this.propertyRanges.map((r) => ({ ...r }));
    return copy;
  }

  // Count the number of combinations in this range.
  count(): number {
    return this.propertyRanges.map((r) => (r.min <= r.max ? r.max - r.min + 1 : 0)).reduce((a, b) => a * b, 1);
  }
}

// =============================
// For handling each predicate or statement line.
// =============================
const predicateRegex = /(\w)(<|>)(\d+):(.+)/g;

class Statement {
  condition?: { property: string; comparison: string; value: number };
  result: string;

  constructor(line: string) {
    const groups = line.matchAll(predicateRegex).next().value;
    if (groups) {
      this.condition = { property: groups[1], comparison: groups[2], value: parseInt(groups[3]) };
      this.result = groups[4];
      return;
    }

    this.condition = undefined;
    this.result = line;
  }

  // Restrict a range down to the condition, if it exists.
  // For example, with a range of [1, 2000], and the condition "x<1000", the range will be restricted to [1, 999].
  restrict(range: PartRange): PartRange {
    const copy = range.clone();
    if (this.condition)
      if (this.condition.comparison == "<") copy.propertyRanges[propertyDictionary[this.condition.property]].max = this.condition.value - 1;
      else copy.propertyRanges[propertyDictionary[this.condition.property]].min = this.condition.value + 1;
    return copy;
  }

  // Walk around the condition, if it exists.
  // For example, with a range of [1, 2000], and the condition "x<1000", the range will be restricted to [1000, 2000].
  walkaround(range: PartRange): PartRange {
    const copy = range.clone();
    if (this.condition)
      if (this.condition.comparison == "<") copy.propertyRanges[propertyDictionary[this.condition.property]].min = this.condition.value;
      else copy.propertyRanges[propertyDictionary[this.condition.property]].max = this.condition.value;
    return copy;
  }

  // Execute the statement on a part.
  execute(p: Part): string {
    if (this.condition) {
      const field = p.properties[propertyDictionary[this.condition.property]];
      if (this.condition.comparison == "<") return field < this.condition.value ? this.result : "";
      return field > this.condition.value ? this.result : "";
    }
    return this.result;
  }
}

// =============================
// For handling each functions/workflows.
// =============================
const functionRegex = /(\w+)\{(.+)\}/g;
const functions: Map<string, Function> = new Map();

class Function {
  name: string;
  statements: Statement[];

  constructor(line: string) {
    const groups = line.matchAll(functionRegex).next().value;
    this.name = groups[1];
    this.statements = groups[2].split(",").map((s: any) => new Statement(s as string));
    functions.set(this.name, this);
  }

  execute(p: Part): string {
    for (const statement of this.statements) {
      const res = statement.execute(p);
      if (res.length > 0) return res;
    }
    throw new Error("This should never happen~~");
  }

  feed(range: PartRange, accepted: PartRange[]) {
    range = range.clone();
    for (const statement of this.statements) {
      if (statement.result == "A") {
        accepted.push(statement.restrict(range));
        range = statement.walkaround(range);
        continue;
      }

      if (statement.result == "R") {
        range = statement.walkaround(range);
        continue;
      }

      const passOn = statement.condition ? statement.restrict(range) : range;
      functions.get(statement.result)?.feed(passOn, accepted);
      range = statement.walkaround(range);
    }
  }
}

workflows.map((w) => new Function(w));

// =============================
// THE ACTUAL PROBLEM
// =============================

// Part one: Find all accepted parts, and sum their values.
function handle(part: Part): boolean {
  let cur = functions.get("in")!;
  let res = "";
  while (res != "R" && res != "A") {
    res = cur.execute(part);
    cur = functions.get(res)!;
  }
  return res == "A";
}

function solvePartOne() {
  console.log(machineParts.filter(handle).reduce((a, b) => a + b.sum(), 0));
}

// Part two: Find all combinations of ratings where the part is accepted.
function solvePartTwo() {
  const accepted: PartRange[] = [];
  const startRange = new PartRange();
  functions.get("in")!.feed(startRange, accepted);
  console.log(accepted.map((r) => r.count()).reduce((a, b) => a + b, 0));
}

solvePartOne();
solvePartTwo();
