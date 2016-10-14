module Petcupid exposing (..)

import Html.App

import Navigation
import Models exposing (Model, Msg, model, initialModel)
import Views exposing (view)
import Update exposing (update)
import Routing exposing (Route)

init : Result String Route -> ( Model, Cmd Msg )
init result =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( initialModel currentRoute, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

urlUpdate : Result String Route -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( { model | route = currentRoute }, Cmd.none )

main =
    Navigation.program Routing.parser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }