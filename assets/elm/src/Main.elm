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
import Maybe.Extra
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Extra as DecodeExtra
import Json.Encode as Encode


-- MAIN

main : Program Decode.Value Model Msg
main =
  Browser.element 
    { init = init
    , view = view 
    , update = update
    , subscriptions = subscriptions
    }


init : Decode.Value -> ( Model, Cmd Msg)
init _ = 
  (Model [] StartedButNoData, (sendMessage elmInitialisedMessage))
  -- (Model [] StartedButNoData, Cmd.none) 

-- MODEL

type alias Model =
  { outsideEventsToParse : List OutsideEvent
  , currentState: CurrentState
  }

type CurrentState
  = StartedButNoData
  | GotMessage String
  | HasData (List Ball) 
  | DecodeError String 

type alias Ball = 
  { id : Int
  , size : BallSize
  , color : BallColor
  }

type BallColor
  = Red
  | Green
  | Blue
  | UnknownColor String

type BallSize
  = Small
  | Medium
  | Large
  | UnknownSize String

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  -- Sub.none
  messageReciever (fromJson >> RecievedMessageFromOutsideElm)


-- PORTS

-- sendMessage will have to change to Json.Encode.Value -> Cmd msg
port sendMessage : MessageForOutside -> Cmd msg
port messageReciever : (Encode.Value -> msg) -> Sub msg

type OutsideEvent
  = NewClientInitialized (List Ball)


