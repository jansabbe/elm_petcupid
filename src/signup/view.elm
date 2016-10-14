module SignUp.View exposing (..)

import Html exposing (..)
import Models exposing (..)
import Html.Attributes exposing (..)

signUpView : Model -> Html Msg
signUpView model =
  div []
    [ input [ type' "text", placeholder "Name" ] []
    , input [ type' "text", placeholder "Nickname" ] []
    , input [ type' "text", placeholder "Favorite qoute" ] []
    ]