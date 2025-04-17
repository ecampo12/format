# Format

[![Package Version](https://img.shields.io/hexpm/v/format)](https://hex.pm/packages/format)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/format/)

A simple Gleam library for formatting strings. It provides the formatting functionality of erlangs `io_lib:format/2` function.

For on erlang string formatting please visit this erlang doc page for more information:
https://www.erlang.org/doc/apps/stdlib/io#fwrite/3

## Installation
```sh
gleam add format@1
```
```gleam
import gleam/format.{sprintf, printf}

pub fn main() {
  let format = sprintf("Hello, ~s!", "world")
  io.println(format)
  // => Ok("Hello, world!")

  // Format a string with a single argument
  sprintf("Hello ~s", <<119, 111, 114, 108, 100, 33>>)
  //=> Ok("Hello world!")

  // Format a string with multiple arguments by passing a list
  sprintf("Hello ~s ~s", ["world!", "Extra!"])
  //=> Ok("Hello world! Extra!")

  // Format a string with multiple different types of arguments by passing a tuple
  sprintf("Hello ~s ~b", #("world!", 100))
  //=> Ok("Hello world! 100")

  printf("|~10.5c|~-10.5c|~5c|~n", [97, 98, 99])
  // => "|     aaaaa|bbbbb     |ccccc|\n"

  printf("~s ~s ~s", ["hello", "world", "gleam"])
  // => "hello world gleam"

  let t = TestClass("Test", 69)
  printf("Hello ~p", [t])
  // => "Hello {test_class,<<\"Test\">>,69}"
  
  printf("Hello ~s ~s ~b", t)
  //=> "Hello test_class Test 69"
}
```

Further documentation can be found at <https://hexdocs.pm/format>.

## Notes
The module functions can take a list of arguments or a tuple. If you pass a tuple, it will be unpacked into a list. If  the user passes a tuple as a single argument, they must provide a format string with appropriate format specifier for each element in the tuple. Erlang treats user defined types as tuples. See the example above.:

## Development
```sh
gleam run   # Run the project
gleam test  # Run the tests
```
