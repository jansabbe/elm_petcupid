module Maps exposing (..)

import Views exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Html.Events exposing (..)
import String exposing (..)
import Json.Decode


fullProfile =
    div [ class "clearfix" ]
        [ div [ class "pull-left dialog-picture" ]
            [ img [ class "small-profile-picture", src "assets/dog3.jpg" ] []
            ]
        , h3 [] [ text "Bobby" ]
        , p [] [ text "Bobby loves to fetch balls and chase rabbits. Great with kids." ]
        ]


interactiveMap =
    div [ class "map" ]
        [ p [] [ em [] [ text "Drag and drop to select the park where you want to play with Bobby" ] ]
        , div [ class "map-container", id "mapContainer" ] []
        ]


buttons =
    div [ class "clearfix" ]
        [ button [ type' "button", class "btn" ] [ text "Cancel" ]
        , button [ type' "button", class "btn btn-primary pull-right" ] [ text "Let's play!" ]
        ]


main =
    div []
        [ petcupidHeader
        , div [ class "container-fluid" ]
            [ div [ class "row" ]
                [ div [ class "col-md-8 col-md-offset-2" ]
                    [ div [ class "big-dialog" ]
                        [ fullProfile
                        , interactiveMap
                        , buttons
                        ]
                    ]
                ]
            , petcupidFooter
            ]
        ]
