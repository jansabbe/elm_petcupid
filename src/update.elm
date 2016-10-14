module Update exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Html.Events exposing (..)
import String exposing (..)
import Json.Decode
import Navigation

import Models exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update msg ({ search } as model) =
    case msg of
        TextSearch newSearchText ->
            ({ model | search = { search | textSearch = newSearchText } }, Cmd.none)

        Filter newFilter ->
            ({ model | search = { search | kindFilter = newFilter } }, Cmd.none)

        Select pet ->
            ({ model | selectedPet = Just pet }, Cmd.none)

        GoToSignUp -> ( model, Navigation.newUrl "#sign-up" )