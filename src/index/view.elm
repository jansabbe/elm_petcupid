module Index.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Html.Events exposing (..)
import String exposing (..)
import Json.Decode
import Models exposing (..)

isPetSelected model pet =
    case model.selectedPet of
        Nothing ->
            False

        Just selectedPet ->
            selectedPet.id == pet.id


filterPetsOnTextSearch : String -> List Pet -> List Pet
filterPetsOnTextSearch textSearch pets =
    let
        petFilter =
            \pet -> contains (textSearch |> toLower) (pet.profileText ++ pet.name |> toLower)
    in
        List.filter petFilter pets


filterPetsOnKind : KindFilter -> List Pet -> List Pet
filterPetsOnKind kindSearch pets =
    let
        petFilter =
            \pet -> Specific pet.kind == kindSearch || Any == kindSearch
    in
        List.filter petFilter pets


targetValueKindDecoder : Json.Decode.Decoder KindFilter
targetValueKindDecoder =
    targetValue
        `Json.Decode.andThen`
            \val ->
                case val of
                    "Any" ->
                        Json.Decode.succeed Any

                    "Cat" ->
                        Json.Decode.succeed (Specific Cat)

                    "Dog" ->
                        Json.Decode.succeed (Specific Dog)

                    "Chicken" ->
                        Json.Decode.succeed (Specific Chicken)

                    _ ->
                        Json.Decode.fail ("Invalid Kind: " ++ val)


mapKindFilterToString : KindFilter -> String
mapKindFilterToString kindFilter =
    case kindFilter of
        Any ->
            "Any"

        Specific Cat ->
            "Cat"

        Specific Dog ->
            "Dog"

        Specific Chicken ->
            "Chicken"


petcupidHeader =
    header [ class "colored-background header" ]
        [ img [ class "logo", src "assets/heart.png" ] []
        , text "PetCupid"
        ]


petcupidFooter =
    footer [ class "hugs-bottom colored-background footer" ]
        [ p [] [ text "© 2015 Cegeka" ] ]


gallery : Model -> Html Msg
gallery model =
    div [ class "gallery" ] (List.map (galleryPet model) (filterPetsOnKind model.search.kindFilter (filterPetsOnTextSearch model.search.textSearch model.pets)))


galleryPet : Model -> Pet -> Html Msg
galleryPet model pet =
    div [ classList [ ( "gallery-pet", True ), ( "active", isPetSelected model pet ) ], onClick (Select pet) ]
        [ img [ class "profile-picture", src pet.img ] []
        , div [ class "overlay" ]
            [ div [ class "overlay-text" ] [ text pet.name ] ]
        ]


tinyDialog title content =
    section [ class "tiny-dialog" ]
        ((h3 [] [ text title ]) :: content)


detailExplanation =
    tinyDialog "Pick & Play"
        [ p [] [ text "Like to play and cudle with pets but can't keep one at home?" ]
        , ol [ class "big-numbers" ]
            [ li [] [ text "Pick a cute pet" ]
            , li [] [ text "Setup a date" ]
            , li [] [ text "Go play!" ]
            ]
        ]


viewOption : KindFilter -> Html Msg
viewOption kind =
    option
        [ value <| mapKindFilterToString kind ]
        [ text <| mapKindFilterToString kind ]


searchForm =
    tinyDialog "Find your pet"
        [ Html.form []
            [ div [ class "form-group" ]
                [ input [ class "form-control", placeholder "Search", onInput TextSearch ] []
                ]
            , div [ class "form-group" ]
                [ select [ class "form-control", on "change" (Json.Decode.map Filter targetValueKindDecoder) ]
                    [ viewOption Any
                    , viewOption (Specific Cat)
                    , viewOption (Specific Dog)
                    , viewOption (Specific Chicken)
                    ]
                ]
            ]
        ]


selectedProfile : Pet -> Html a
selectedProfile pet =
    tinyDialog pet.name
        [ p [] [ text pet.profileText ]
        , div [ class "dialog-centered" ]
            [ button [ type' "button", class "btn btn-primary btn-lg dialog-centered" ] [ text "Setup date" ]
            ]
        ]


signUpPet : Html Msg
signUpPet =
    tinyDialog "Sign up your Pet!"
        [ p [] [ text "TODO be original" ]
        , div [ class "dialog-centered" ]
            [ button [ type' "button", class "btn btn-primary btn-lg dialog-centered" ] [ text "Sign up pet" ]
            ]
        ]


detail : Maybe Pet -> Html Msg
detail selectedPet =
    div [ class "gallery-detail" ]
        (case selectedPet of
            Nothing ->
                [ signUpPet, detailExplanation, searchForm ]

            Just pet ->
                [ signUpPet, detailExplanation, searchForm, selectedProfile pet ]
        )


indexPage : Model -> Html Msg
indexPage model =
    div []
        [ petcupidHeader
        , div [ class "container-fluid" ]
            [ div [ class "row" ]
                [ div [ class "col-md-9" ] [ gallery model ]
                , div [ class "col-md-3" ] [ detail model.selectedPet ]
                ]
            , petcupidFooter
            ]
        ]
