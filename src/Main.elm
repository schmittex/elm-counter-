module Main exposing (main)

import Browser
import Html exposing (Html, text, button, div, textarea)
import Html.Attributes as Attributes exposing (class)
import Html.Events as Events


type alias Model =
      { text : String }


autoTextarea { text, onInput, placeholder } =
    div [ Attributes.class "autoexpand" ]
        [ textarea [Events.onInput onInput,Attributes.placeholder placeholder ]  [Html.text text]
        , div []  [Html.text (text ++ "_")]
        ]


initialModel : Model
initialModel =
        { text = "" }


type Msg
    = SetText String


update : Msg -> Model -> Model
update msg model =
      case msg of
        SetText text ->
            { model | text=text }


view : Model -> Html Msg
view  model =
    div []
    [autoTextarea { text = model.text, onInput = SetText, placeholder = "write something"}
    ]


main : Program () Model Msg
main =
    Browser.sandbox
      { init = initialModel
      , view = view
      , update = update
      }
