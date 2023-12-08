defmodule Node do
  def parse_node(node) do
    [_unusued, node, left, right] = Regex.run(~r/(.+) = \((.+), (.+)\)/, node)
    {node, {left, right}}
  end
end

# Reading file contents and splitting into data.
data = File.read!("input.txt") |> String.split("\n", trim: true)
instruction = Enum.at(data, 0) |> String.to_charlist()
nodes = Enum.slice(data, 1..-1) |> Enum.map(&Node.parse_node/1) |> Map.new()

defmodule Traversals do
  def get_next(current, instruction, index, map) do
    case Enum.at(instruction, index) do
      ?L -> map[current] |> elem(0)
      ?R -> map[current] |> elem(1)
    end
  end

  def is_zzz(current) do
    current == "ZZZ"
  end

  def ends_with_z(current) do
    String.ends_with?(current, "Z")
  end

  # Keep traversing until a node is found that satisfies the predicate.
  def traverse_until(current, instruction, map, pred \\ &is_zzz/1, index \\ 0, steps \\ 0) do
    if pred.(current) do
      steps
    else
      next_index = rem(index + 1, length(instruction))
      next = get_next(current, instruction, index, map)
      traverse_until(next, instruction, map, pred, next_index, steps + 1)
    end
  end
end

defmodule Day8 do
  def solve_part_one(nodes, instruction) do
    Traversals.traverse_until("AAA", instruction, nodes) |> IO.inspect()
  end

  def lcm(a, b) do
    div(a * b, Integer.gcd(a, b))
  end

  def solve_part_two(nodes, instruction) do
    nodes
    |> Enum.map(fn {node, {_, _}} -> node end)
    |> Enum.filter(fn node -> String.ends_with?(node, "A") end)
    |> Enum.map(fn node ->
      Traversals.traverse_until(node, instruction, nodes, &Traversals.ends_with_z/1)
    end)
    |> Enum.reduce(1, fn x, acc -> lcm(x, acc) end)
    |> IO.inspect()
  end
end

Day8.solve_part_one(nodes, instruction)
Day8.solve_part_two(nodes, instruction)
