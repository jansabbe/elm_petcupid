module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Events exposing (..)


main =
    h1 [] [ text "Hello World!" ]


type alias Model =
    { counter : Int }


model : Model
model =
    { counter = 0
    }


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text (Basics.toString model.counter) ]
        , div [] [ button [ onClick Increment ] [ text "+" ] ]
        , div [] [ button [ onClick Decrement ] [ text "-" ] ]
        ]


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | counter = model.counter + 1 }

        Decrement ->
            { model | counter = model.counter - 1 }
