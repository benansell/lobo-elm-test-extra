module ElmTest.Extra
    exposing
        ( Test
        , describe
        , fuzz
        , fuzz2
        , fuzz3
        , fuzz4
        , fuzz5
        , fuzzWith
        , only
        , skip
        , test
        , todo
        )

{-| Additions to [elm-test](http://package.elm-lang.org/packages/elm-community/elm-test/latest)
for use with the [lobo](https://www.npmjs.com/package/lobo) test runner.

    skippedTest : Test
    skippedTest =
        skip "ignore test" <|
            test "skippedTest" <|
                \() ->
                    Expect.fail "Never runs"


## Migration from elm-test
To use this package you will need to use lobo with the "elm-test-extra"
framework, and replace:

    import Test

with

    import ElmTest.Extra

It is recommended that you give each describe / test a meaningful description. However, lobo
does not enforce any uniqueness constraints on these descriptions.

Further information on using lobo can be found [here](https://www.npmjs.com/package/lobo)

The following elm-test functions are not available in elm-test-extra:
* concat -> instead use `describe`

## Extra

@docs skip

## elm-test

lobo compatible declarations of the elm-test Test API. In the first instance
please see the original [elm-test documentation](http://package.elm-lang.org/packages/elm-community/elm-test/latest)

@docs Test, only, test, todo

### Organizing Tests

@docs describe

### Fuzz Testing

@docs fuzz, fuzz2, fuzz3, fuzz4, fuzz5, fuzzWith

-}

import Expect exposing (Expectation)
import Fuzz as Fuzz exposing (Fuzzer)
import ElmTest.Runner as Runner exposing (Test(Test, Labeled, Batch, Skipped, Only, Todo))
import Test as ElmTest exposing (FuzzOptions, fuzz, fuzz2, fuzz3, fuzz4, fuzz5, fuzzWith, test)


{-| Restrict the running of tests to `only` those that have only:

    onlyTest : Test
    onlyTest =
        only <|
            test "Example passing test" <|
                \() ->
                    Expect.pass

This will cause the lobo runner to ignore all other tests that don't have only
applied. Only cannot be used to force a skipped test to run.
For further help see [elm-test documentation](http://package.elm-lang.org/packages/elm-community/elm-test/latest)
-}
only : Test -> Test
only test =
    Only test


{-| Prevent the running of tests with a reason for them to be skipped.

    skippedTest : Test
    skippedTest =
        skip "ignore test" <|
            test "skippedTest" <|
                \() ->
                    Expect.fail "Never runs"

This will cause the lobo runner to skip this test.
For further help see [elm-test documentation](http://package.elm-lang.org/packages/elm-community/elm-test/latest)

-}
skip : String -> Test -> Test
skip reason test =
    Skipped reason test


{-| A temporary placeholder for a test that always fails.
For further help see the original [elm-test documentation](http://package.elm-lang.org/packages/elm-community/elm-test/latest)
-}
todo : String -> Test
todo description =
    Todo description


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
