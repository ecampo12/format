# format

[![Package Version](https://img.shields.io/hexpm/v/format)](https://hex.pm/packages/format)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/format/)

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

  
}
```

Further documentation can be found at <https://hexdocs.pm/format>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
