module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Html.Events exposing (..)


petcupidHeader =
    header [ class "colored-background header" ]
        [ img [ class "logo", src "assets/heart.png" ] []
        , text "PetCupid"
        ]


petcupidFooter =
    footer [ class "hugs-bottom colored-background footer" ]
        [ p [] [ text "© 2015 Cegeka" ]
        ]


gallery =
    div [ class "gallery" ]
        [ galleryPet { imageUrl = "assets/chicken1.jpg", name = "Princess" }
        , galleryPet { imageUrl = "assets/cat1.jpg", name = "MrFuzz" }
        , galleryPet { imageUrl = "assets/dog1.jpg", name = "Burt" }
        , galleryPet { imageUrl = "assets/cat2.jpg", name = "MissPoes" }
        , galleryPet { imageUrl = "assets/dog2.jpg", name = "Lady" }
        , galleryPet { imageUrl = "assets/cat3.jpg", name = "Grumpy" }
        , galleryPet { imageUrl = "assets/dog3.jpg", name = "Bobby" }
        ]


galleryPet pet =
    div [ class "gallery-pet" ]
        [ img [ class "profile-picture", src pet.imageUrl ] []
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


searchForm =
    tinyDialog "Find your pet" [ text "bla" ]


selectedProfile =
    tinyDialog "Bobby"
        [ p [] [ text "Bobby loves to fetch balls and chase rabbits. Great with kids." ]
        , div [ class "dialog-centered" ]
            [ button [ type' "button", class "btn btn-primary btn-lg dialog-centered" ] [ text "Setup date" ]
            ]
        ]


detail =
    div [ class "gallery-detail" ]
        [ detailExplanation, searchForm, selectedProfile ]


main =
    div []
        [ petcupidHeader
        , div [ class "container-fluid" ]
            [ div [ class "row" ]
                [ div [ class "col-md-9" ] [ gallery ]
                , div [ class "col-md-3" ] [ detail ]
                ]
            , petcupidFooter
            ]
        ]
