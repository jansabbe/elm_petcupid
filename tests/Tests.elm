module Tests exposing (..)

import Models exposing (..)
import Index.View exposing (..)
import Test exposing (..)
import Expect
import Fuzz
import String


all : Test
all =
    describe "Searching by text"
        [ fuzz Fuzz.string "can search by name" <|
            \name ->
                [ { id = 1, name = name, kind = Cat, img = "cat.jpg", profileText = "" } ]
                    |> filterPetsOnTextSearch name
                    |> List.length
                    |> Expect.equal 1
        , fuzz Fuzz.string "can search by name in case insensitive way" <|
            \name ->
                [ { id = 1, name = name, kind = Cat, img = "cat.jpg", profileText = "" } ]
                    |> filterPetsOnTextSearch (String.toLower name)
                    |> List.length
                    |> Expect.equal 1
        ]
