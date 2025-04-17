-module(gleam_format).
-export([erl_format/2]).

%% Since erlang treats gleam user defined types as tuples, if the user passes a single user defined variable without 
%% wrapping it in a tuple  or list, it will be treated as a list of that types variables.
erl_format(Format, Args) ->
    Arg_list = case Args of
        _ when is_tuple(Args) -> tuple_to_list(Args);
        _ when is_list(Args) -> Args;
        _ -> [Args]
    end,
    try
        Chars = io_lib:format(Format, Arg_list),
        {ok, unicode:characters_to_binary(Chars)}
    catch
        exit:badarg -> {error, "Make sure the arguments match the format string."};
        error:X -> {error, X}
    end.

