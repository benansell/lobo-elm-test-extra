module ElmTest.Extra
    exposing
        ( Test
        , describe
        , focus
        , fuzz
        , fuzz2
        , fuzz3
        , fuzz4
        , fuzz5
        , fuzzWith
        , skip
        , test
        )

{-| Additions to [elm-test](http://package.elm-lang.org/packages/elm-community/elm-test/latest)
for use with the [lobo](https://www.npmjs.com/package/lobo) test runner.

    skippedTest : Test
    skippedTest =
        skip "ignore test" <|
            test "skippedTest" <|
                \() ->
                    Expect.fail "Never runs"


    focusTest : Test
    focusTest =
        focus <|
            test "Example passing test" <|
                \() ->
                    Expect.pass

## Migration from elm-test
To use this package you will need to use lobo with the "elm-test-extra"
framework, and replace:

    import Test

with

    import ElmTest.Extra

Further information on using lobo can be found [here](https://www.npmjs.com/package/lobo)

The following elm-test functions are not available in elm-test-extra:
* concat -> instead use `describe`
* filter -> instead use `skip`

## Extra

@docs focus, skip

## elm-test

lobo compatible declarations of the elm-test Test API. In the first instance
please see the original [elm-test documentation](http://package.elm-lang.org/packages/elm-community/elm-test/latest)

@docs Test, test

### Organizing Tests

@docs describe

### Fuzz Testing

@docs fuzz, fuzz2, fuzz3, fuzz4, fuzz5, fuzzWith

-}

import Expect exposing (Expectation)
import Fuzz as Fuzz exposing (Fuzzer)
import ElmTest.Runner as Runner exposing (Test(Test, Labeled, Batch, Skipped, Focus))
import Test as ElmTest
    exposing
        ( FuzzOptions
        , concat
        , fuzz
        , fuzz2
        , fuzz3
        , fuzz4
        , fuzz5
        , fuzzWith
        , test
        )


{-| Restrict the running of tests to only those that have `focus`:
unfocused tests.

    focusTest : Test
    focusTest =
        focus <|
            test "Example passing test" <|
                \() ->
                    Expect.pass

This will cause the lobo runner to ignore all other tests that don't have focus
applied. focus can be applied to the following:
* test
* describe
* fuzz, fuzzWith, fuzz2, fuzz3, fuzz4, fuzz5

Focus cannot be used to force a skipped test to run.
-}
focus : Test -> Test
focus test =
    Focus test


{-| Prevent the running of tests with a reason for them to be skipped.

    skippedTest : Test
    skippedTest =
        skip "ignore test" <|
            test "skippedTest" <|
                \() ->
                    Expect.fail "Never runs"

This will cause the lobo runner to skip this test. skip can be applied to the
following:
* test
* describe, concat
* fuzz, fuzzWith, fuzz2, fuzz3, fuzz4, fuzz5

-}
skip : String -> Test -> Test
skip reason test =
    Skipped reason test


{-| A test which has yet to be evaluated.
For further help see the original [elm-test documentation](http://package.elm-lang.org/packages/elm-community/elm-test/latest)
-}
type alias Test =
    Runner.Test


{-| Group a set of tests with a description.
For further help see the original [elm-test documentation](http://package.elm-lang.org/packages/elm-community/elm-test/latest)
-}
describe : String -> List Test -> Test
describe desc =
    Batch >> Labeled desc


{-| A test that evaluates an expectation.
For further help see the original [elm-test documentation](http://package.elm-lang.org/packages/elm-community/elm-test/latest)
-}
test : String -> (() -> Expectation) -> Test
test desc thunk =
    ElmTest.test desc thunk |> Test


{-| Run a test with random input provided by the fuzzer.
For further help see the original [elm-test documentation](http://package.elm-lang.org/packages/elm-community/elm-test/latest)
-}
fuzz : Fuzz.Fuzzer a -> String -> (a -> Expectation) -> Test
fuzz fuzzer desc getExpectations =
    ElmTest.fuzz fuzzer desc getExpectations |> Test


{-| Run a test with random input provide by a fuzzer using the supplied options.
For further help see the original [elm-test documentation](http://package.elm-lang.org/packages/elm-community/elm-test/latest)
-}
fuzzWith : ElmTest.FuzzOptions -> Fuzzer a -> String -> (a -> Expectation) -> Test
fuzzWith options fuzzer desc getExpectations =
    ElmTest.fuzzWith options fuzzer desc getExpectations |> Test


{-| Run a test with 2 random inputs provided by the fuzzers.
For further help see the original [elm-test documentation](http://package.elm-lang.org/packages/elm-community/elm-test/latest)
-}
fuzz2 :
    Fuzzer a
    -> Fuzzer b
    -> String
    -> (a -> b -> Expectation)
    -> Test
fuzz2 fuzzA fuzzB desc getExpectations =
    ElmTest.fuzz2 fuzzA fuzzB desc getExpectations |> Test


{-| Run a test with 3 random inputs provided by the fuzzers.
For further help see the original [elm-test documentation](http://package.elm-lang.org/packages/elm-community/elm-test/latest)
-}
fuzz3 :
    Fuzzer a
    -> Fuzzer b
    -> Fuzzer c
    -> String
    -> (a -> b -> c -> Expectation)
    -> Test
fuzz3 fuzzA fuzzB fuzzC desc getExpectations =
    ElmTest.fuzz3 fuzzA fuzzB fuzzC desc getExpectations |> Test


{-| Run a test with 4 random inputs provided by the fuzzers.
For further help see the original [elm-test documentation](http://package.elm-lang.org/packages/elm-community/elm-test/latest)
-}
fuzz4 :
    Fuzzer a
    -> Fuzzer b
    -> Fuzzer c
    -> Fuzzer d
    -> String
    -> (a -> b -> c -> d -> Expectation)
    -> Test
fuzz4 fuzzA fuzzB fuzzC fuzzD desc getExpectations =
    ElmTest.fuzz4 fuzzA fuzzB fuzzC fuzzD desc getExpectations |> Test


{-| Run a test with 5 random inputs provided by the fuzzers.
For further help see the original [elm-test documentation](http://package.elm-lang.org/packages/elm-community/elm-test/latest)
-}
fuzz5 :
    Fuzzer a
    -> Fuzzer b
    -> Fuzzer c
    -> Fuzzer d
    -> Fuzzer e
    -> String
    -> (a -> b -> c -> d -> e -> Expectation)
    -> Test
fuzz5 fuzzA fuzzB fuzzC fuzzD fuzzE desc getExpectations =
    ElmTest.fuzz5 fuzzA fuzzB fuzzC fuzzD fuzzE desc getExpectations |> Test
