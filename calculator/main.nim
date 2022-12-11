# Learning Nim
# Part 1: Simple Calculator

import std/strutils
import strformat

var
    x: int
    y: int
    op: string

proc get_number_input(input: string): int =
    try:
        return parseInt(input)
    except ValueError:
        echo "You should enter a number!"
        quit(0)

proc get_operator(op: string): string =
    if op notin ["+", "-", "/", "*"]:
        echo "Not a valid operator!"
        quit(0)
    return op

stdout.write("Enter a number: ")
x = get_number_input(stdin.readLine())

stdout.write("Enter an operator: ")
op = get_operator(stdin.readLine())

stdout.write("Enter another number: ")
y = get_number_input(stdin.readLine())

case op
of "+":
    echo fmt"Answer: {x + y}"
of "-":
    echo fmt"Answer: {x - y}"
of "/":
    echo fmt"Answer: {x / y}"
of "*":
    echo fmt"Answer: {x * y}"
else:
    echo "Unknown operator"