module Petcupid exposing (..)

import Html.App as App

import Models exposing (model)
import Views exposing (view)
import Update exposing (update)

main =
    App.beginnerProgram
        { model = model
        , view = view
        , update = update
        }
