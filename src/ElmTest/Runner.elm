module ElmTest.Runner exposing (Test(..))

{-| Declarations required by lobo. Generally only of interest when
extending lobo.

@docs Test

-}

import Test as ElmTest


{-| Hierarchical representation of Tests
-}
type Test
    = Batch (List Test)
    | Labeled String Test
    | Only Test
    | Skipped String Test
    | Test ElmTest.Test
    | Todo String
