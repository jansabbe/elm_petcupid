module Update exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Html.Events exposing (..)
import String exposing (..)
import Json.Decode

import Models exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update msg ({ search } as model) =
    (case msg of
        TextSearch newSearchText ->
            { model | search = { search | textSearch = newSearchText } }

        Filter newFilter ->
            { model | search = { search | kindFilter = newFilter } }

        Select pet ->
            { model | selectedPet = Just pet }, Cmd.none)
