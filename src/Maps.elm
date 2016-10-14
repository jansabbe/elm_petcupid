port module Maps exposing (..)

import Views exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Html.Events exposing (..)
import String exposing (..)
import Json.Decode
import Task
import Http
import Json.Decode as Json


port initialized : Coordinate -> Cmd msg


port dragged : (Coordinate -> msg) -> Sub msg


main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( MapModel, Cmd Msg )
init =
    let
        initialModel =
            { coordinate = (Coordinate 50.84768133805717 4.727554321289063)
            , address = ""
            }

        initialCommandos =
            [ initialized initialModel.coordinate, lookup initialModel.coordinate ]
    in
        ( initialModel, Cmd.batch initialCommandos )


type Msg
    = MarkerDragged Coordinate
    | LookupFailed Http.Error
    | LookedUpCoordinates String


view : MapModel -> Html Msg
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


update : Msg -> MapModel -> ( MapModel, Cmd Msg )
update msg model =
    case msg of
        MarkerDragged newCoordinate ->
            ( { model | coordinate = newCoordinate }, lookup newCoordinate )

        LookupFailed error ->
            ( model, Cmd.none )

        LookedUpCoordinates address ->
            ( { model | address = address }, Cmd.none )


subscriptions : MapModel -> Sub Msg
subscriptions model =
    dragged MarkerDragged


type alias MapModel =
    { coordinate : Coordinate, address : String }


type alias Coordinate =
    { latitude : Float, longitude : Float }


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
        , p [] [ text model.address ]
        , div [ class "map-container", id "mapContainer" ] []
        ]


buttons =
    div [ class "clearfix" ]
        [ button [ type' "button", class "btn" ] [ text "Cancel" ]
        , button [ type' "button", class "btn btn-primary pull-right" ] [ text "Let's play!" ]
        ]


lookup : Coordinate -> Cmd Msg
lookup { latitude, longitude } =
    let
        url =
            "http://nominatim.openstreetmap.org/reverse?format=json&lat=" ++ (toString latitude) ++ "&lon=" ++ (toString longitude)
    in
        Task.perform LookupFailed LookedUpCoordinates (Http.get decodeOpenstreetmap url)


decodeOpenstreetmap : Json.Decoder String
decodeOpenstreetmap =
    Json.at [ "display_name" ] Json.string
