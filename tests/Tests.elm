module Tests exposing (..)

import Petcupid exposing (..)
import Test exposing (..)
import Expect
import String
import Fuzz exposing (..)


princess =
    { id = 1
    , name = "Princess"
    , kind = Chicken
    , img = "assets/chicken1.jpg"
    , profileText = "Meet Princess Fluffybutt! She is one of the fluffiest chickens you will ever meet. Most often you'll find Princess cuddled up in the warmest spot she can find, and if that happens to be in your lap, well then that's fine for her too! Princess also enjoys nomming treats out of your hand, clucking softly under her breath, and following her three sisters around the yard. Get to know Princess today!"
    }


mrFuzz =
    { id = 2
    , name = "MrFuzz"
    , kind = Cat
    , img = "assets/cat1.jpg"
    , profileText = "MrFuzz loves belly rubs, and likes playing with pieces of string"
    }


all : Test
all =
    describe "A Test Suite"
        [ test "Can search by name" <|
            \() ->
                filterPets "Princess" [ princess, mrFuzz ]
                    |> Expect.equal [ princess ]
        , test "Can search by name case insensitive" <|
            \() ->
                filterPets "princess" [ princess, mrFuzz ]
                    |> Expect.equal [ princess ]
        ]
