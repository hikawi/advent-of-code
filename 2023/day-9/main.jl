data = readlines("input.txt") |> it -> map(line -> split(strip(line), " ") |> arr -> map(num -> tryparse(Int64, num), arr), it)

# f is the function to get the number to add.
# op is the function to fold with.
function extrapolate(original, f, op)
    nums = []
    while !allequal(original)
        append!(nums, f(original))
        original = [original[i+1] - original[i] for i in 1:length(original)-1]
    end
    append!(nums, f(original))
    foldr(op, nums, init=0)
end

# Part one is extrapolating forwards. Part two is extrapolating backwards.
map(line -> extrapolate(line, last, +), data) |> sum |> println
map(line -> extrapolate(line, first, -), data) |> sum |> println
