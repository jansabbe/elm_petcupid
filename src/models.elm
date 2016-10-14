module Models exposing (..)

type Kind
    = Cat
    | Dog
    | Chicken


type alias Pet =
    { id : Int
    , kind : Kind
    , name : String
    , img : String
    , profileText : String
    }


type alias Model =
    { pets : List Pet
    , selectedPet : Maybe Pet
    , search :
        { textSearch : String
        , kindFilter : KindFilter
        }
    }


type KindFilter
    = Any
    | Specific Kind


type Msg
    = TextSearch String
    | Filter KindFilter
    | Select Pet


model : Model
model =
    { pets =
        [ { id = 1
          , name = "Princess"
          , kind = Chicken
          , img = "assets/chicken1.jpg"
          , profileText = "Meet Princess Fluffybutt! She is one of the fluffiest chickens you will ever meet. Most often you'll find Princess cuddled up in the warmest spot she can find, and if that happens to be in your lap, well then that's fine for her too! Princess also enjoys nomming treats out of your hand, clucking softly under her breath, and following her three sisters around the yard. Get to know Princess today!"
          }
        , { id = 2
          , name = "MrFuzz"
          , kind = Cat
          , img = "assets/cat1.jpg"
          , profileText = "MrFuzz loves belly rubs, and likes playing with pieces of string"
          }
        , { id = 3
          , name = "Burt"
          , kind = Dog
          , img = "assets/dog1.jpg"
          , profileText = "Burt looks cute, but is in reality a though guy. Secretly wants to work for the FBI"
          }
        , { id = 4
          , name = "MissPoes"
          , kind = Cat
          , img = "assets/cat2.jpg"
          , profileText = "MissPoes is a classy lady who appreciates gentle pets"
          }
        , { id = 5
          , name = "Lady"
          , kind = Dog
          , img = "assets/dog2.jpg"
          , profileText = "Lady isn't always very lady-like. She loves rolling in the mud and barking at naughty squirrels"
          }
        , { id = 6
          , name = "Grumpy"
          , kind = Cat
          , img = "assets/cat3.jpg"
          , profileText = "Grumpy basically hates everything, especially dogs. He does looove lasagne though"
          }
        , { id = 7
          , name = "Bobby"
          , kind = Dog
          , img = "assets/dog3.jpg"
          , profileText = "Bobby loves to fetch balls and chase rabbits. Great with kids."
          }
        ]
    , selectedPet = Nothing
    , search =
        { textSearch = ""
        , kindFilter = Any
        }
    }
