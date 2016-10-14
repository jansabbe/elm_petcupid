module Petcupid exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Html.Events exposing (..)
import String exposing (..)


type Kind
    = Cat
    | Dog
    | Chicken


type alias Pet =
    { id : Int
    , kind : Kind
    , name : String
    , img : String
    , profileText : String
    }


type alias Model =
    { pets : List Pet
    , selectedPet : Maybe Pet
    , search :
        { textSearch : String
        , kindFilter : KindFilter
        }
    }


type KindFilter
    = Any
    | Specific Kind


type Msg
    = TextSearch String
    | Filter KindFilter
    | Select Pet


model : Model
model =
    { pets =
        [ { id = 1
          , name = "Princess"
          , kind = Chicken
          , img = "assets/chicken1.jpg"
          , profileText = "Meet Princess Fluffybutt! She is one of the fluffiest chickens you will ever meet. Most often you'll find Princess cuddled up in the warmest spot she can find, and if that happens to be in your lap, well then that's fine for her too! Princess also enjoys nomming treats out of your hand, clucking softly under her breath, and following her three sisters around the yard. Get to know Princess today!"
          }
        , { id = 2
          , name = "MrFuzz"
          , kind = Cat
          , img = "assets/cat1.jpg"
          , profileText = "MrFuzz loves belly rubs, and likes playing with pieces of string"
          }
        , { id = 3
          , name = "Burt"
          , kind = Dog
          , img = "assets/dog1.jpg"
          , profileText = "Burt looks cute, but is in reality a though guy. Secretly wants to work for the FBI"
          }
        , { id = 4
          , name = "MissPoes"
          , kind = Cat
          , img = "assets/cat2.jpg"
          , profileText = "MissPoes is a classy lady who appreciates gentle pets"
          }
        , { id = 5
          , name = "Lady"
          , kind = Dog
          , img = "assets/dog2.jpg"
          , profileText = "Lady isn't always very lady-like. She loves rolling in the mud and barking at naughty squirrels"
          }
        , { id = 6
          , name = "Grumpy"
          , kind = Cat
          , img = "assets/cat3.jpg"
          , profileText = "Grumpy basically hates everything, especially dogs. He does looove lasagne though"
          }
        , { id = 7
          , name = "Bobby"
          , kind = Dog
          , img = "assets/dog3.jpg"
          , profileText = "Bobby loves to fetch balls and chase rabbits. Great with kids."
          }
        ]
    , selectedPet = Nothing
    , search =
        { textSearch = ""
        , kindFilter = Any
        }
    }


isPetSelected model pet =
    case model.selectedPet of
        Nothing ->
            False

        Just selectedPet ->
            selectedPet.id == pet.id


filterPets : String -> List Pet -> List Pet
filterPets textSearch pets =
    let
        petFilter =
            \pet -> contains (textSearch |> toLower) (pet.profileText ++ pet.name |> toLower)
    in
        List.filter petFilter pets


update : Msg -> Model -> Model
update msg ({ search } as model) =
    case msg of
        TextSearch newSearchText ->
            { model | search = { search | textSearch = newSearchText } }

        Filter newFilter ->
            { model | search = { search | kindFilter = newFilter } }

        Select pet ->
            { model | selectedPet = Just pet }


petcupidHeader =
    header [ class "colored-background header" ]
        [ img [ class "logo", src "assets/heart.png" ] []
        , text "PetCupid"
        ]


petcupidFooter model =
    footer [ class "hugs-bottom colored-background footer" ]
        [ p [] [ text "© 2015 Cegeka" ] ]


gallery : Model -> Html Msg
gallery model =
    div [ class "gallery" ] (List.map (galleryPet model) (filterPets model.search.textSearch model.pets))


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


searchForm =
    tinyDialog "Find your pet"
        [ Html.form []
            [ div [ class "form-group" ]
                [ input [ class "form-control", placeholder "Search", onInput TextSearch ] []
                ]
            , div [ class "form-group" ]
                [ select [ class "form-control" ]
                    [ option [ value "" ] [ text "All" ]
                    , option [ value "cat" ] [ text "Cat" ]
                    , option [ value "dog" ] [ text "Dog" ]
                    , option [ value "chicken" ] [ text "Chicken" ]
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


detail : Maybe Pet -> Html Msg
detail selectedPet =
    div [ class "gallery-detail" ]
        (case selectedPet of
            Nothing ->
                [ detailExplanation, searchForm ]

            Just pet ->
                [ detailExplanation, searchForm, selectedProfile pet ]
        )


view : Model -> Html Msg
view model =
    div []
        [ petcupidHeader
        , div [ class "container-fluid" ]
            [ div [ class "row" ]
                [ div [ class "col-md-9" ] [ gallery model ]
                , div [ class "col-md-3" ] [ detail model.selectedPet ]
                ]
            , (petcupidFooter model)
            ]
        ]


main =
    App.beginnerProgram
        { model = model
        , view = view
        , update = update
        }
