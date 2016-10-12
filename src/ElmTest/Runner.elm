module ElmTest.Runner exposing (Test(Test, Labeled, Batch, Skipped, Focus))

{-| Declarations required by lobo. Generally only of interest when
extending lobo.

@docs Test

-}

import Test as ElmTest


{-| Hierarchical representation of Tests
-}
type Test
    = Test ElmTest.Test
    | Labeled String Test
    | Batch (List Test)
    | Skipped String Test
    | Focus Test
