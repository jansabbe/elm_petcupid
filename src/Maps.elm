module Maps exposing (..)

import Petcupid exposing (..)
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


googleMap =
    div [ class "map" ]
        [ p [] [ em [] [ text "Drag and drop to select the park where you want to play with Bobby" ] ]
        , iframe
            [ src "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d80598.85688639637!2d4.375389949999999!3d50.85497504999999!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x47c3a4ed73c76867%3A0xc18b3a66787302a7!2sBrussel!5e0!3m2!1snl!2sbe!4v1398846054531"
            , width 600
            , height 350
            , style [ ( "border", "0" ) ]
            ]
            []
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
                        , googleMap
                        , buttons
                        ]
                    ]
                ]
            , (petcupidFooter model)
            ]
        ]
