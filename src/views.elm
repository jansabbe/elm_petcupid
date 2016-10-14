module Views exposing (..)

import Html exposing (..)
import Models exposing (..)
import Routing exposing (..)

import SignUp.View exposing (signUpView)
import Index.View exposing (indexPage)
import NotFound.View exposing (notFoundView)

page : Model -> Html Msg
page model =
    case model.route of
        Index ->
            indexPage model

        SignUp ->
            signUpView model

        NotFoundRoute ->
            notFoundView

view : Model -> Html Msg
view model =
    div []
        [ page model ]

