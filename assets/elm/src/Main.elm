module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--


import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Json.Decode as Decode exposing (Decoder)


-- MAIN

main : Program Decode.Value Model Msg
main =
  Browser.element
    { init = init
    , view = view 
    , update = update
    , subscriptions = subscriptions
    }


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none


-- MODEL


type alias Model = 
  { balls : List Ball
  , decodeMessage: String
  }

-- JSON is just an array, whereas our model has a record at top level
fromJson : Decode.Value -> Result Decode.Error (List Ball)
fromJson =
  Decode.decodeValue (Decode.list ballDecoder)

init : Decode.Value -> ( Model, Cmd Msg)
init json = 
  case fromJson json of
    Ok balls ->
      ({ balls = balls, decodeMessage = "Successful Decode" }, Cmd.none)
    
    Err reason ->
      ({
        balls =
          [ Ball 1 Small Red
          , Ball 2 Medium Green
          , Ball 3 Large Blue
          , Ball 4 (UnknownSize "Kinda Small") (UnknownColor "Reddish")
          ]
       , decodeMessage = Decode.errorToString reason
      }
      , Cmd.none
      )

type alias Ball = 
  { id : Int
  , size : BallSize
  , color : BallColor
  }

ballDecoder : Decoder Ball
ballDecoder =
  Decode.map3
    Ball
    (Decode.field "id" Decode.int)
    (Decode.field "size" (Decode.andThen ballSizeFromString Decode.string))
    (Decode.field "color" (Decode.andThen ballColorFromString Decode.string))

type BallSize
  = Small
  | Medium
  | Large
  | UnknownSize String
  
ballSizeFromString : String -> Decoder BallSize
ballSizeFromString string =
  case string of
    "small" ->
      Decode.succeed Small
    "medium" ->
      Decode.succeed Medium
    "large" ->
      Decode.succeed Large
    _ ->
      Decode.succeed (UnknownSize string)

type BallColor
  = Red
  | Green
  | Blue
  | UnknownColor String

ballColorFromString : String -> Decoder BallColor
ballColorFromString string =
  case string of
    "red" ->
      Decode.succeed Red
    "green" ->
      Decode.succeed Green
    "blue" ->
      Decode.succeed Blue
    _ ->
      Decode.succeed (UnknownColor string)


-- UPDATE


type Msg
  = ChangeColor
  | AddBall

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    AddBall ->
      ( model, Cmd.none )
        -- ( { model | balls  = (Medium, Green) :: model.balls }, Cmd.none)
    ChangeColor ->
      ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
  div
    [ style "background" "#3C4C60" 
    , style "padding" "30px"
    , style "border-radius" "16px"
    ]
    [ viewControls
    , viewBalls model
    , text model.decodeMessage
    ]

viewControls : Html Msg
viewControls =
 div []
  [ button [ onClick AddBall] [ text "Add Ball" ] ]

viewBalls : Model -> Html Msg
viewBalls model =
  div 
      [ style "display" "flex"
      , style "justify-content" "center"
      , style "align-items" "center"
      , style "padding" "15px"
      ] 
      <| List.map viewBall model.balls 
  
  
viewBall : Ball -> Html Msg
viewBall ball =
  let
   radius = 
       case ball.size of
           Small -> "15px"
           Medium -> "30px"
           Large -> "60px"
           UnknownSize _ -> "30px"
   color =
       case ball.color of
           Red -> "#F67482"
           Green -> "#43CA5E"
           Blue -> "#66B2FF"
           UnknownColor _ -> "#9CA6B0"
  in
    div 
      [ style "background-color" color
      , style "height" radius
      , style "width" radius
      , style "border-radius" "50%"
      , style "display" "inline-block"
      , style "margin" "15px"
      ] 
      []
    
    
    
    
    