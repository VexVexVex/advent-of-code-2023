import "io" for File
var text = File.read("input")
var games = text.split("\n")
var total = 0
for (i in 0..games.count-1) {
    if (games[i] == "") {
        continue
    }
    var game = games[i]
    game = game.split(":")[1]
    var possible = true
    var red = 0
    var blue = 0
    var green = 0
    for (round in game.split(";")) {
        for (type in round.split(",")) {
            var amount = Num.fromString(type.split(" ")[1])
            if (type.contains("green") && amount > green) green = amount
            if (type.contains("red") && amount > red) red = amount
            if (type.contains("blue") && amount > blue) blue = amount
        }
    }
    total = total + (red * blue * green)
}
System.print(total)