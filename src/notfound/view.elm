module NotFound.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

notFoundView : Html msg
notFoundView =
    div [ style [("background-color", "powderblue")] ]
        [ text "Not found"
        ]
