port module Main exposing (..)

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


-- PORTS

port sendMessage : MessageForOutside -> Cmd msg
port messageReciever : (String -> msg) -> Sub msg

type alias MessageForOutside =
  { event: String
  , payload: Maybe String 
  }

elmInitialisedMessage : MessageForOutside
elmInitialisedMessage =
  MessageForOutside "new_client_initialised" Nothing


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions _ =
  messageReciever RecievedMessageFromOutsideElm

-- I NEED TO TRIGGER A CALL HERE. HOW?
-- Look at https://elmprogramming.com/retrieving-data-on-initialization.html
-- https://discourse.elm-lang.org/t/how-call-multiple-endpoint-when-the-page-is-rendered/5985/2

-- MODEL


type Model 
  = StartedButNoData
  | GotMessage String
  | HasData (List Ball) 
  | DecodeError String 

-- JSON is just an array, whereas our model has a record at top level
fromJson : Decode.Value -> Result Decode.Error (List Ball)
fromJson =
  Decode.decodeValue (Decode.list ballDecoder)


init : Decode.Value -> ( Model, Cmd Msg)
init _ = 
  -- (StartedButNoData, (sendMessage "elm_client_intialised"))
  (StartedButNoData, Cmd.none) 


newElmClientInitiliazed : Cmd Msg
newElmClientInitiliazed =
  Cmd.none


decodeMessage : Decode.Value -> Model
decodeMessage json = 
  case fromJson json of
    Ok balls ->
      HasData balls
    
    Err reason ->
      DecodeError (Decode.errorToString reason)


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
  | SendMessageToOutsideElm
  | RecievedMessageFromOutsideElm String

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    AddBall ->
      ( model, Cmd.none )
        -- ( { model | balls  = (Medium, Green) :: model.balls }, Cmd.none)

    ChangeColor ->
      ( model, Cmd.none )

    SendMessageToOutsideElm ->
      ( model, sendMessage elmInitialisedMessage)

    RecievedMessageFromOutsideElm message ->
      ( GotMessage message, Cmd.none)


-- VIEW


view : Model -> Html Msg
view model =
  div
    [ style "background" "#3C4C60" 
    , style "padding" "30px"
    , style "border-radius" "16px"
    ]
    (case model of
        StartedButNoData ->
          [ text "Loaded but no data"
          , button [ onClick SendMessageToOutsideElm ] [text "test"]
          ]
        HasData balls  ->
          [ viewControls
          , viewBalls balls
          ]
        DecodeError errorMessage ->
          [ text errorMessage 
          ]
        GotMessage message ->
          [ text ( message ++ " :) " )
          ]
    )

viewControls : Html Msg
viewControls =
 div []
  [ button [ onClick AddBall] [ text "Add Ball" ] ]

viewBalls : List Ball -> Html Msg
viewBalls balls =
  div 
      [ style "display" "flex"
      , style "justify-content" "center"
      , style "align-items" "center"
      , style "padding" "15px"
      ] 
      <| List.map viewBall balls 
  
  
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
    
    
    
    
    