fromJson : Decode.Value -> Result Decode.Error OutsideEvent
fromJson =
  Decode.decodeValue outsideEventDecoder

  -- Decode.decodeValue (Decode.list ballDecoder

-- == DECODING ATTEMPT 2 using decoders from the Maybe ==


log : String -> Decode.Decoder a -> Decode.Decoder a
log message =
    Decode.map (Debug.log message)


outsideEventDecoder : Decoder OutsideEvent
outsideEventDecoder =
  eventNameDecoder
  |> Decode.andThen chooseFromEventName

-- Choose an implementation

chooseFromEventName : String -> Decoder OutsideEvent
chooseFromEventName eventName =
  case eventName of
      "new_client_initialised" -> newClientInitializedDecoder
      _ -> Decode.fail ("Unrecognised event name sent to elm: " ++ eventName)

-- Build the OutsideEvent
newClientInitializedDecoder : Decoder OutsideEvent
newClientInitializedDecoder =
  Decode.map NewClientInitialized newClientInitializedEventDataDecoder

newClientInitializedEventDataDecoder : Decoder (List Ball)
newClientInitializedEventDataDecoder =
  Decode.field "event_data" listBallDecoder

-- The ball
listBallDecoder : Decoder (List Ball)
listBallDecoder =
  Decode.list ballDecoder

ballDecoder : Decoder Ball
ballDecoder =
  Decode.map3
    Ball
    (Decode.field "id" Decode.int)
    (Decode.field "size" (Decode.andThen ballSizeDecoder Decode.string))
    (Decode.field "color" (Decode.andThen ballColorDecoder Decode.string))

-- Start with the primitives
eventNameDecoder : Decoder String
eventNameDecoder =
  Decode.field "event_name" Decode.string

ballIdDecoder : Decoder Int
ballIdDecoder =
  Decode.field "id" Decode.int

-- I don't think this is named right? TODO look at how outsideEventDecoder works
ballColorDecoder : String -> Decoder BallColor
ballColorDecoder string =
  case string of
    "red" ->
      Decode.succeed Red
    "green" ->
      Decode.succeed Green
    "blue" ->
      Decode.succeed Blue
    _ ->
      Decode.succeed (UnknownColor string)

ballSizeDecoder : String -> Decoder BallSize
ballSizeDecoder string =
  case string of
    "small" ->
      Decode.succeed Small
    "medium" ->
      Decode.succeed Medium
    "large" ->
      Decode.succeed Large
    _ ->
      Decode.succeed (UnknownSize string)







-- DECODING

-- is : a -> a -> Bool
-- is a b =
--     a == b

-- fromJson : Model -> Decode.Value -> Result Decode.Error Model
-- fromJson model =
--   Decode.decodeValue outsideEvent
--   -- Decode.decodeValue (Decode.list ballDecoder)

-- type OutsideElmEvent
--   = EventNewClientConnected


-- outsideEventName : Decoder OutsideElmEvent
-- outsideEventName =
--   Decode.field "event_name" Decode.string
--     |> Decode.andThen (DecodeExtra.fromResult << outsideEventFromString)


-- outsideEventFromString : String -> Result String OutsideElmEvent
-- outsideEventFromString string =
--   case string of
--       "new_client_connected" -> 
--         Ok EventNewClientConnected

--       _ ->
--         Err ("Unrecongised event sent to Elm: " ++ string)


-- outsideEvent : Decoder Model
-- outsideEvent =
--   Decode.oneOf
--     [ -- DecodeExtra.when outsideEventName (is NewClientConnected) (Decode.list ballDecoder)
--     ]


-- ballDecoder : Decoder Ball
-- ballDecoder =
--   Decode.map3
--     Ball
--     (Decode.field "id" Decode.int)
--     (Decode.field "size" (Decode.andThen ballSizeFromString Decode.string))
--     (Decode.field "color" (Decode.andThen ballColorFromString Decode.string))

  
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
-- ENCODING

type alias MessageForOutside =
  { event: String
  , payload: Maybe String 
  }




-- ENCODING AND DECODING

elmInitialisedMessage : MessageForOutside
elmInitialisedMessage =
  MessageForOutside "new_client_initialised" Nothing






newElmClientInitiliazed : Cmd Msg
newElmClientInitiliazed =
  Cmd.none




-- UPDATE


type Msg
  = ChangeColor
  | AddBall
  | SendMessageToOutsideElm
  | RecievedMessageFromOutsideElm (Result Decode.Error OutsideEvent)

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

    RecievedMessageFromOutsideElm outsideEventResult ->
      case outsideEventResult of
          Ok (NewClientInitialized balls)->
            ( { model | currentState = HasData balls }, Cmd.none )
          
          Err error ->
            ( { model | currentState = DecodeError (Decode.errorToString error)}, Cmd.none)


-- VIEW


view : Model -> Html Msg
view model =
  div
    [ style "background" "#3C4C60" 
    , style "padding" "30px"
    , style "border-radius" "16px"
    ]
    (case model.currentState of
        StartedButNoData ->
          [ text "Loaded but no data. This should go away. "
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
    
    
    
    


-- === DECODING ATTEMPT 2 using maybes ===

-- https://thoughtbot.com/blog/getting-unstuck-with-elm-json-decoders



-- Choose an implementation

maybeOutsideEvent : Maybe OutsideEvent
maybeOutsideEvent =
  maybeEventName
    |> Maybe.andThen chooseFromEventNameMaybeVersion

chooseFromEventNameMaybeVersion : String -> Maybe OutsideEvent
chooseFromEventNameMaybeVersion eventName =
  case eventName of
      "new_client_initialised" -> maybeNewClientInitialized 
      _ -> Nothing

-- Build the OutsideEvent
maybeNewClientInitialized : Maybe OutsideEvent
maybeNewClientInitialized =
  Maybe.map NewClientInitialized maybeListBall

-- The ball
maybeListBall : Maybe (List Ball)
maybeListBall =
  Just (Maybe.Extra.values [maybeBall])

maybeBall : Maybe Ball
maybeBall =
  Maybe.map3 Ball maybeBallId maybeBallSize maybeBallColor

-- Start with the primitives
maybeEventName : Maybe String
maybeEventName =
  Just "new_client_initialised"

maybeBallId : Maybe Int
maybeBallId =
  Just 1

maybeBallColor : Maybe BallColor
maybeBallColor =
  Just Red

maybeBallSize : Maybe BallSize
maybeBallSize =
  Just Small

 