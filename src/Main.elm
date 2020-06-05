module Main exposing (main)

import Browser
import Html exposing (Html, button, code, div, pre, text)
import Html.Events exposing (onClick)
import Random exposing ( Generator)

type alias Model =
      Expr


type Expr
    = Integer Int
    | Add Expr Expr
    | Multiply Expr Expr



type Msg
    = NewExpr Expr
    | GetNewExpr


main : Program () Model Msg
main =
    Browser.element
      { init = always ( Integer 0, Cmd.none )
      , view = view
      , update = update
      , subscriptions = always Sub.none
      }


view : Expr -> Html Msg
view expr =
    div []
        [button [onClick GetNewExpr ][ text "New Expression" ]
        , code []
            [ pre []  [ text <| Debug.toString expr ]
            ]
        ]


update : Msg -> Model -> (Model, Cmd Msg )
update msg model =
    case msg of
        GetNewExpr ->
            ( model, Random.generate NewExpr expression )

        NewExpr expr ->
            ( expr, Cmd.none )






expression : Generator Expr
expression =
    Random.weighted (50, integer ) [  (25, addition ), (25, multiplication ) ]
        |> Random.andThen identity


integer : Generator Expr
integer =
    Random.int 1 100
        |> Random.map Integer


addition : Generator Expr
addition =
    Random.map2 Add
        (Random.lazy (\_ -> expression))
        (Random.lazy (\_ -> expression))


multiplication : Generator Expr
multiplication =
      Random.map2 Multiply
          (Random.lazy ( \_ -> expression ))
          (Random.lazy (\_ -> expression ))
