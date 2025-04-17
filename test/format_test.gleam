import gleam/format.{sprintf}
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

type TestClass {
  TestClass(name: String, num: Int)
}

pub fn simple_format_test() {
  sprintf("~c~c~c~c", [72, 101, 121, 33])
  |> should.equal(Ok("Hey!"))

  sprintf("Hello ~s", <<119, 111, 114, 108, 100, 33>>)
  |> should.equal(Ok("Hello world!"))

  sprintf("Hello ~s ~s", ["world!", "Extra!"])
  |> should.equal(Ok("Hello world! Extra!"))

  sprintf("1, 2, ~p", #(3))
  |> should.equal(Ok("1, 2, 3"))

  sprintf("1.0, 2.0, ~f", #(3.0))
  |> should.equal(Ok("1.0, 2.0, 3.000000"))

  sprintf("1, 2, ~p", #(4))
  |> should.equal(Ok("1, 2, 4"))

  sprintf("1, 2, ~.2f", #(3.0001))
  |> should.equal(Ok("1, 2, 3.00"))

  sprintf("1, 2, ~s", #("four"))
  |> should.equal(Ok("1, 2, four"))

  sprintf("1, 2, ~p", True)
  |> should.equal(Ok("1, 2, true"))

  sprintf("~w", #([1, 3]))
  |> should.equal(Ok("[1,3]"))

  sprintf("~w", [[1, 3]])
  |> should.equal(Ok("[1,3]"))

  sprintf("~b", #(1))
  |> should.equal(Ok("1"))

  sprintf("~.16B", [31])
  |> should.equal(Ok("1F"))

  sprintf("~.2B", [4])
  |> should.equal(Ok("100"))

  sprintf("~8.2.0B", [4])
  |> should.equal(Ok("00000100"))
}

pub fn format_user_defined_types_test() {
  let t = TestClass("Test", 69)
  sprintf("Hello ~p", [t])
  |> should.equal(Ok("Hello {test_class,<<\"Test\">>,69}"))

  sprintf("Hello ~s ~s ~b", t)
  |> should.equal(Ok("Hello test_class Test 69"))

  let t = [TestClass("Test", 69), TestClass("Test2", 70)]
  sprintf("Hello ~p", #(t))
  |> should.equal(Ok(
    "Hello [{test_class,<<\"Test\">>,69},{test_class,<<\"Test2\">>,70}]",
  ))
}

pub fn tuple_test() {
  sprintf("~p", #("Test"))
  |> should.equal(Ok("<<\"Test\">>"))

  sprintf("~p", #(#(1, 2)))
  |> should.equal(Ok("{1,2}"))

  sprintf("~p", #(#(1, 2, #(1, 2))))
  |> should.equal(Ok("{1,2,{1,2}}"))

  sprintf("~p", #(#(1, 2, #(1, 2), #(3, 4))))
  |> should.equal(Ok("{1,2,{1,2},{3,4}}"))

  sprintf("~b ~b ~p", #(1, 2, #(#(1, 2), #(3, 4), #(5, 6))))
  |> should.equal(Ok("1 2 {{1,2},{3,4},{5,6}}"))

  sprintf("~p ~p", #(#(1, 2), #(1, 2, 3)))
  |> should.equal(Ok("{1,2} {1,2,3}"))

  sprintf("~p ~p", #(#(1, 2), [#(1, 2), #(3, 4)]))
  |> should.equal(Ok("{1,2} [{1,2},{3,4}]"))
}

pub fn error_test() {
  sprintf("~s", TestClass("a", 1))
  |> should.be_error()

  sprintf("This should ~s", #(1, 2))
  |> should.be_error()

  sprintf("This should ~a", #(1, 2))
  |> should.be_error()
}

pub fn complex_format_test() {
  sprintf("~s ~s ~i ~p ~c ~n", #("abc def", "abc def", #(12, 1), #(12, 1), 65))
  |> should.equal(Ok("abc def abc def  {12,1} A \n"))

  sprintf("|~10.5c|~-10.5c|~5c|~n", [97, 98, 99])
  |> should.equal(Ok("|     aaaaa|bbbbb     |ccccc|\n"))
}
