module NewPets exposing (..)

import Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class, value, href)

view : Html Msg
view model =
    div []
        [ p [] [ text "Thank you for signing up, please come again!" ]
        ]


