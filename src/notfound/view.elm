module NotFound.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Index.View exposing (petcupidHeader, petcupidFooter)

notFoundView : Html msg
notFoundView =
    div [ ]
        [petcupidHeader,
        div [ style [("color", "white"), ("margin-top", "20px"), ("margin-bottom", "20px"),
                ("font-size", "40px"), ("text-align", "center"), ("font-weight", "bold")]][text "Page not found"],
        div [ style [("color", "white"), ("margin-top", "20px"), ("margin-bottom", "20px"),
        ("font-size", "40px"), ("text-align", "center")]][text "Sorry, you will not find any love here"],
        div [style [("text-align", "center"), ("padding-bottom", "50px")]] [ img [ src "assets/page-not-found.jpg" ] [] ],
        petcupidFooter]
