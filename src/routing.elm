module Routing exposing (..)

import String
import Navigation
import UrlParser exposing (..)


type Route
    = Index
    | SignUp
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ format Index (s "")
        , format Index (s "/")
        , format SignUp (s "sign-up")
        ]


hashParser : Navigation.Location -> Result String Route
hashParser location =
    location.hash
        |> String.dropLeft 1
        |> parse identity matchers


parser : Navigation.Parser (Result String Route)
parser =
    Navigation.makeParser hashParser


routeFromResult : Result String Route -> Route
routeFromResult result =
    case result of
        Ok route ->
            route

        Err string ->
            NotFoundRoute