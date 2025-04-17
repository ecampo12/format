/// A simple wrapper around the Erlang `io_lib:format/2` function to format strings in Gleam.
import gleam/io

pub type FormatError {
  FormatError(message: String)
}

/// Returns a formatted string using the given format string and arguments or an error.
/// 
/// Note: The function can take a list of arguments or a tuple. If you pass a tuple, it will be unpacked into a list. 
/// If  the user passes a tuple as a single argument, they must provide a format string with appropriate format specifier 
/// for each element in the tuple. Erlang treats user defined types as tuples. See the examples below.
/// ## Examples
/// ```gleam
/// import gleam/format.{sprintf}
/// 
/// // Format a string with a single argument
/// sprintf("Hello ~s", <<119, 111, 114, 108, 100, 33>>)
/// //=> Ok("Hello world!")
/// 
/// // Format a string with multiple arguments by passing a list
/// sprintf("Hello ~s ~s", ["world!", "Extra!"])
/// //=> Ok("Hello world! Extra!")
/// 
/// // Format a string with multiple different types of arguments by passing a tuple
/// sprintf("Hello ~s ~b", #("world!", 100))
/// //=> Ok("Hello world! 100")
/// 
/// sprintf("1, 2, 3, ~b", [4])
/// //=> Ok("1, 2, 3, 4")
/// 
/// let t = TestClass("Test", 69)
/// sprintf("Hello ~p", [t])
/// // => Ok("Hello {test_class,<<\"Test\">>,69}")
///
/// sprintf("Hello ~s ~s ~b", t)
/// //=> Ok("Hello test_class Test 69")
/// 
/// sprintf("~p", #([1, 3]))
/// //=> Ok("[1,3]")
/// 
/// sprintf("~p", [[1, 3]])
/// //=> Ok("[1,3]")
/// 
/// sprintf("~p", #(#(1, 3)))
/// //=> Ok("{1,3}")
/// 
/// sprintf("This should ~a", "fail")
/// //=> Error("Make sure the arguments match the format string.")
/// ```
/// 
/// Visit this erlang doc page for more information on string formatting:
/// https://www.erlang.org/doc/apps/stdlib/io#fwrite/1
@external(erlang, "gleam_format", "erl_format")
pub fn sprintf(format: String, args: a) -> Result(String, FormatError)

/// Print a formatted string to the standard output or an error message if the format fails.
/// 
/// Note: The function can take a list of arguments or a tuple. If you pass a tuple, it will be unpacked into a list. 
/// If  the user passes a tuple as a single argument, they must provide a format string with appropriate format specifier 
/// for each element in the tuple. Erlang treats user defined types as tuples. See the examples below.
/// ## Examples
/// ```gleam
/// import gleam/format.{printf}
/// 
/// // Format a string with a single argument
/// printf("Hello ~s", <<119, 111, 114, 108, 100, 33>>)
/// //=> "Hello world!"
/// 
/// // Format a string with multiple arguments by passing a list
/// printf("Hello ~s ~s", ["world!", "Extra!"])
/// //=> "Hello world! Extra!"
/// 
/// // Format a string with multiple different types of arguments by passing a tuple
/// printf("Hello ~s ~b", #("world!", 100))
/// //=> "Hello world! 100"
/// 
/// printf("1, 2, 3, ~b", [4])
/// //=> "1, 2, 3, 4"
/// 
/// let t = TestClass("Test", 69)
/// printf("Hello ~p", [t])
/// // => "Hello {test_class,<<\"Test\">>,69}"
///
/// printf("Hello ~s ~s ~b", t)
/// //=> "Hello test_class Test 69"
/// 
/// printf("~p", #([1, 3]))
/// //=> "[1,3]"
/// 
/// printf("~p", [[1, 3]])
/// //=> "[1,3]"
/// 
/// printf("~p", #(#(1, 3)))
/// //=> "{1,3}"
/// 
/// printf("This should ~a", "fail")
/// //=> "Make sure the arguments match the format string."
/// ```
/// 
/// Visit this erlang doc page for more information on string formatting:
/// https://www.erlang.org/doc/apps/stdlib/io#fwrite/1
pub fn printf(format: String, args: a) {
  case sprintf(format, args) {
    Ok(result) -> io.print(result)
    Error(err) -> io.println_error("ERROR: " <> err.message)
  }
}
