port module Maps exposing (..)

import Views exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Html.Events exposing (..)
import String exposing (..)
import Json.Decode


port initialized : Coordinate -> Cmd msg


port dragged : (Coordinate -> msg) -> Sub msg


type alias MapModel =
    { coordinate : Coordinate }


type alias Coordinate =
    { longitude : Float, latitude : Float }


type Msg
    = MarkerDragged Coordinate


initialModel : MapModel
initialModel =
    { coordinate = (Coordinate 50.85 4.35) }


fullProfile =
    div [ class "clearfix" ]
        [ div [ class "pull-left dialog-picture" ]
            [ img [ class "small-profile-picture", src "assets/dog3.jpg" ] []
            ]
        , h3 [] [ text "Bobby" ]
        , p [] [ text "Bobby loves to fetch balls and chase rabbits. Great with kids." ]
        ]


interactiveMap : MapModel -> Html Msg
interactiveMap model =
    div [ class "map" ]
        [ p [] [ em [] [ text "Drag and drop to select the park where you want to play with Bobby" ] ]
        , p [] [ text ("Coordinate : " ++ (toString model.coordinate.latitude) ++ ", " ++ (toString model.coordinate.longitude)) ]
        , div [ class "map-container", id "mapContainer" ] []
        ]


buttons =
    div [ class "clearfix" ]
        [ button [ type' "button", class "btn" ] [ text "Cancel" ]
        , button [ type' "button", class "btn btn-primary pull-right" ] [ text "Let's play!" ]
        ]


view model =
    div []
        [ petcupidHeader
        , div [ class "container-fluid" ]
            [ div [ class "row" ]
                [ div [ class "col-md-8 col-md-offset-2" ]
                    [ div [ class "big-dialog" ]
                        [ fullProfile
                        , interactiveMap model
                        , buttons
                        ]
                    ]
                ]
            , petcupidFooter
            ]
        ]


init : ( MapModel, Cmd Msg )
init =
    ( initialModel, initialized initialModel.coordinate )


subscriptions : MapModel -> Sub Msg
subscriptions model =
    dragged MarkerDragged


update : Msg -> MapModel -> ( MapModel, Cmd Msg )
update msg model =
    case msg of
        MarkerDragged newCoordinate ->
            ( { model | coordinate = newCoordinate }, Cmd.none )


main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
